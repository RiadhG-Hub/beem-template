/// {@category theme}
library;

import 'package:flutter/material.dart';
import 'package:momra/core/consts/app_consts.dart';

import 'doubles.dart';

extension TextStyles on String {
  static const headLineFiveTextStyle = TextStyle(
    fontSize: headLineFiveTextSize,
    fontWeight: FontWeight.w500,
  );
  get headLineFiveText => Text(this, style: headLineFiveTextStyle);

  static const headLineSixTextStyle = TextStyle(
    fontSize: headLineSixTextSize,
    fontWeight: FontWeight.w500,
  );
  get headLineSixText => Text(this, style: headLineSixTextStyle);

  static const subtitleOneTextStyle = TextStyle(
    fontSize: subtitleOneTextSize,
    fontWeight: FontWeight.w500,
  );
  get subtitleOneText => Text(this, style: subtitleOneTextStyle);

  static const subtitleTowTextStyle = TextStyle(
    fontSize: subtitleTowTextSize,
    fontWeight: FontWeight.w500,
  );
  get subtitleTowText => Text(this, style: subtitleTowTextStyle);

  static const lightHeaderTextStyle = TextStyle(
    fontSize: lightHeaderTextSize,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );
  get lightHeaderText => Text(this, style: lightHeaderTextStyle);
  static const bodyTextSTextStyle = TextStyle(
      fontSize: bodyTextSTextSize,
      fontWeight: FontWeight.w400,
      height: 21 / bodyTextSTextSize,
      letterSpacing: 0.25);
  get bodyTextSText => Text(this, style: bodyTextSTextStyle);

  static const bodyTextMTextStyle = TextStyle(
    fontSize: bodyTextMTextSize,
    fontWeight: FontWeight.w400,
  );
  get bodyTextMText => Text(this, style: bodyTextMTextStyle);

  static const buttonSTextStyle = TextStyle(
      fontSize: buttonSTextSize,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25);
  get buttonSText => Text(this, style: buttonSTextStyle);

  static const buttonLTextStyle = TextStyle(
    fontSize: buttonLTextSize,
    fontWeight: FontWeight.w600,
  );

  static const titleSTextStyle = TextStyle(
    fontSize: titleSTextSize,
    fontWeight: FontWeight.w600,
  );
  get buttonLText => Text(this, style: buttonLTextStyle);

  static const captionSTextStyle = TextStyle(
      fontSize: captionTextSize,
      fontWeight: FontWeight.w300,
      height: 18 / captionTextSize);
  get captionText => Text(this, style: captionSTextStyle);

  // NEW

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: AppConsts.appFontFamily,
    fontSize: 24,
    height: 22 / 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: AppConsts.appFontFamily,
    fontSize: 20,
    height: 22 / 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: AppConsts.appFontFamily,
    fontSize: 18,
    height: 20 / 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: AppConsts.appFontFamily,
    fontSize: 20,
    height: 18 / 20,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: AppConsts.appFontFamily,
    fontSize: 16,
    height: 18 / 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: AppConsts.appFontFamily,
    fontSize: 14,
    height: 16 / 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: AppConsts.appFontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: AppConsts.appFontFamily,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: AppConsts.appFontFamily,
    fontSize: 12,
    height: 16 / 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: AppConsts.appFontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: AppConsts.appFontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: AppConsts.appFontFamily,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );
}

/// This class defines All the Buttons of the app.

/// This class defines All the Containers of the app.
class Containers {}
