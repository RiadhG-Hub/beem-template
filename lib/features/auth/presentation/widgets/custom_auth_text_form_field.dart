import 'package:flutter/material.dart';
import 'package:momra/core/theme/colors.dart';

class CustomAuthTextFormField extends StatelessWidget {
  const CustomAuthTextFormField(
      {super.key,
      required this.controller,
      this.obscureText = false,
      this.suffixIcon,
      required this.hintText});
  final bool obscureText;
  final TextEditingController controller;
  final IconButton? suffixIcon;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // Background color
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // Shadow color
            blurRadius: 8, // How soft the shadow is
            offset: Offset(0, 2), // Position of shadow
          ),
        ],
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          suffixIcon: suffixIcon,
          fillColor: AppColors.greyLight,
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onSaved: (String? value) {},
      ),
    );
  }
}
