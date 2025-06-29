import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momra/core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontSize;
  final double width;
  final double height;
  final Color color;
  final SvgPicture? icon;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.width = 1,
    this.height = 58,
    this.fontSize = 16,
    this.color = AppColors.greenTwo,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 5.0,
        textStyle: GoogleFonts.ebGaramond(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 1.5,
        ),
      ).copyWith(
          minimumSize: WidgetStateProperty.all(Size(width.sw, height.sp))),
      child: icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon!,
                SizedBox(width: 8.w), // Add some spacing
                Text(
                  text,
                  style: GoogleFonts.ebGaramond(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                    height: 1.5,
                  ),
                ),
              ],
            )
          : Text(
              text,
              style: GoogleFonts.ebGaramond(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
                height: 1.5,
              ),
            ),
    );
  }
}

class CustomButtonWithNotif extends StatelessWidget {
  final String text;
  final SvgPicture icon;
  final int notifCount;
  final bool isClicked;
  final void Function()? onPressed;
  const CustomButtonWithNotif({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.notifCount,
    this.isClicked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 60.sp,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 40.sp,
                  width: 0.41.sw,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isClicked ? AppColors.greenTwo : AppColors.greyLite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      minimumSize: Size.zero, // Set this
                      padding: EdgeInsets.symmetric(horizontal: 12.sp),
                      elevation: 0,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            color: isClicked ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        icon,
                      ],
                    ),
                  ),
                ),
              ),
              notifCount != 0
                  ? Positioned(
                      left: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '$notifCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
