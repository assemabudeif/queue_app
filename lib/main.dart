import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '/core/services/services_locator.dart';
import '/app.dart';
import 'core/constants/app_constance.dart';
import 'core/localization/language_manger.dart';
import 'core/services/notifications_service.dart';
import 'core/utilities/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ServicesLocator().init();
  Bloc.observer = AppBlocObserver();
  NotificationsService.initialize();
  await _setupOnesignal();

  runApp(
    Phoenix(
      child: DevicePreview(
        enabled: false
        // !kReleaseMode
        ,
        builder: (context) => const QueueApp(),
      ),
    ),
  );
}

_setupOnesignal() async {
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(
    kDebugMode ? OSLogLevel.verbose : OSLogLevel.none,
  );

  OneSignal.User.setLanguage(getAppLanguageCode);

  OneSignal.initialize(kOnesignalAppId);

  // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.Notifications.requestPermission(true);
  OneSignal.Notifications.lifecycleInit();
}
