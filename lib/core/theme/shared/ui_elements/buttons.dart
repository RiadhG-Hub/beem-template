import 'package:flutter/material.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:momra/core/theme/styles.dart';
import 'package:momra/core/util/ui_helpers.dart';
import 'package:momra/core/util/widget_ext.dart';

class Buttons {
  static SizedBox primaryButton(
      {Key? key,
      String? text,
      VoidCallback? onTap,
      double? width,
      double height = 40,
      bool loading = false,
      Color backgroundColor = AppColors.primary60,
      IconData? iconRight,
      IconData? iconLeft,
      Widget? iconLeftWidget,
      double? borderRadius = 5,
      Alignment alignment = Alignment.center,
      TextStyle? textStyle = TextStyles.titleSmall,
      bool expanded = true}) {
    return SizedBox(
      width: width,
      height: height,
      child: Align(
        alignment: alignment,
        child: FilledButton(
          key: key ?? const Key('primaryButton'),
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            fixedSize: width != null ? Size(width, height) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  borderRadius!,
                ),
              ),
            ),
            backgroundColor: backgroundColor,
          ),
          child: SizedBox(
            height: height,
            child: loading
                ? Row(
                    mainAxisSize:
                        expanded ? MainAxisSize.max : MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox.square(
                        dimension: height * 0.4,
                        child: const CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisSize:
                        expanded ? MainAxisSize.max : MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (iconLeft != null)
                        Icon(
                          iconLeft,
                          color: onTap != null
                              ? textStyle?.color
                              : AppColors.neutral50,
                          size: 18,
                        ),
                      if (iconLeft != null) smallHorizontalSpacer,
                      if (iconLeftWidget != null) iconLeftWidget,
                      if (iconLeftWidget != null) smallHorizontalSpacer,
                      Text(
                        text ?? '',
                        textAlign: TextAlign.center,
                        style: textStyle!.copyWith(
                          color: textStyle.color,
                        ),
                      ).scaleDown(alignment: Alignment.center),
                      if (iconRight != null) smallHorizontalSpacer,
                      if (iconRight != null)
                        Icon(iconRight,
                            color: onTap != null
                                ? textStyle.color
                                : AppColors.neutral50,
                            size: 18)
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  static Widget loadingButton(
      {Color backgroundColor = AppColors.primary60,
      double? borderRadius = 5,
      EdgeInsets? contentPadding = const EdgeInsets.all(8),
      double? width,
      double? height,
      bool? isExpanded = false}) {
    return SizedBox(
      height: height,
      width: width,
      child: IgnorePointer(
        ignoring: true,
        child: Center(
          child: FilledButton(
            onPressed: () {},
            key: const Key('loadingButton'),
            style: ElevatedButton.styleFrom(
              padding: contentPadding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    borderRadius!,
                  ),
                ),
              ),
              backgroundColor: backgroundColor,
            ),
            child: const Center(
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget outlinedButton(
      {Key? key,
      String? text,
      VoidCallback? onTap,
      double? width,
      double height = 40,
      bool loading = false,
      Color backgroundColor = AppColors.primary60,
      Widget? rightWidget,
      Widget? leftWidget,
      double? borderRadius = 5,
      Alignment alignment = Alignment.center,
      TextStyle? textStyle = TextStyles.titleSmall,
      bool expanded = true,
      bool withBorder = true,
      double borderWidth = 2.0,
      Color? borderColor}) {
    return SizedBox(
        width: width,
        height: height,
        child: Align(
            alignment: alignment,
            child: OutlinedButton(
              key: const Key('outlinedButton'),
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                side: withBorder
                    ? BorderSide(
                        width: borderWidth,
                        color: borderColor ?? AppColors.primary0,
                        style: BorderStyle.solid,
                      )
                    : BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 0),
                ),
              ),
              child: loading
                  ? Row(
                      mainAxisSize:
                          expanded ? MainAxisSize.max : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.square(
                          dimension: height * 0.4,
                          child: const CircularProgressIndicator.adaptive(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisSize:
                          expanded ? MainAxisSize.max : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (leftWidget != null) leftWidget,
                        if (leftWidget != null) smallHorizontalSpacer,
                        Text(
                          text ?? '',
                          textAlign: TextAlign.center,
                          style: textStyle!.copyWith(
                            color: textStyle.color,
                          ),
                        ).scaleDown(alignment: Alignment.center),
                        if (rightWidget != null) smallHorizontalSpacer,
                        if (rightWidget != null) rightWidget
                      ],
                    ),
            )));
  }
}
