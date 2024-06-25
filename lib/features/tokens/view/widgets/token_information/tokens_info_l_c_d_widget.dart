import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lcd_led/lcd_led.dart';
import '/core/functions/buildLCDNumber.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import '/core/localization/app_strings.dart';
import '/features/tokens/view_model/tokens_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TokensInfoLCDWidget extends StatefulWidget {
  const TokensInfoLCDWidget({super.key, required this.vm});

  final TokensCubit vm;

  @override
  State<TokensInfoLCDWidget> createState() => _TokensInfoLCDWidgetState();
}

class _TokensInfoLCDWidgetState extends State<TokensInfoLCDWidget> {
  Timer? _timer;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      widget.vm.getTokenInfo();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokensCubit, TokensState>(
      bloc: widget.vm,
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            height: 23.h,
            width: 70.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kBlackColor,
              borderRadius: BorderRadius.circular(3.w),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 1.h,
              horizontal: 2.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(2.w),
                      topLeft: Radius.circular(2.w),
                    ),
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.yourToken.tr,
                    style: context.textTheme.titleSmall!.copyWith(
                      fontWeight: kFontWeightBold,
                    ),
                  ),
                ),
                SizedBox(height: 0.5.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.w,
                    ),
                    child: LedDigits(
                      string: buildLcdNumber(
                        widget.vm.tokenInfoData.tokenNumber.toString(),
                      ),
                      numberOfLeds: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        //   TokenInformationLCDNumberWidget(
        //   text: AppStrings.yourToken.tr,
        //   image: AssetsData.leftHandSvg,
        //   number: widget.vm.tokenInfoData.tokenNumber.toString(),
        //   rightHand: false,
        // );
      },
    );
  }
}
