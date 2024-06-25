import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/data/requests/send_otp_request.dart';
import '/core/services/services_locator.dart';
import '/features/auth/view/widgets/auth_loading_widget.dart';
import '/features/auth/view/widgets/otp/auth_o_t_p_body_widget.dart';
import '/features/auth/view_model/auth_cubit.dart';

class OTPView extends StatefulWidget {
  const OTPView({
    super.key,
    required this.sendOtpRequest,
  });

  final SendOtpRequest sendOtpRequest;

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final AuthCubit _vm = sl<AuthCubit>();

  @override
  void initState() {
    _vm.initOTP();
    super.initState();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _vm,
        child: SafeArea(
          child: Stack(
            children: [
              AuthOTPBodyWidget(vm: _vm, sendOtpRequest: widget.sendOtpRequest),
              AuthLoadingWidget(vm: _vm),
            ],
          ),
        ),
      ),
    );
  }
}
