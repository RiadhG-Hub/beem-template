import 'package:flutter/material.dart';
import 'package:momra/core/util/size_config.dart';

//* Vertical Spacers
Widget smallVerticalSpacer = Builder(builder: (context) {
  return SizedBox(
    height: SizeConfig.blockSizeVertical * 2,
  );
});

Widget smallXVerticalSpacer = Builder(
  builder: (context) => SizedBox(
    height: SizeConfig.blockSizeVertical * 3,
  ),
);

Widget miniVerticalSpacer = Builder(
  builder: (context) => SizedBox(
    height: SizeConfig.blockSizeVertical,
  ),
);

Widget miniXVerticalSpacer = Builder(
  builder: (context) => SizedBox(
    height: SizeConfig.blockSizeVertical * 0.5,
  ),
);

Widget mediumVerticalSpacer = Builder(
  builder: (context) => SizedBox(height: SizeConfig.blockSizeVertical * 4),
);

Widget mediumXVerticalSpacer = Builder(
  builder: (context) => SizedBox(
    height: SizeConfig.blockSizeVertical * 5,
  ),
);

Widget largeVerticalSpacer = Builder(
  builder: (context) => SizedBox(height: SizeConfig.blockSizeVertical * 6),
);

Widget largeXVerticalSpacer = Builder(
  builder: (context) => SizedBox(
    height: SizeConfig.blockSizeVertical * 7,
  ),
);

//* Horizontal Spacers
Widget miniHorizontalSpacer = Builder(
  builder: (context) => SizedBox(
    width: SizeConfig.blockSizeHorizontal,
  ),
);

Widget largeHorizontalSpacer = Builder(
  builder: (context) => SizedBox(width: SizeConfig.blockSizeHorizontal * 6),
);

Widget largeXHorizontalSpacer = Builder(
  builder: (context) => SizedBox(
    width: SizeConfig.blockSizeHorizontal * 7,
  ),
);
Widget smallHorizontalSpacer = Builder(
  builder: (context) => SizedBox(
    width: SizeConfig.blockSizeHorizontal * 2,
  ),
);

Widget smallXHorizontalSpacer = Builder(
  builder: (context) => SizedBox(
    width: SizeConfig.blockSizeHorizontal * 3,
  ),
);

Widget mediumHorizontalSpacer = Builder(
  builder: (context) => SizedBox(
    width: SizeConfig.blockSizeHorizontal * 4,
  ),
);

Widget mediumXHorizontalSpacer = Builder(
  builder: (context) => SizedBox(
    width: SizeConfig.blockSizeHorizontal * 5,
  ),
);
