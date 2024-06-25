import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/core/global/widgets/custom_app_button.dart';
import '/features/onboarding/view_model/on_boarding_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnBoardingButtonsWidget extends StatelessWidget {
  final OnBoardingCubit vm;

  const OnBoardingButtonsWidget({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              vm.skip();
            },
            child: Text(
              AppStrings.skip.tr,
              style: const TextStyle(
                color: kBlackColor,
              ),
            ),
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          flex: 4,
          child: CustomAppButton(
            onPressed: () {
              vm.nextPage();
            },
            text: AppStrings.next.tr,
          ),
        ),
      ],
    );
  }
}
