import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:momra/core/widgets/custom_button.dart';
import 'package:momra/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:momra/features/auth/presentation/cubit/user_credentials/user_credentials_cubit.dart';
import 'package:momra/features/auth/presentation/cubit/user_credentials/user_credentials_state.dart';
import 'package:momra/features/auth/presentation/widgets/custom_auth_text_form_field.dart';
import 'package:momra/l10n/l10n.dart';

import "../../../../gen/assets.gen.dart" show Assets;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

//user advisor = "user888"
  //password  = "advisor"
  //minister = "user999"

  //final emailController = TextEditingController(text: "rberkachy1");
  //final passwordController = TextEditingController(text: '123456789');
  //final emailController = TextEditingController(text: "mnoah");
  //final passwordController = TextEditingController(text: '123456');

  //final emailController = TextEditingController(text: "ichamly");
  //final passwordController = TextEditingController(text: "ic@Intalio2025");

  //final emailController = TextEditingController(text: "marafat");
  //final passwordController = TextEditingController(text: '123456789');

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscureText = true;
  bool _rememberMe = true;
  bool _showSave = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<UserCredentialsCubit>();
      cubit.fetchSavedUserCredentials();
      print("fetching user data ");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 0.25.sh,
              child: Assets.svg.momraImage.svg(
                fit: BoxFit.scaleDown,
                width: 0.8.sw,
              ),
            ),
            Container(
              height: 0.75.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(40.sp)),
                image: DecorationImage(
                  image: AssetImage(Assets.images.palm.path),
                  alignment: Alignment.centerLeft,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.sp),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: IconButton(
                        //       onPressed: () {
                        //         context.pushNamed(AppRoutes.settingViewPage);
                        //       },
                        //       icon: Icon(Icons.settings)),
                        // ),
                        SizedBox(height: 0.1.sh),
                        _buildLabel(context.l10n.userName),
                        SizedBox(height: 10.sp),
                        CustomAuthTextFormField(
                            controller: emailController,
                            hintText: context.l10n.userName),
                        SizedBox(height: 34.sp),
                        _buildLabel(context.l10n.passwrord),
                        SizedBox(height: 10.sp),
                        CustomAuthTextFormField(
                          controller: passwordController,
                          obscureText: _obscureText,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.grey,
                              size: 18.sp,
                            ),
                            onPressed: () {
                              setState(() => _obscureText = !_obscureText);
                            },
                          ),
                          hintText: context.l10n.passwrord,
                        ),
                        SizedBox(height: 56.sp),
                        _buildRememberMeSwitch(),
                        SizedBox(height: 28.sp),
                        SizedBox(width: 0.5.sw, child: _buildLoginButton()),
                        SizedBox(height: 14.sp),
                        _savedUserCredentials()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.titleFieldColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildRememberMeSwitch() {
    final l10n = context.l10n;

    return Row(
      children: [
        Text(
          l10n.remember_user_name,
          style: TextStyle(
            color: AppColors.titleFieldColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 12.sp),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(3.14159),
          child: Switch(
            value: _rememberMe,
            onChanged: (value) => setState(() => _rememberMe = value),
            thumbColor: WidgetStateProperty.all(AppColors.greenTwo),
            trackColor: WidgetStateProperty.resolveWith((states) =>
                states.contains(WidgetState.selected)
                    ? AppColors.greenThree
                    : AppColors.greyLite),
            trackOutlineColor: WidgetStateProperty.all(AppColors.greyLite),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }

  Widget _savedUserCredentials() {
    final l10n = context.l10n;
    return BlocBuilder<UserCredentialsCubit, UserCredentialsState>(
      builder: (context, state) {
        if ((state.userCredentials == null) || !_showSave) {
          return SizedBox.shrink();
        } else {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${l10n.continue_as} "),
              TextButton(
                onPressed: () {
                  setState(() {
                    _showSave = false;
                    emailController.text = state.userCredentials!.userName;
                    passwordController.text = state.userCredentials!.password;
                  });
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  state.userCredentials!.userName,
                  style: TextStyle(
                    color: AppColors.greenTwo,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget _buildLoginButton() {
    final l10n = context.l10n;

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is GenerateCaptchaSuccess) {
          // context.push(AppRoutes.verifyCaptchaPage);
        }
      },
      builder: (context, state) {
        if (state is GenerateCaptchaLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.greenTwo,
          ));
        }

        return Column(
          children: [
            if (state is GenerateCaptchaFailed)
              Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            SizedBox(height: 8.sp),
            CustomButton(
              //height: 52.sp,
              text: l10n.login,
              onPressed: () {
                context.read<AuthenticationBloc>().add(
                      GenerateCaptchaEvent(
                          userName: emailController.text,
                          password: passwordController.text,
                          rememberMe: _rememberMe),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
