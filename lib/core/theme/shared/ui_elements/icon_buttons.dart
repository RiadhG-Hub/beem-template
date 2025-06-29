import 'package:flutter/material.dart';
import 'package:momra/core/theme/colors.dart';

class IconButtons {
  static Container primaryIconButton({
    void Function()? onPressed,
    IconData? icon,
    Color? iconColor,
    Color? backgroundColor,
    Color? splashColor,
    Widget? child,
    BoxBorder? border,
    bool isWidget = false,
    bool outlined = false,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(16.0),
  }) {
    return Container(
      decoration: BoxDecoration(
        border: outlined
            ? border != null
                ? Border.all(
                    width: 1,
                    color: onPressed == null
                        ? Colors.grey[300] ?? Colors.transparent
                        : AppColors.neutral0,
                  )
                : border
            : null,
        shape: BoxShape.circle,
        color: onPressed == null
            ? !outlined
                ? backgroundColor != null
                    ? Colors.grey[300] ?? Colors.transparent
                    : Colors.transparent
                : Colors.transparent
            : backgroundColor,
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     const Color(0x00FFFFFF),
        //     const Color(0xffFFFFFF),
        //     const Color(0x00FFFFFF).withOpacity(0.57)
        //   ],
        // ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          splashColor:
              splashColor, // Set the splash color for the entire InkWell
          borderRadius: BorderRadius.circular(
            50.0,
          ), // Set the same radius as the BoxShape.circle
          child: Center(
            child: Padding(
              padding: contentPadding, // Adjust padding as needed
              child: !isWidget
                  ? Icon(
                      icon,
                      color: onPressed == null
                          ? Colors.grey[500] ?? Colors.transparent
                          : iconColor,
                    )
                  : child,
            ),
          ),
        ),
      ),
    );
  }
}
