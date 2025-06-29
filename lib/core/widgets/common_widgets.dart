import 'package:flutter/material.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:momra/core/widgets/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CommonWidget {
  static getSnackBar(BuildContext context,
      {required String message,
      Color color = AppColors.greenOne,
      Color colorText = Colors.white,
      int duration = 2,
      double height = 0.2}) {
    showTopSnackBar(
      displayDuration: Duration(seconds: duration),
      Overlay.of(context),
      CustomSnackBar.info(
        backgroundColor: color,
        message: message,
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: colorText,
        ),
        secondaryColor: colorText,
      ),
    );
  }
}
