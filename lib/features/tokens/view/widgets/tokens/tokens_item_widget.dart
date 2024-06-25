import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/features/tokens/model/models/tokens_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'token_button_widget.dart';
import 'tokens_text_item_widget.dart';

class TokensItemWidget extends StatelessWidget {
  const TokensItemWidget({
    super.key,
    required this.token,
    required this.onDelayPressed,
    required this.onCancelPressed,
  });

  final TokensViewDataModel token;
  final Function() onDelayPressed;
  final Function() onCancelPressed;

  @override
  Widget build(BuildContext context) {
    log(token.toString(), name: 'Tokens Item Widget');
    return Card(
      surfaceTintColor: kTokenCardColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 2.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TokensTextItemWidget(
                    text: AppStrings.organization.tr,
                    value: token.department.organization.orgName,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TokensTextItemWidget(
                    text: AppStrings.service.tr,
                    value: token.department.deptName,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  TokensTextItemWidget(
                    text: AppStrings.yourToken.tr,
                    value: token.tokenNumber.toString(),
                    textColor: kBorderColor,
                    colonColor: kBorderColor,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                TokenButtonWidget(
                  text: AppStrings.delay.tr,
                  onPressed: () {
                    onDelayPressed();
                  },
                  color: kPrimaryColor,
                ),
                SizedBox(
                  height: 1.h,
                ),
                TokenButtonWidget(
                  text: AppStrings.cancel.tr,
                  onPressed: () {
                    onCancelPressed();
                  },
                  color: kWhiteColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
