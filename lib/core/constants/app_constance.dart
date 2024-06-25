import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// App Name and Version Constants
const String kAppName = 'Queue App';
const String kAppVersion = '1.0.0';
const String kAppVersionCode = '1';
const String kAppVersionName = '1.0.0';
const String kAppPackageName = 'com.kernelcode.queue.app';
const String kOnesignalAppId = "46071795-3456-4940-b05e-f8780cd32fdd";
String kOneSignalSubscribtionId = '';

/// App Constants
const kDefaultLanguage = 'en';
const kDefaultCountry = 'US';
const kDefaultLocale = Locale(kDefaultLanguage, kDefaultCountry);
const kDefaultPadding = 18.0;
String kAppLanguageCode = '';
bool kFirstTime = true;

/// Animation Constants
const kDefaultRouteTransition = Transition.fadeIn;
const kDefaultTransitionDuration = Duration(milliseconds: 300);
const kDefaultAnimationDuration = Duration(milliseconds: 300);
const kSplashAnimationDuration = Duration(seconds: 1, milliseconds: 300);
const kSplashDuration = Duration(seconds: 2, milliseconds: 500);
