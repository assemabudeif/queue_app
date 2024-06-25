import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '/core/functions/check_login.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/app_routes.dart';

import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '../../../../core/constants/app_constance.dart';
import 'sliding_logo.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slidingAnimation;

  @override
  initState() {
    super.initState();
    _initAnimationControllers();

    _initAppPrefs();

    checkLogin(navigateToNext: _navigateToNext);
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlidingLogo(slidingAnimation: _slidingAnimation),
    );
  }

  void _navigateToNext() {
    Future.delayed(kSplashDuration, () {
      if (kFirstTime) {
        Get.offNamed(AppRoutes.onBoardingPath);
      } else if (ApiConstance.sessionId != -1) {
        Get.offNamed(AppRoutes.homeLayoutPath);
      } else {
        Get.offNamed(AppRoutes.loginPath);
      }
    });
  }

  Future<void> _initAppPrefs() async {
    await sl<AppPreferences>().init();
  }

  void _initAnimationControllers() {
    _animationController = AnimationController(
      vsync: this,
      duration: kSplashAnimationDuration,
    );

    _slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, 0),
    ).animate(_animationController);

    _animationController.forward();
  }
}
