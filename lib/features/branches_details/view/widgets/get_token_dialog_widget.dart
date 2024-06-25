import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '/core/localization/app_strings.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import '/features/branches_details/model/models/remaining_tokens_without_token_model.dart';
import '/features/branches_details/view_model/organization_details_cubit.dart';
import '/features/tokens/view/widgets/tokens/token_button_widget.dart';
import '/features/tokens/view/widgets/tokens_dialog_header_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GetTokenDialogWidget extends StatefulWidget {
  const GetTokenDialogWidget({
    super.key,
    required this.depId,
    required this.remainingTokensWithoutTokenModel,
    required this.depName,
    required this.orgName,
    required this.branchId,
  });

  final String depId;
  final String branchId;
  final String depName;
  final String orgName;
  final RemainingTokensWithoutTokenModel remainingTokensWithoutTokenModel;

  @override
  State<GetTokenDialogWidget> createState() => _GetTokenDialogWidgetState();
}

class _GetTokenDialogWidgetState extends State<GetTokenDialogWidget> {
  final _vm = sl<OrganizationDetailsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationDetailsCubit, OrganizationDetailsState>(
      bloc: _vm,
      builder: (context, state) {
        return Dialog(
          child: SizedBox(
            width: 100.w,
            height: 37.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TokensDialogHeaderWidget(
                    title: AppStrings.confirmReservation.tr),
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
                          '${AppStrings.remainingToken.tr}: ${widget.remainingTokensWithoutTokenModel.remainingTokens}',
                          style: context.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${AppStrings.estimatedTime.tr}: ${widget.remainingTokensWithoutTokenModel.remainingTime} ${AppStrings.min.tr}',
                          style: context.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          AppStrings
                              .areYouSureYouWantToReservationConfirmation.tr,
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
                          _vm.onGenerateTokenPressed(
                            depId: widget.depId,
                            branchId: widget.branchId,
                            depName: widget.depName,
                            orgName: widget.orgName,
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
      },
    );
  }
}
