import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';

import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '../constants/app_constance.dart';

enum LanguageEnum { en, ar }

final _appPrefs = sl<AppPreferences>();

String get getAppLanguageCode => _appPrefs.getAppLanguageCode();

Future<void> changeAppLanguage(BuildContext context) async {
  if (_appPrefs.getAppLanguageCode() == LanguageEnum.en.name) {
    Get.updateLocale(Locale(LanguageEnum.ar.name));
    kAppLanguageCode = LanguageEnum.ar.name;
    _appPrefs.setAppLanguageCode(LanguageEnum.ar.name);
  } else {
    Get.updateLocale(Locale(LanguageEnum.en.name));
    kAppLanguageCode = LanguageEnum.en.name;
    _appPrefs.setAppLanguageCode(LanguageEnum.en.name);
  }
  Phoenix.rebirth(context); // Restarting app
  Get.reset(); // res
}

Future<void> firstTimeForLanguage() async {
  if (_appPrefs.getAppLanguageCode() == '') {
    await _appPrefs.setAppLanguageCode(
      Get.deviceLocale?.languageCode ?? 'en',
    );
  }
}
