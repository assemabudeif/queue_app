import 'package:get/get.dart';
import 'package:queue_app/core/localization/app_strings.dart';

import '/core/theme/app_colors_light.dart';

class AppSnackBars {
  static showSuccessSnackBar({
    required String message,
    required String title,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: kSuccessColor,
      colorText: kWhiteColor,
    );
  }

  static showErrorSnackBar({
    required String message,
    required String title,
  }) {
    if (message.contains(AppStrings.checkYourInternetConnectionPlease.tr)) {
      showAlertSnackBar(message: message);
      return;
    }
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: kErrorColor,
      colorText: kWhiteColor,
    );
  }

  static showAlertSnackBar({
    required String message,
  }) {
    Get.snackbar(
      AppStrings.alertTitle.tr,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: kAlertColor,
      colorText: kWhiteColor,
    );
  }
}
