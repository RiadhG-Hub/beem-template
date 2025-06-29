import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:momra/core/db_config/dio_interceptor.dart';
import 'package:momra/features/auth/data/data_source/auth_cached_data_source.dart';
import 'package:momra/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:momra/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:momra/features/send_instructions/presentation/bloc/collect_instruction_cubit/collect_instruction_cubit_cubit.dart';
import 'package:momra/gen/assets.gen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core/router/router.dart';
import 'injectables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _pulseAnimation;
  late final AnimationController _textController;

  bool isError = false;

  @override
  void initState() {
    super.initState();
    try {
      _initAnimations();
      _startSplashLogic();
    } catch (e) {
      _showUnknownUserTypeDialog();
    }
  }

  void _initAnimations() {
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
  }

  void _startSplashLogic() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      if (_logoController.isAnimating) {
        _logoController.stop();
      }

      try {
        final authDataSource = await getIt.getAsync<AuthDataSource>();
        final authCachedDataSource =
            await getIt.getAsync<AuthCachedDataSource>();
        final tokenManager = await getIt.getAsync<TokenManager>();

        final versionInfo = await authDataSource.checkAppVersion();

        final remoteVersion = versionInfo.VNumber;
        final updateType = int.parse(versionInfo.Type);
        final updateLink = versionInfo.Link;

        final currentVersion = (await PackageInfo.fromPlatform()).version;

        if (updateType == 1) {
          _showMaintenanceDialog();
          return;
        }

        if (_isNewerVersion(remoteVersion, currentVersion)) {
          _showUpdateDialog(updateLink);
          return;
        }

        final userModel = await authCachedDataSource.getAuthModel();
        if (userModel == null) {
          context.pushReplacement(AppRoutes.loginPage);
          return;
        }
        final authenticationBloc = await getIt.getAsync<AuthenticationBloc>();
        authenticationBloc.user = userModel;
        final collectionCubit = getIt.get<CollectInstructionCubit>();
        collectionCubit.advisors = userModel.usersList ?? [];

        final token = await tokenManager.getToken();
        if (token != userModel.token) {
          await tokenManager.sharedPreferences.clear();
          tokenManager.saveToken(userModel.token!);
        }

        switch (userModel.usertype) {
          case "minister":
            context.pushReplacement(AppRoutes.sendInstructionPage);
            break;
          case "advisor":
            context.pushReplacement(AppRoutes.receiveInstructionPage);
            break;
          default:
            _showUnknownUserTypeDialog();
        }
      } catch (e) {
        _showErrorDialog(e.toString());
      }
    });
  }

  bool _isNewerVersion(String remote, String local) {
    final remoteParts = remote.split('.').map(int.parse).toList();
    final localParts = local.split('.').map(int.parse).toList();

    for (int i = 0; i < remoteParts.length; i++) {
      if (i >= localParts.length || remoteParts[i] > localParts[i]) {
        return true;
      } else if (remoteParts[i] < localParts[i]) {
        return false;
      }
    }
    return false;
  }

  Future<void> _showMaintenanceDialog() async {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text("الصيانة جارية"),
        content: Text("التطبيق حالياً تحت الصيانة. يرجى المحاولة لاحقاً."),
      ),
    );
  }

  Future<void> _showUpdateDialog(String link) async {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("تحديث مطلوب"),
        content:
            const Text("يرجى تحديث هذا التطبيق بالانتقال إلى الرابط المقدم."),
        actions: [
          TextButton(
            onPressed: () async {
              final uri = Uri.parse(link);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("لا يمكن فتح الرابط.")),
                );
              }
            },
            child: const Text("افتح الرابط"),
          ),
        ],
      ),
    );
  }

  Future<void> _showUnknownUserTypeDialog() async {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("خطأ"),
        content: const Text("نوع المستخدم غير معرف"),
        actions: [
          TextButton(
            onPressed: () async {
              final tokenManager = await getIt.getAsync<TokenManager>();
              await tokenManager.sharedPreferences.clear();
              if (mounted) {
                Navigator.of(context).pop();
                setState(() {
                  isError = true;
                });
              }
            },
            child: const Text("حسناً"),
          ),
        ],
      ),
    );
  }

  Future<void> _showErrorDialog(String message) async {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("خطأ "),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                isError = true;
              });
            },
            child: const Text("حسناً"),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: child,
        );
      },
      child: Assets.svg.momraImage.svg(
        fit: BoxFit.scaleDown,
        width: 180.sp,
        height: 180.sp,
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00695C), Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnimatedLogo(),
            SizedBox(height: 30.h),
            if (isError)
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isError = false;
                  });
                  // final SettingsCachedDataSource cachedDataSource =
                  //     getIt<SettingsCachedDataSource>();
                  // await cachedDataSource.clearBaseUrl();
                  // if (context.mounted) {
                  //   await context.read<SettingsCubit>().fetchBaseUrl();
                  // }

                  _startSplashLogic();
                },
                child: const Text("إعادة المحاولة"),
              ),
          ],
        ),
      ),
    );
  }
}
