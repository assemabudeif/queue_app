import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lcd_led/lcd_led.dart';
import '/core/functions/buildLCDNumber.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TokenInformationLCDNumberWidget extends StatelessWidget {
  const TokenInformationLCDNumberWidget({
    super.key,
    required this.image,
    required this.number,
    required this.text,
    required this.rightHand,
  });

  final String image;
  final String number;
  final String text;
  final bool rightHand;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26.h,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: rightHand ? 0 : null,
            left: rightHand ? null : 0,
            child: SvgPicture.asset(
              image,
              width: 55.w,
            ),
          ),
          Positioned(
            right: rightHand ? 5.w : null,
            left: rightHand ? null : 5.w,
            bottom: 10.h,
            child: Container(
              height: 16.h,
              width: 51.w,
              decoration: BoxDecoration(
                color: kBlackColor,
                borderRadius: BorderRadius.circular(3.w),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 2.w,
              ),
              child: Column(
                children: [
                  Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2.w),
                        topLeft: Radius.circular(2.w),
                      ),
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: context.textTheme.titleSmall!.copyWith(
                        fontWeight: kFontWeightBold,
                      ),
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.w,
                      ),
                      child: LedDigits(
                        string: buildLcdNumber(number),
                        numberOfLeds: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
