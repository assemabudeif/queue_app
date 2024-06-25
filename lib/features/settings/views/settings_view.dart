import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import '/features/settings/view_models/settings_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SettingsCubit _vm = sl<SettingsCubit>();

  @override
  void initState() {
    _vm.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _vm,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ..._vm.settings.map(
                (e) => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        e.onTap(context);
                      },
                      child: Row(
                        children: [
                          if (e.isSVG)
                            SvgPicture.asset(
                              e.icon,
                              width: 7.w,
                            )
                          else
                            Image.asset(
                              e.icon,
                              width: 10.w,
                            ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            e.title,
                            style: context.textTheme.headlineMedium!.copyWith(
                              color: kTextColor,
                              fontWeight: kFontWeightMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 4.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
