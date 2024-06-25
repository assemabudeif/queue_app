import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/font_manger.dart';
import '/features/tokens/view_model/tokens_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'tokens/token_button_widget.dart';
import 'tokens_dialog_header_widget.dart';

class TokensCancelDialogWidget extends StatelessWidget {
  const TokensCancelDialogWidget({
    super.key,
    required this.vm,
    required this.depId,
    required this.tokenNumber,
    required this.tokensScreen,
  });

  final TokensCubit vm;
  final String depId;
  final String tokenNumber;
  final bool tokensScreen;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 100.w,
        height: 30.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TokensDialogHeaderWidget(
              title: AppStrings.cancelReservation.tr,
            ),
            const Divider(
              color: kBorderColor,
              thickness: 0.5,
            ),
            SizedBox(
              height: 3.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                ),
                child: Text(
                  AppStrings.areYouSureYouWantToCancelThisReservation.tr,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: kTextColor,
                    fontWeight: kFontWeightBold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
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
                          if (tokensScreen) {
                            vm.refreshTokensView();
                          } else {
                            Get.offAllNamed(AppRoutes.homeLayoutPath);
                          }
                        },
                      );

                      AppSnackBars.showSuccessSnackBar(
                        message: AppStrings.reservationCanceled.tr,
                        title: AppStrings.success.tr,
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
