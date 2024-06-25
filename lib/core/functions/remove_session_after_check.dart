import 'package:get/get.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/localization/app_strings.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';

Future<void> removeSessionAfterCheck() async {
  await sl<AppPreferences>().removeSessionId();
  ApiConstance.sessionId = -1;
  AppSnackBars.showAlertSnackBar(
    message: AppStrings.yourSessionHasExpiredPleaseLoginAgain.tr,
  );

  Get.offAllNamed(AppRoutes.loginPath);
}
