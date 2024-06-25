import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/data/requests/send_otp_request.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/features/auth/view_model/auth_cubit.dart';

class OTPResendWidget extends StatefulWidget {
  const OTPResendWidget({
    super.key,
    required this.vm,
    required this.sendOtpRequest,
  });

  final AuthCubit vm;
  final SendOtpRequest sendOtpRequest;

  @override
  State<OTPResendWidget> createState() => _OTPResendWidgetState();
}

class _OTPResendWidgetState extends State<OTPResendWidget> {
  final int _maxTime = 120;
  int _time = 0;

  Timer? _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  dispose() {
    _timer!.cancel();
    super.dispose();
  }

  _startTimer() async {
    _time = _maxTime;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        if (_time == 0) {
          _timer!.cancel();
        } else {
          setState(() {
            _time--;
          });
        }
      },
    );
  }

  _resend() {
    widget.vm.onResendOTP(widget.sendOtpRequest);
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontYouReceiveOTP.tr,
          style: context.textTheme.bodyLarge,
        ),
        if (_time != 0) const SizedBox(width: 5),
        if (_time == 0)
          TextButton(
            onPressed: () {
              _resend();
            },
            child: Text(
              AppStrings.resendOTP.tr,
              style: const TextStyle(color: kTextButtonColor),
            ),
          )
        else
          Text(
            _time.toString(),
            style: context.textTheme.bodyLarge!.copyWith(
              color: kTextButtonColor,
            ),
          ),
      ],
    );
  }
}
