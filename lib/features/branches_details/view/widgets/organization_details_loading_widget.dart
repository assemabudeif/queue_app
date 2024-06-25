import 'package:flutter/material.dart';
import '/core/global/widgets/custom_app_bar.dart';
import '/core/theme/app_colors_light.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class OrganizationDetailsLoadingWidget extends StatelessWidget {
  const OrganizationDetailsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isLoading: true,
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.w,
          mainAxisSpacing: 4.w,
          mainAxisExtent: 30.h,
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        itemCount: 16,
        itemBuilder: (context, index) {
          return Shimmer(
            gradient: kShimmerGradientColor,
            enabled: true,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(3.w),
              ),
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 40.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    width: 15.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    width: double.infinity,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
