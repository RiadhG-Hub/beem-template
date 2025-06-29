import 'package:beemwidget/beem_colors/beem_colors.dart';
import 'package:beemwidget/text_styles/beem_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpInputField extends StatefulWidget {
  const OtpInputField({super.key});

  @override
  OtpInputFieldState createState() => OtpInputFieldState();
}

class OtpInputFieldState extends State<OtpInputField> {
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpBox(int index) {
    return Container(
      height: 0.08.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.sp),
        boxShadow: [
          BoxShadow(
            color: BeemColors.defaultButtonDisabledColor,
            offset: Offset(0, 4.sp),
            blurRadius: 3.sp,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SizedBox(
        width: 0.15.sw,
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          style: BeemTextStyles.poppinsBold18.copyWith(
            color: const Color(0xffBDBDBD),
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0.sp, color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0.sp, color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0.sp, color: Colors.transparent),
            ),
          ),
          onChanged: (value) {
            if (value.isNotEmpty && index < 3) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else if (value.isEmpty && index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) => _buildOtpBox(index)),
    );
  }
}
