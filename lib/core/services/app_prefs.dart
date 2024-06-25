import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '/core/network/api_constance.dart';
import '../constants/app_constance.dart';
import 'services_locator.dart';

enum SharedKey {
  firstTime,
  sessionId,
  language,
  isDarkMode,
}

class AppPreferences {
  final _sharedPreferences = sl<SharedPreferences>();
  Future<void> init() async {
    kAppLanguageCode = getAppLanguageCode();
    ApiConstance.sessionId = getSessionId();
    kFirstTime = getFirstTime();

    await Future.delayed(const Duration(seconds: 1), () {
      log(ApiConstance.sessionId.toString(), name: 'SessionId');
      log(kAppLanguageCode, name: 'Language Code');
      log(kFirstTime.toString(), name: 'First Time');
    });
  }

  /// Save the first time to the shared preferences
  Future<void> setFirstTime(bool isFirstTime) async {
    await _sharedPreferences.setBool(
      SharedKey.firstTime.toString(),
      isFirstTime,
    );
  }

  /// Get the first time from the shared preferences
  bool getFirstTime() {
    return _sharedPreferences.getBool(SharedKey.firstTime.toString()) ?? true;
  }

  /// Save the SessionId to the shared preferences
  Future<void> setSessionId(int sessionId) async {
    ApiConstance.sessionId = sessionId;
    await _sharedPreferences.setInt(
      SharedKey.sessionId.toString(),
      sessionId,
    );
  }

  /// Get the SessionId from the shared preferences
  int getSessionId() {
    return _sharedPreferences.getInt(SharedKey.sessionId.toString()) ?? -1;
  }

  /// Remove the SessionId from the shared preferences
  Future<void> removeSessionId() async {
    ApiConstance.sessionId = -1;
    await _sharedPreferences.remove(SharedKey.sessionId.toString());
  }

  /// Save the SessionId to the shared preferences
  Future<void> setAppLanguageCode(String languageCode) async {
    await _sharedPreferences.setString(
      SharedKey.language.toString(),
      languageCode,
    );
  }

  /// Get the SessionId from the shared preferences
  String getAppLanguageCode() {
    return _sharedPreferences.getString(SharedKey.language.toString()) ?? 'en';
  }

  /// Remove the SessionId from the shared preferences
  Future<void> removeLanguageCode() async {
    await _sharedPreferences.remove(SharedKey.language.toString());
  }

  /// Clear all the shared preferences
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }
}
