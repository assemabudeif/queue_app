import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:queue_app/core/global/widgets/app_snackbars.dart';
import 'package:queue_app/core/localization/app_strings.dart';

import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/features/auth/model/repository/auth_repository.dart';

checkLogin({
  required Function navigateToNext,
}) async {
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());

  if (connectivityResult.contains(ConnectivityResult.none)) {
    AppSnackBars.showAlertSnackBar(
      message: AppStrings.checkYourInternetConnectionPlease.tr,
    );
    navigateToNext();
    return;
  }

  if (ApiConstance.sessionId != -1) {
    final response = await sl<AuthRepository>().login();
    response.fold(
      (l) {
        log(l.message, name: 'Login Error');
        // _removeSessionId();
      },
      (r) {
        if (r.exist == 1) {
          navigateToNext();
        } else {
          _removeSessionId();
          navigateToNext();
        }
      },
    );
  } else {
    navigateToNext();
  }
}

_removeSessionId() async {
  await sl<AppPreferences>().removeSessionId();
}
