/// {@category theme}
library;

import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(0, 0, 0, .1),
  100: const Color.fromRGBO(0, 0, 0, .2),
  200: const Color.fromRGBO(0, 0, 0, .3),
  300: const Color.fromRGBO(0, 0, 0, .4),
  400: const Color.fromRGBO(0, 0, 0, .5),
  500: const Color.fromRGBO(0, 0, 0, .6),
  600: const Color.fromRGBO(0, 0, 0, .7),
  700: const Color.fromRGBO(0, 0, 0, .8),
  800: const Color.fromRGBO(0, 0, 0, .9),
  900: const Color.fromRGBO(0, 0, 0, 1),
};

/// This class defines All the Colors of the app.
class AppColors {
  static MaterialColor primarySwatchColor =
      MaterialColor(Colors.black.value, color);
  static const Color primaryGreen = Color(0xFF0A6B67);
  static const Color titleFieldColor = Color(0xFF366967);
  static const Color greenOne = Color(0xFF17AD87);
  static const Color greenTwo = Color(0xFF86B726);
  static const Color greenThree = Color(0xFFD2E3AF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF5D5D5D);
  static const Color greyLight = Color(0xFFF9F9F9);
  static const Color red = Color(0xFFFF0000);
  static const Color greyLite = Color(0xFFF1F1F1);

  static ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0A6B67), // primaryGreen
    onPrimary: Color(0xFFFFFFFF), // white text on primary
    secondary: Color(0xFF17AD87), // greenOne
    onSecondary: Color(0xFFFFFFFF), // white text on secondary
    error: Color(0xFFFF0000), // red
    onError: Color(0xFFFFFFFF), // white text on error
    surface: Color(0xFFFFFFFF), // greenThree
    onSurface: Color(0xFF000000), // black text on surface
  );

  static const Color buttonColor = Color(0xFF000000);
  static const Color textFiledBorderColor = Color(0xFFE1E1E1);
  static const Color textFiledHintTextColor = Color(0xFF807A7A);
  static const Color textFiledTextColor = Color(0xFF1A1A1A);
  static const Color greyColor = Color(0xffD9D9D9);
  static const Color bodyTextGreyColor = Color(0xff828282);
  static const Color formSideColor = Color(0xffcecece);
  static const Color paymentMethodeBackgroundItem = Color(0xffefefef);
  static const Color fieldBorderColor = Color(0xffededed);
  static const Color ticketItemColor = Color(0xffF4F4F4);

  ///NEW

  static const Color primary0 = Color(0xFF130A00);
  static const Color primary10 = Color(0xFFB25B00);
  static const Color primary30 = Color(0xFFCA6F00);
  static const Color primary40 = Color(0xFFE37E04);
  static const Color primary50 = Color(0xFFE0860E);
  static const Color primary60 = Color(0xFFFF9911);
  static const Color primary70 = Color(0xccff9911);
  static const Color primary80 = Color(0xFFFFC270);
  static const Color primary90 = Color(0xFFFFD6A0);
  static const Color primary95 = Color(0xFFFFEBCF);
  static const Color primary99 = Color(0xFFFFF5E9);
  static const Color primary100 = Color(0xFFFFFCF9);

  static const Color neutral0 = Color(0xFF000000);
  static const Color neutral10 = Color(0xFF1D1B20);
  static const Color neutral20 = Color(0xFF48464C);
  static const Color neutral30 = Color(0xFF48464C);
  static const Color neutral40 = Color(0xFF605D64);
  static const Color neutral50 = Color(0xFF79767D);
  static const Color neutral60 = Color(0xFF938F96);
  static const Color neutral70 = Color(0xFFAEA9B1);
  static const Color neutral80 = Color(0xFFCAC5CD);
  static const Color neutral90 = Color(0xFFFAF4EC);
  static const Color neutral95 = Color(0xFFFFFEFC);
  static const Color neutral100 = Color(0xFFFFFFFF);

  static const Color bgColor = Color(0xff1E1E23);
  static const primaryGradiant = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xffd54836), Color(0xff7c0080), Color(0xff2d1069)],
    ),
  );
}
