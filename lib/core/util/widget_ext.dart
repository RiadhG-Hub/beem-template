import 'package:flutter/cupertino.dart';

extension WidgetExt on Widget {
  Widget padding({double v = 0, double h = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: v, horizontal: h),
      child: this,
    );
  }

  Widget paddingOnly({double r = 0, double l = 0, double t = 0, double b = 0}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(l, t, r, b),
      child: this,
    );
  }

  Widget scaleDown({Alignment alignment = Alignment.centerRight}) {
    return FittedBox(
      alignment: alignment,
      fit: BoxFit.scaleDown,
      child: this,
    );
  }

  CupertinoPage cupertinoPageWrapper({required LocalKey key}) {
    return CupertinoPage(key: key, child: this);
  }
}
