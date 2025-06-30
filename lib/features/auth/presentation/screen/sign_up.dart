import 'package:beemwidget/beem_buttons_styles/beem_button_styles.dart';
import 'package:beemwidget/beem_text_field_styles/beem_text_field_styles.dart';
import 'package:beemwidget/text_styles/beem_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/assets.gen.dart';

/// SignUp screen responsible for collecting user's phone number
/// and animating the UI on mount. This screen uses custom-styled
/// BeemWidgets and includes slide & fade-in animation.
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  /// Controller for phone number input field
  final TextEditingController phoneNumberController = TextEditingController();

  /// Focus node to programmatically focus on the input field
  final FocusNode phoneFocusNode = FocusNode();

  /// Animation controller for fade and slide transitions
  late final AnimationController _controller;

  /// Slide animation to move content vertically on mount
  late final Animation<Offset> _slideAnimation;

  /// Fade animation to fade content in on mount
  late final Animation<double> _fadeAnimation;

  /// Indicates if the next button is loading
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward().whenComplete(() {
      // Automatically focus on the phone input field after animation
      FocusScope.of(context).requestFocus(phoneFocusNode);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    phoneNumberController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  /// Triggers loading and validates phone number input length
  void _handleNext() {
    if (phoneNumberController.text.trim().length == 8) {
      setState(() {
        _isLoading = true;
      });

      // TODO: Trigger OTP request or navigate to next screen
    }
  }

  /// Determines if the next button should be enabled
  bool get _isPhoneValid => phoneNumberController.text.trim().length == 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 32.sp).copyWith(top: 50.sp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Logo
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.sp),
                    child: Assets.images.iconLogo.image(
                      height: 53.sp,
                      width: 37.sp,
                    ),
                  ),

                  /// Instruction Text
                  Padding(
                    padding: EdgeInsets.only(bottom: 18.sp),
                    child: Text(
                      "Enter your phone number to receive a one-time verification code",
                      style: BeemTextStyles.poppinsMedium15,
                    ),
                  ),

                  /// Phone Number Input Field
                  Padding(
                    padding: EdgeInsets.only(bottom: 18.sp),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: BeemOutlinedTextField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        focusNode: phoneFocusNode,
                        onChanged: (_) => setState(() {}),
                        style: BeemTextFieldStyle(
                          hintText: 'Mobile number',
                          prefix: Padding(
                            padding: EdgeInsets.only(right: 12.sp),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Assets.images.img.image(),
                                const Icon(Icons.keyboard_arrow_down),
                                Text('+216',
                                    style: BeemTextStyles.poppinsMedium14),
                              ],
                            ),
                          ),
                          isRequired: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      /// Terms and Next Button Section
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Terms & Privacy Notice
            Padding(
              padding: EdgeInsets.only(bottom: 32.sp),
              child: Text(
                "By continuing you acknowledge having read and accepted the Terms & Conditions and Privacy policy",
                style: BeemTextStyles.poppinsMedium13,
                textAlign: TextAlign.center,
              ),
            ),

            /// Next Button
            Padding(
              padding: EdgeInsets.only(bottom: 22.sp),
              child: BeemButtonsStyles.defaultButton(
                label: 'Next',
                backgroundColor: const Color(0xff7A3BFF),
                onPressed: _handleNext,
                isLoading: _isLoading,
                isDisabled: !_isPhoneValid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
