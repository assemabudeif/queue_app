import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import '/features/tokens/view/widgets/tokens/token_button_widget.dart';
import '/features/tokens/view/widgets/tokens_dialog_header_widget.dart';
import '/features/tokens/view_model/tokens_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TokensDelayDialogWidget extends StatelessWidget {
  const TokensDelayDialogWidget({
    super.key,
    required this.vm,
    required this.remainingToken,
    required this.estimatedToken,
    required this.depId,
    required this.orgName,
    required this.depName,
    required this.tokenNumber,
    required this.tokenScreen,
    required this.branchId,
  });

  final TokensCubit vm;
  final String remainingToken;
  final String estimatedToken;
  final String depId;
  final String branchId;
  final String orgName;
  final String depName;
  final String tokenNumber;
  final bool tokenScreen;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 100.w,
        height: 37.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TokensDialogHeaderWidget(title: AppStrings.delayReservation.tr),
            const Divider(
              color: kBorderColor,
              thickness: 1,
            ),
            SizedBox(
              height: 3.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                ),
                child: Column(
                  children: [
                    Text(
                      '${AppStrings.remainingToken.tr}: $remainingToken',
                      style: context.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${AppStrings.estimatedTime.tr}: $estimatedToken ${AppStrings.min.tr}',
                      style: context.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      AppStrings.areYouSureYouWantToDelayReservation.tr,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: kFontWeightBold,
                        color: kTokenTextColor,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 2.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TokenButtonWidget(
                    text: AppStrings.no.tr,
                    onPressed: () {
                      Get.back();
                    },
                    color: kWhiteColor,
                    width: 15.w,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  TokenButtonWidget(
                    text: AppStrings.yes.tr,
                    onPressed: () {
                      Get.back();
                      vm.cancelToken(
                        tokenNumber: tokenNumber,
                        depId: depId,
                        afterCancel: () {
                          vm.onGenerateTokenPressed(
                            tokenScreen: tokenScreen,
                            depId: depId,
                            branchId: branchId,
                            depName: depName,
                            orgName: orgName,
                          );
                        },
                      );
                    },
                    color: kPrimaryColor,
                    width: 15.w,
                    haveBorder: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
