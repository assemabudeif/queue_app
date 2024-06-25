import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/localization/app_strings.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/assets_data.dart';
import '/features/base/base_view_model.dart';
import '/features/onboarding/model/onboarding_model.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> with BaseViewModel {
  OnBoardingCubit() : super(OnBoardingInitial());

  late final PageController pageController;
  int currentIndex = 0;

  @override
  dispose() {
    pageController.dispose();

    close();
  }

  @override
  Future<void> init() async {
    pageController = PageController();
  }

  final List<OnBoardingModel> onBoardingData = [
    OnBoardingModel(
      title: AppStrings.onBoardingOneTitle.tr,
      description: AppStrings.onBoardingOneDescription.tr,
      image: AssetsData.onboardingOneSvg,
    ),
    OnBoardingModel(
      title: AppStrings.onBoardingTwoTitle.tr,
      description: AppStrings.onBoardingTwoDescription.tr,
      image: AssetsData.onboardingTwoSvg,
    ),
  ];

  nextPage() async {
    if (currentIndex != onBoardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceIn,
      );
    } else {
      await _saveFirstTime();
      Get.offAllNamed(AppRoutes.loginPath);
    }
  }

  skip() async {
    await _saveFirstTime();
    Get.offAllNamed(AppRoutes.loginPath);
  }

  changePage(int index) {
    emit(OnBoardingChangePageNumberInitialState());
    currentIndex = index;
    emit(OnBoardingChangePageNumberState());
  }

  _saveFirstTime() async {
    await sl<AppPreferences>().setFirstTime(false);
  }
}
