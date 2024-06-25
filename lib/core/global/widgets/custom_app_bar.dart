import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors_light.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '/core/utilities/font_manger.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.haveBackIcon = true,
    this.titleWidget,
    this.onBack,
    this.isLoading = false,
  });

  final Widget? leading;
  final String? title;
  final Widget? titleWidget;
  final bool haveBackIcon;
  final Function? onBack;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (haveBackIcon)
                leading ??
                    IconButton(
                      onPressed: () {
                        if (onBack != null) {
                          onBack!();
                        }
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 5.w,
                      ),
                    )
              else
                SizedBox(width: 10.w),
              Expanded(
                child: isLoading
                    ? Center(
                        child: Shimmer(
                          gradient: kShimmerGradientColor,
                          enabled: true,
                          child: Container(
                            width: 25.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: titleWidget ??
                            Text(
                              title ?? '',
                              style: context.textTheme.titleMedium!.copyWith(
                                fontFamily: kSFProRoundedFontFamily,
                                color: kTextColor,
                                fontWeight: kFontWeightSemiBold,
                                fontSize: 20.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                      ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(8.h);
}
