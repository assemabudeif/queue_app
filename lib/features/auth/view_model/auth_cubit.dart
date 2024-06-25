import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '/core/data/requests/send_otp_request.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/localization/app_strings.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/features/auth/model/models/otp/otp_item_model.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/enums.dart';
import '/features/auth/model/repository/auth_repository.dart';
import '/features/base/base_view_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with BaseViewModel {
  AuthCubit(this._authRepository) : super(AuthInitial());

  final AuthRepository _authRepository;

  /// Login view
  final TextEditingController phoneNumberController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  GenderEnum? genderValue;
  final String defaultCountrySelection = 'AE';
  final List<String> favoriteCountryCode = ['EG', 'AE', 'SA'];
  String _countryCodeDail = '+971';

  /// OTP View
  late List<OTPItemModel> otpControllers;
  final otpFormKey = GlobalKey<FormState>();

  String _otpNumber = '';

  /// Login view
  @override
  Future<void> init() async {}

  @override
  void dispose() {
    phoneNumberController.dispose();
    close();
  }

  void onChangeGenderValue(GenderEnum? value) {
    emit(AuthChangeGenderValueInitialState());
    genderValue = value;
    emit(AuthChangeGenderValueState());
  }

  void onChangeCountryCode(CountryCode value) {
    _countryCodeDail = value.dialCode!;
    log(_countryCodeDail, name: 'CountryCode');
    log(value.code!, name: 'CountryCode');
  }

  void onLoginButtonPressed() {
    if (genderValue == null) {
      AppSnackBars.showAlertSnackBar(
        message: AppStrings.selectGender.tr,
      );
    } else if (loginFormKey.currentState!.validate()) {
      _checkBlacklisted();
    }
  }

  void _checkBlacklisted() async {
    String phone = phoneNumberController.text;

    while (phone.split('')[0] == '0') {
      phone = phone.substring(1);
    }
    phone = _countryCodeDail + phone;
    emit(AuthCheckBlacklistLoadingState());
    final response = await _authRepository.checkBlacklist(
      phone: phone,
    );

    response.fold(
      (failure) {
        AppSnackBars.showErrorSnackBar(
          message: failure.message,
          title: AppStrings.error.tr,
        );
        emit(AuthCheckBlacklistErrorState());
      },
      (data) {
        if (data.blacklisted == 0) {
          // String phone = '';
          // while (phoneNumberController.text.split('')[0] == '0') {
          //   phone = _countryCodeDail + phoneNumberController.text.substring(1);
          // }
          // if (phoneNumberController.text.split('')[0] == '0') {
          //   phone = _countryCodeDail + phoneNumberController.text.substring(1);
          // } else {
          //   phone = _countryCodeDail + phoneNumberController.text;
          // }
          final sendOtpRequest = SendOtpRequest(
            phone: phone, // '971' + phoneNumberController.text,
            gender: genderValue!,
            deviceId: OneSignal.User.pushSubscription.id ?? '',
          );
          _sendOtp(sendOtpRequest: sendOtpRequest);
          // emit(AuthCheckBlacklistSuccessState());
        } else {
          AppSnackBars.showAlertSnackBar(
            message: AppStrings.youAreBlacklisted.tr,
          );
          emit(AuthCheckBlacklistErrorState());
        }
      },
    );
  }

  void _sendOtp({
    required SendOtpRequest sendOtpRequest,
  }) async {
    emit(AuthSendOtpLoadingState());
    final response = await _authRepository.sendOtp(
      sendOtpRequest,
    );

    response.fold(
      (failure) {
        AppSnackBars.showErrorSnackBar(
          message: failure.message,
          title: AppStrings.error.tr,
        );
        emit(AuthSendOtpErrorState());
      },
      (data) {
        if (data.sent == 1) {
          Get.toNamed(
            AppRoutes.otpPath,
            arguments: sendOtpRequest,
          );

          emit(AuthSendOtpSuccessState());
        } else {
          AppSnackBars.showErrorSnackBar(
            message: AppStrings.failedToSendOTP.tr,
            title: AppStrings.error.tr,
          );
          // Get.toNamed(
          //   AppRoutes.otpPath,
          //   arguments: sendOtpRequest,
          // );

          emit(AuthSendOtpErrorState());
        }
      },
    );
  }

  /// OTP View
  Future<void> initOTP() async {
    otpControllers = List.generate(
      5,
      (index) => OTPItemModel(
        controller: TextEditingController(),
        focusNode: FocusNode(),
      ),
    );
  }

  Future<void> disposeOTP() async {
    for (var element in otpControllers) {
      element.controller.dispose();
      element.focusNode.dispose();
    }
  }

  void onOTPButtonPressed() {
    // log(await otpNumber, name: 'OTPNumber');
    _verifyOtp();
    // Get.toNamed(AppRoutes.homeLayoutPath);
  }

  Future<String> get otpNumber async {
    _otpNumber = '';
    for (var element in otpControllers) {
      _otpNumber += element.controller.text;
    }
    return _otpNumber;
  }

  void onResendOTP(SendOtpRequest sendOtpRequest) {
    _sendOtp(sendOtpRequest: sendOtpRequest);
  }

  _verifyOtp() async {
    emit(AuthVerifyOtpLoadingState());
    final response = await _authRepository.verifyOtp(otp: await otpNumber);

    response.fold(
      (failure) {
        AppSnackBars.showErrorSnackBar(
          message: failure.message,
          title: AppStrings.error.tr,
        );
        emit(AuthVerifyOtpErrorState());
      },
      (data) {
        if (data.otpIsValid == 1) {
          _saveSessionId(data.sessionId);
          Get.offAllNamed(AppRoutes.homeLayoutPath);
          emit(AuthVerifyOtpSuccessState());
        } else {
          AppSnackBars.showAlertSnackBar(
            message: AppStrings.invalidOTP.tr,
          );
          emit(AuthVerifyOtpErrorState());
        }
      },
    );
  }

  _saveSessionId(int sessionId) async {
    await sl<AppPreferences>().setSessionId(sessionId);
  }
}
