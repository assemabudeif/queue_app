import 'dart:developer';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/core/global/widgets/custom_app_bar.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/assets_data.dart';
import '/core/utilities/font_manger.dart';
import '/features/home/views/home_view.dart';
import '/features/settings/views/settings_view.dart';
import '/features/tokens/view/tokens_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeLayoutView extends StatefulWidget {
  const HomeLayoutView({super.key});

  @override
  State<HomeLayoutView> createState() => _HomeLayoutViewState();
}

class _HomeLayoutViewState extends State<HomeLayoutView> {
  final List<String> _titles = [
    AppStrings.home.tr,
    AppStrings.tokens.tr,
    AppStrings.settings.tr,
  ];

  final List<String> _appBarTitles = [
    AppStrings.nearestOrganizations.tr,
    AppStrings.tokens.tr,
    AppStrings.settings.tr,
  ];

  final List<String> _icons = [
    AssetsData.homeImage,
    AssetsData.tokensSvg,
    AssetsData.settingsSvg,
  ];

  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const TokensView(),
    const SettingsView(),
  ];

  _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
    log('index: $_currentIndex');
  }

  @override
  void initState() {
    // BackgroundService().initializeService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _appBarTitles[_currentIndex],
        haveBackIcon: _currentIndex != 0,
        onBack: () {
          _changeIndex(0);
        },
      ),
      body: PopScope(
        canPop: _currentIndex == 0,
        onPopInvoked: (did) {
          _changeIndex(0);
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: kTransparentColor,
        buttonBackgroundColor: kPrimaryColor,
        color: kPrimaryColor,
        height: 8.h,
        index: _currentIndex,
        letIndexChange: (index) {
          _changeIndex(index);
          return true;
        },
        items: [
          for (int i = 0; i < _screens.length; i++)
            CurvedNavigationBarItem(
              child: i == 0
                  ? Image.asset(
                      _icons[i],
                      width: 7.w,
                    )
                  : SvgPicture.asset(
                      _icons[i],
                      width: 6.w,
                      colorFilter: _currentIndex == i
                          ? const ColorFilter.mode(
                              kBlackColor,
                              BlendMode.srcIn,
                            )
                          : null,
                    ),
              label: _titles[i],
              labelStyle: context.textTheme.bodyMedium!.copyWith(
                color: _currentIndex != i ? kBlackColor : kTransparentColor,
                fontWeight: kFontWeightBold,
              ),
            ),
        ],
      ),
    );
  }
}
