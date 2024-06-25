import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import '/features/onboarding/view_model/on_boarding_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnBoardingPageViewWidget extends StatelessWidget {
  const OnBoardingPageViewWidget({super.key, required this.cubit});

  final OnBoardingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        bloc: cubit,
        builder: (context, state) {
          return PageView(
            controller: cubit.pageController,
            children: cubit.onBoardingData.map((e) {
              return Column(
                children: [
                  Expanded(child: SvgPicture.asset(e.image)),
                  Text(
                    e.title,
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: kFontWeightMedium,
                      fontSize: 20.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      e.description,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: kTextLightColor,
                        fontWeight: kFontWeightRegular,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                    ),
                  ),
                ],
              );
            }).toList(),
            onPageChanged: (index) {
              cubit.changePage(index);
            },
          );
        },
      ),
    );
  }
}
