import 'package:flutter/material.dart';
import '/core/theme/app_colors_light.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Shimmer(
          enabled: true,
          gradient: kShimmerGradientColor,
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.w)),
              border: Border.all(
                color: kHomeBorderColor,
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 70.w,
                    color: kDividerColor,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40.w,
                          height: 2.h,
                          color: kDividerColor,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          width: 30.w,
                          height: 2.h,
                          color: kDividerColor,
                        ),
                      ],
                    ),
                    Container(
                      width: 25.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2.w)),
                        color: kDividerColor,
                        // shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 2.h),
      itemCount: 5,
    );
  }
}
