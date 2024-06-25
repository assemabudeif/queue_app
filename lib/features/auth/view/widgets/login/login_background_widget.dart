import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginBackgroundWidget extends StatelessWidget {
  const LoginBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.elliptical(15.w, 3.h),
          bottomEnd: Radius.elliptical(5.w, 1.h),
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        child: Text(
          AppStrings.queue.tr,
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: kFontWeightExtraBold,
            color: kBlackColor,
            fontSize: 30.sp,
          ),
        ),
      ),
    );
  }
}
