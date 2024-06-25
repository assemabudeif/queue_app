import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/core/data/requests/send_otp_request.dart';
import '/core/global/widgets/custom_app_button.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/assets_data.dart';
import '/core/utilities/font_manger.dart';
import '/features/auth/view_model/auth_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'auth_otp_numbers_builder_widget.dart';
import 'o_t_p_resend_widget.dart';

class AuthOTPBodyWidget extends StatelessWidget {
  const AuthOTPBodyWidget({
    super.key,
    required this.vm,
    required this.sendOtpRequest,
  });
  final AuthCubit vm;
  final SendOtpRequest sendOtpRequest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        children: [
          Expanded(
            child: SvgPicture.asset(
              AssetsData.otpSvg,
              width: 100.w,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            AppStrings.otpVerification.tr,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: kFontWeightSemiBold,
                  fontSize: 24.sp,
                  color: kTextColor,
                ),
          ),
          SizedBox(
            height: 2.h,
          ),
          AuthOTPNumbersBuilderWidget(vm: vm),
          SizedBox(height: 2.h),
          OTPResendWidget(
            vm: vm,
            sendOtpRequest: sendOtpRequest,
          ),
          SizedBox(
            height: 13.h,
          ),
          CustomAppButton(
            text: AppStrings.submit.tr,
            onPressed: vm.onOTPButtonPressed,
            btnColor: kOtpButtonColor,
            textColor: kWhiteColor,
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}
