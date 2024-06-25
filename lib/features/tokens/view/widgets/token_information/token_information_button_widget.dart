import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TokenInformationButtonWidget extends StatelessWidget {
  const TokenInformationButtonWidget({
    super.key,
    required this.color,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.fontWeight = kFontWeightMedium,
  });

  final Color color;
  final String text;
  final String icon;
  final Function onPressed;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 27.w,
      height: 18.h,
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        elevation: 5,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
          side: const BorderSide(
            color: kBlackColor,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kTextColor,
                fontWeight: fontWeight,
                fontSize: 15.sp,
              ),
              maxLines: 2,
            ),
            SizedBox(
              height: 2.h,
            ),
            SvgPicture.asset(
              icon,
              width: 8.w,
            )
          ],
        ),
      ),
    );
  }
}
