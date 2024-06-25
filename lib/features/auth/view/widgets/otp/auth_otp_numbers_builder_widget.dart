import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors_light.dart';
import '/features/auth/view_model/auth_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '/core/utilities/font_manger.dart';

class AuthOTPNumbersBuilderWidget extends StatelessWidget {
  const AuthOTPNumbersBuilderWidget({
    super.key,
    required this.vm,
  });

  final AuthCubit vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < vm.otpControllers.length; i++)
              _buildTextField(
                context: context,
                focusNode: vm.otpControllers[i].focusNode,
                controller: vm.otpControllers[i].controller,
                nextController: i < vm.otpControllers.length - 1
                    ? vm.otpControllers[i + 1].controller
                    : null,
                nextFocusNode: i < vm.otpControllers.length - 1
                    ? vm.otpControllers[i + 1].focusNode
                    : null,
                previousFocusNode:
                    i != 0 ? vm.otpControllers[i - 1].focusNode : null,
              ),
          ],
        ),
      ),
    );
  }

  _buildTextField({
    required BuildContext context,
    required FocusNode focusNode,
    required TextEditingController controller,
    TextEditingController? nextController,
    FocusNode? nextFocusNode,
    FocusNode? previousFocusNode,
  }) {
    return Container(
      width: 15.w,
      height: 15.w,
      margin: EdgeInsets.only(right: 2.5.w),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(2.w),
        boxShadow: [
          BoxShadow(
            color: kShadowColor.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(1.w, 1.5.w),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: TextFormField(
        enabled: true,
        readOnly: false,
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: context.textTheme.headlineMedium!.copyWith(
          color: kTextColor,
          fontWeight: kFontWeightBold,
        ),
        buildCounter: (
          BuildContext context, {
          int? currentLength,
          int? maxLength,
          bool? isFocused,
        }) =>
            null,
        cursorColor: kBlackColor,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
        onChanged: (value) {
          if (value == ' ') {
            controller.clear();
            return;
          }
          if (value.isEmpty && previousFocusNode != null) {
            previousFocusNode.requestFocus();
          }
          if (value.length == 1 && nextFocusNode != null) {
            focusNode.unfocus();
            nextFocusNode.requestFocus();
            nextController!.clear();
          }
        },
        onFieldSubmitted: (value) {
          if (nextFocusNode == null) {
            focusNode.unfocus();
          }
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return '';
          }
          return null;
        },
      ),
    );
  }
}
