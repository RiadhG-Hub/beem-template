import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:momra/gen/assets.gen.dart';

class InputsMinimizedWidget extends StatelessWidget {
  final bool isListening;
  final bool isLoading;
  final void Function()? onTapPickImagesFromGallery;
  final void Function()? onTapPickImagesFromCamera;
  final void Function()? onTapPickDocs;
  final void Function()? onTapMic;
  final void Function()? onTapSend;
  final void Function()? onReset;
  const InputsMinimizedWidget(
      {super.key,
      required this.isListening,
      required this.isLoading,
      required this.onTapPickImagesFromGallery,
      required this.onTapPickImagesFromCamera,
      required this.onTapPickDocs,
      required this.onTapMic,
      required this.onTapSend,
      required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.sp,
          width: 20.sp,
          child: isLoading
              ? CircularProgressIndicator(
                  color: AppColors.greenThree,
                )
              : InkWell(
                  onTap: onTapSend,
                  child: Assets.svg.send.svg(
                    fit: BoxFit.scaleDown,
                  ),
                ),
        ),
        GestureDetector(
          onTap: onReset,
          child: Assets.svg.delete.svg(
            fit: BoxFit.scaleDown,
            height: 20.sp,
          ),
        ),
        GestureDetector(
          onTap: onTapMic,
          child: Assets.svg.microfone.svg(
            colorFilter: ColorFilter.mode(
                isListening ? Colors.red : Colors.transparent, BlendMode.color),
            fit: BoxFit.scaleDown,
            height: 48.sp,
          ),
        ),
        InkWell(
          onTap: onTapPickImagesFromGallery,
          child: Assets.svg.gallery.svg(
            fit: BoxFit.scaleDown,
            height: 20.sp,
          ),
        ),
        InkWell(
          onTap: onTapPickImagesFromCamera,
          child: Assets.svg.camera.svg(
            fit: BoxFit.scaleDown,
            height: 20.sp,
          ),
        ),
      ],
    );
  }
}
