import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momra/core/router/router.dart';
import 'package:momra/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:momra/features/auth/presentation/widgets/captcha_widget.dart';

class VerifyCaptchaPage extends StatefulWidget {
  const VerifyCaptchaPage({super.key});

  @override
  State<VerifyCaptchaPage> createState() => _VerifyCaptchaPageState();
}

class _VerifyCaptchaPageState extends State<VerifyCaptchaPage> {
  final TextEditingController _captchaController = TextEditingController();
  int _attempts = 0;
  bool _isLocked = false;

  @override
  void dispose() {
    _captchaController.dispose();
    super.dispose();
  }

  void _handleCaptchaVerification(String input) {
    if (_attempts >= 3) {
      setState(() {
        _attempts = 0;
        context.read<AuthenticationBloc>().add(
              //address and password already stored in the bloc
              GenerateCaptchaEvent(
                  userName: null, password: null, rememberMe: false),
            );
      });
    } else {
      context.read<AuthenticationBloc>().add(
            VerifyCaptchaEvent(captcha: input),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final captchaString =
        context.read<AuthenticationBloc>().generateCaptchaResult!.CaptchaString;

    return Scaffold(
      appBar: AppBar(
        title: const Text("تحقق من الكابتشا"),
        leading: IconButton(
            onPressed: () {
              context.push(AppRoutes.loginPage);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is VerifyCaptchaSuccess) {
            context.goNamed(AppRoutes.verifyOtpPage);
          } else if (state is VerifyCaptchaFailed) {
            setState(() {
              _attempts += 1;
              if (_attempts >= 3) {
                _isLocked = true;
              }
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text("محاولة خاطئة ($_attempts/3): ${state.message}")),
            );
          }
        },
        builder: (context, state) {
          if (state is VerifyCaptchaLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CaptchaWidget(base64String: captchaString),
                const SizedBox(height: 16),
                TextField(
                  controller: _captchaController,
                  decoration: const InputDecoration(
                    labelText: "أدخل رمز الكابتشا",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final input = _captchaController.text.trim();
                    _handleCaptchaVerification(input);
                  },
                  child: Text("تحقق"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
