import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '/core/localization/app_translations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/localization/language_manger.dart';
import 'core/theme/theme_data/theme_data_light.dart';
import 'core/theme/theme_manger.dart';
import 'core/constants/app_constance.dart';
import 'core/utilities/app_routes.dart';

class QueueApp extends StatefulWidget {
  const QueueApp({super.key});

  @override
  State<QueueApp> createState() => _QueueAppState();
}

class _QueueAppState extends State<QueueApp> {
  @override
  void initState() {
    kOneSignalSubscribtionId = OneSignal.User.pushSubscription.id ?? '';
    log(kOneSignalSubscribtionId, name: "subscribtionId");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: kAppName,
          theme: getThemeDataLight,
          debugShowCheckedModeBanner: false,
          translations: AppTranslations(),
          getPages: appRoutes,
          initialRoute: AppRoutes.splashPath,
          themeMode: appThemeModeIsDark ? ThemeMode.dark : ThemeMode.light,
          locale: Locale(getAppLanguageCode),
          fallbackLocale: kDefaultLocale,
          defaultTransition: kDefaultRouteTransition,
          transitionDuration: kDefaultTransitionDuration,
        );
      },
    );
  }
}
