import 'package:beem/features/auth/presentation/widgets/otp_field.dart';
import 'package:beemwidget/beem_buttons_styles/beem_button_styles.dart';
import 'package:beemwidget/beem_colors/beem_colors.dart';
import 'package:beemwidget/text_styles/beem_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpCode extends StatefulWidget {
  const OtpCode({super.key});

  @override
  State<OtpCode> createState() => _OtpCodeState();
}

class _OtpCodeState extends State<OtpCode> with SingleTickerProviderStateMixin {
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
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Phone verification ",
                      style: BeemTextStyles.poppinsBold24,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8.sp,
                      children: [
                        Text(
                          "Enter OTP sent to",
                          style: BeemTextStyles.poppinsMedium15,
                        ),
                        Text("******", style: BeemTextStyles.poppinsBold21),
                        Text("41", style: BeemTextStyles.poppinsBold21),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 22),
                  child: OtpInputField(),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8.sp,
                  children: [
                    Text(
                      "Resend Code in",
                      style: BeemTextStyles.poppinsRegular12,
                    ),
                    Text(
                      "20 seconds",
                      style: BeemTextStyles.poppinsBold12.copyWith(
                        color: BeemColors.defaultButtonColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.sp),
        child: Padding(
          padding: EdgeInsets.only(bottom: 22.sp),
          child: BeemButtonsStyles.defaultButton(
            label: 'Verify',
            backgroundColor: const Color(0xff7A3BFF),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
            },
            isLoading: _isLoading,
            isDisabled: false,
          ),
        ),
      ),
    );
  }
}
