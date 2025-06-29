import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:momra/gen/assets.gen.dart';

class InputsMaximizedWidget extends StatelessWidget {
  final TextEditingController textController;
  final bool isSpeechEnabled;
  final bool isMinimized;
  final bool isLoading;
  final bool isListening;
  final void Function()? onTapPickImagesFromGallery;
  final void Function()? onTapPickImagesFromCamera;
  final void Function()? onTapPickDocs;
  final void Function()? onTapMic;
  final void Function()? onTapSend;
  final void Function()? onReset;
  const InputsMaximizedWidget(
      {super.key,
      required this.textController,
      required this.isSpeechEnabled,
      required this.isLoading,
      required this.isMinimized,
      required this.isListening,
      required this.onTapPickImagesFromGallery,
      required this.onTapPickImagesFromCamera,
      required this.onTapPickDocs,
      required this.onTapSend,
      required this.onTapMic,
      required this.onReset});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(4.sp),
            child: SizedBox(
              height: 26.sp,
              width: 26.sp,
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
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TextField(
                controller: textController,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.transparent,
                    ),
                  ),
                  hintText: isSpeechEnabled
                      ? 'اضغط على الميكروفون لبدء التسجيل'
                      : 'التعرف على الصوت غير متاح',
                  hintStyle: const TextStyle(color: Colors.grey),
                  // errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                  ),
                ),
                maxLines: 10,
                minLines: 10,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: onTapPickImagesFromGallery,
                child: Assets.svg.gallery.svg(
                  fit: BoxFit.scaleDown,
                  height: 26.sp,
                ),
              ),
              InkWell(
                onTap: onTapPickImagesFromCamera,
                child: Assets.svg.camera.svg(
                  fit: BoxFit.scaleDown,
                  height: 26.sp,
                ),
              ),
              GestureDetector(
                onTap: onTapMic,
                child: !isListening
                    ? Assets.svg.microfone.svg(
                        height: 56.sp,
                      )
                    : Assets.svg.stop.svg(height: 56.sp, width: 56.sp),
              ),
              GestureDetector(
                onTap: onTapPickDocs,
                child: Assets.svg.doc.svg(
                  fit: BoxFit.scaleDown,
                  height: 26.sp,
                ),
              ),
              Assets.svg.history.svg(
                fit: BoxFit.scaleDown,
                height: 26.sp,
              ),
              GestureDetector(
                onTap: onReset,
                child: Assets.svg.delete.svg(
                  fit: BoxFit.scaleDown,
                  height: 26.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
