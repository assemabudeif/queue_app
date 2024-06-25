import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '/core/theme/app_colors_light.dart';
import '/features/auth/view_model/auth_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AuthLoadingWidget extends StatelessWidget {
  const AuthLoadingWidget({super.key, required this.vm});

  final AuthCubit vm;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Visibility(
          visible: vm.state is AuthSendOtpLoadingState ||
              vm.state is AuthCheckBlacklistLoadingState ||
              vm.state is AuthVerifyOtpLoadingState,
          child: Container(
            height: 100.h,
            width: 100.w,
            alignment: Alignment.center,
            color: kBlackColor.withOpacity(0.5),
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: kPrimaryColor,
              size: 25.w,
            ),
          ),
        );
      },
    );
  }
}
