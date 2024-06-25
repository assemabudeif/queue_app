import 'package:flutter/material.dart';
import '/core/theme/app_colors_light.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class TokensLoadingView extends StatelessWidget {
  const TokensLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Shimmer(
          gradient: kShimmerGradientColor,
          enabled: true,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(1.w),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      width: 25.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(1.w),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      width: 30.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(1.w),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 25.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      width: 25.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 2.h,
      ),
      itemCount: 8,
    );
  }
}
