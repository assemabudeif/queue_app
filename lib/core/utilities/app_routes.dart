import 'dart:developer';

import 'package:get/get.dart';
import '/core/data/models/TokenInfoDataModel.dart';
import '/core/data/requests/send_otp_request.dart';
import '/features/branches_details/view/organization_details_view.dart';
import '/features/tokens/view/token_information_view.dart';
import '/features/auth/view/login_view.dart';
import '/features/auth/view/o_t_p_view.dart';
import '/features/home/views/home_layout_view.dart';
import '/features/onboarding/view/on_boarding_view.dart';
import '/features/splash/views/splash_view.dart';

import '/core/localization/app_strings.dart';

/// Routes names
class AppRoutes {
  static const String splashPath = '/';
  static const String onBoardingPath = '/onBoarding';
  static const String loginPath = '/login';
  static const String otpPath = '/otp';
  static const String homeLayoutPath = '/homeLayout';
  static const String organizationDetailsPath = '/organizationDetails';
  static const String tokenInformationPath = '/tokenInformation';
}

/// App Routes
List<GetPage<dynamic>> get appRoutes => [
      // Splash Screen
      GetPage(
        name: AppRoutes.splashPath,
        page: () => const SplashView(),
      ),

      // OnBoarding Screen
      GetPage(
        name: AppRoutes.onBoardingPath,
        page: () => const OnBoardingView(),
      ),

      // Login Screen
      GetPage(
        name: AppRoutes.loginPath,
        page: () => const LoginView(),
      ),

      // OTP Screen
      GetPage(
        name: AppRoutes.otpPath,
        page: () => OTPView(
          sendOtpRequest: Get.arguments as SendOtpRequest,
        ),
      ),

      // Home Layout Screen
      GetPage(
        name: AppRoutes.homeLayoutPath,
        page: () => const HomeLayoutView(),
      ),

      // Organization Details Screen
      GetPage(
        name: AppRoutes.organizationDetailsPath,
        page: () => OrganizationDetailsView(
          orgId: Get.arguments as String,
        ),
      ),

      // Token Information Screen
      GetPage(
        name: AppRoutes.tokenInformationPath,
        page: () => TokenInformationView(
          tokenInfoData: Get.arguments ??
              const TokenInfoScreenDataModel(
                tokenNumber: 0,
                orgName: '',
                depId: 0,
                branchId: 0,
                depName: '',
              ),
        ),
      ),
    ];

/// Middleware to log the page name
class MyMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    log(page?.name.toString() ?? AppStrings.invalidPageName.tr);
    return super.onPageCalled(page);
  }
}
