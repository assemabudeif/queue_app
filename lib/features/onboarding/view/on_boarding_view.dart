import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '/core/localization/app_strings.dart';
import '/core/localization/language_manger.dart';
import '/core/theme/app_colors_light.dart';
import '/core/services/services_locator.dart';
import '/features/onboarding/view/widgets/on_boarding_page_view_widget.dart';
import '/features/onboarding/view_model/on_boarding_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'widgets/on_boarding_dot_widet.dart';
import 'widgets/on_boarding_buttons_widget.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final OnBoardingCubit _vm = sl<OnBoardingCubit>();

  @override
  void initState() {
    _vm.init();
    super.initState();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => _vm,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      changeAppLanguage(context);
                    },
                    child: Text(
                      AppStrings.changeLanguage.tr,
                      style: const TextStyle(color: kTextButtonColor),
                    ),
                  ),
                ),
                OnBoardingPageViewWidget(cubit: _vm),
                SizedBox(height: 2.h),
                OnBoardingDotWidget(cubit: _vm),
                SizedBox(height: 10.h),
                OnBoardingButtonsWidget(vm: _vm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
