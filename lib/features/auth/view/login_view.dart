import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '/core/localization/app_strings.dart';
import '/core/localization/language_manger.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_colors_light.dart';
import '/features/auth/view/widgets/login/login_background_widget.dart';
import '/features/auth/view_model/auth_cubit.dart';

import 'widgets/auth_loading_widget.dart';
import 'widgets/login/login_form_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthCubit _vm = sl<AuthCubit>();

  @override
  void initState() {
    _vm.init();
    super.initState();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _vm.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => _vm,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              actions: [
                TextButton(
                  onPressed: () {
                    changeAppLanguage(context);
                  },
                  child: Text(
                    AppStrings.changeLanguage.tr,
                    style: const TextStyle(color: kTextButtonColor),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                const LoginBackgroundWidget(),
                LoginFormWidget(vm: _vm),
              ],
            ),
          ),
          AuthLoadingWidget(vm: _vm)
        ],
      ),
    );
  }
}
