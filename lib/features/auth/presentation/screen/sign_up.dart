import 'package:beemwidget/beem_buttons_styles/beem_button_styles.dart';
import 'package:beemwidget/beem_text_field_styles/beem_text_field_styles.dart';
import 'package:beemwidget/text_styles/beem_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final TextEditingController phoneNumberController = TextEditingController();
  bool _isLoading = false;
  final FocusNode phoneFocusNode = FocusNode();

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

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
      // Focus the text field after animation completes
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: EdgeInsets.only(top: 50.sp, right: 32.sp, left: 32.sp),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.sp),
                    child: Image.asset(
                      "assets/icon_logo.png",
                      height: 53.sp,
                      width: 37.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 18.sp),
                  child: Text(
                    "Enter your phone number to receive a one-time verification code",
                    style: BeemTextStyles.poppinsMedium15,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 18.sp),
                  child: BeemOutlinedTextField(
                    keyboardType: TextInputType.phone,
                    focusNode: phoneFocusNode,
                    onChanged: (value) {
                      setState(() {});
                    },
                    style: BeemTextFieldStyle(
                      hintText: 'Mobile number',
                      prefix: Padding(
                        padding: EdgeInsets.only(right: 12.sp),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/img.png"),
                            const Icon(Icons.keyboard_arrow_down),
                            Text('+216', style: BeemTextStyles.poppinsMedium14),
                          ],
                        ),
                      ),
                      isRequired: true,
                    ),
                    controller: phoneNumberController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 32.sp),
              child: Text(
                "By continuing you acknowledge having read and accepted the Terms & Conditions and Privacy policy",
                style: BeemTextStyles.poppinsMedium13,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 22.sp),
              child: BeemButtonsStyles.defaultButton(
                label: 'Next',
                backgroundColor: const Color(0xff7A3BFF),
                onPressed: () {
                  if (phoneNumberController.text.length == 8) {
                    setState(() {
                      _isLoading = true;
                    });
                  }
                },
                isLoading: _isLoading,
                isDisabled: phoneNumberController.text.length != 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
