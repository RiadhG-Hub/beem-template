import 'package:flutter/material.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:momra/core/util/ecryption_to_arabic.dart';

class AdvisorItem extends StatelessWidget {
  final String advisorName;
  final String advisorId;
  final ValueChanged<String> onSelected;
  final bool isSelected;
  const AdvisorItem(this.advisorName, this.advisorId,
      {super.key, required this.onSelected, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onSelected(advisorId);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.greenTwo : AppColors.greyLite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0,
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 1.5,
        ),
      ),
      child: Text(
        decryptArabic(
          advisorName,
        ),
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }
}
