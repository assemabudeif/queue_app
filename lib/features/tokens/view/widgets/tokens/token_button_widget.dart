import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TokenButtonWidget extends StatelessWidget {
  const TokenButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.haveBorder = true,
    this.width,
  });
  final String text;
  final Function() onPressed;
  final Color color;
  final bool haveBorder;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      color: color,
      minWidth: width ?? 20.w,
      height: 4.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.w),
        side: haveBorder
            ? const BorderSide(
                color: kBlackColor,
                width: 1,
              )
            : BorderSide.none,
      ),
      child: Text(
        text,
        style: context.textTheme.bodyLarge!.copyWith(
          fontWeight: kFontWeightSemiBold,
        ),
      ),
    );
  }
}
