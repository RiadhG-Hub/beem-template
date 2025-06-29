/// {@category theme}
library;

import 'package:flutter/material.dart';
import 'package:momra/core/theme/styles.dart';

import 'colors.dart';

/// These are the themes for the app.
var appBarTheme = AppBarTheme(
  backgroundColor: Colors.white,
  titleTextStyle: TextStyles.headLineSixTextStyle.copyWith(
    color: Colors.black,
  ),
  elevation: 0.0,
);

var elevatedButtonThemeData = const ElevatedButtonThemeData();

const TabBarTheme tabBarTheme = TabBarTheme();

var inputDecorationTheme = InputDecorationTheme(
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: AppColors.textFiledBorderColor,
    ),
    borderRadius: BorderRadius.circular(16.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: AppColors.textFiledBorderColor,
    ),
    borderRadius: BorderRadius.circular(16.0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      width: 1,
      color: AppColors.textFiledBorderColor,
    ),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      width: 1,
      color: AppColors.textFiledBorderColor,
    ),
  ),
);

InputDecoration underlineInputBorder({String? label, Widget? icon}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    label: label == null
        ? null
        : Text(
            label,
            style: TextStyles.subtitleOneTextStyle,
          ),
    suffixIcon: icon,
    border: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.formSideColor)),
    focusedBorder:
        const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.formSideColor)),
    errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.formSideColor)),
    disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.formSideColor)),
  );
}
