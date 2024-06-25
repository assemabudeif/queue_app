import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/app_constance.dart';
import '/core/theme/app_colors_light.dart';
import '/features/onboarding/view_model/on_boarding_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnBoardingDotWidget extends StatelessWidget {
  const OnBoardingDotWidget({
    super.key,
    required this.cubit,
  });
  final OnBoardingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      bloc: cubit,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              cubit.onBoardingData.length,
              (index) => Container(
                margin: EdgeInsetsDirectional.only(end: 1.5.w),
                child: AnimatedContainer(
                  margin: const EdgeInsets.only(right: 5),
                  duration: kDefaultAnimationDuration,
                  width: cubit.currentIndex == index ? 9.w : 2.w,
                  height: 2.w,
                  decoration: BoxDecoration(
                    color: cubit.currentIndex == index
                        ? kPrimaryColor
                        : kWhiteColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
