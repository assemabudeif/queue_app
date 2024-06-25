import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '/core/utilities/app_routes.dart';
import '/core/data/models/TokenInfoDataModel.dart';
import '/core/global/widgets/custom_app_bar.dart';
import '/core/localization/app_strings.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/assets_data.dart';
import '/core/utilities/font_manger.dart';
import '/features/tokens/view_model/tokens_cubit.dart';
import 'widgets/token_information/token_information_details_item_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'widgets/token_information/token_information_button_widget.dart';
import 'widgets/token_information/tokens_info_l_c_d_widget.dart';
import 'widgets/token_rating_dialog.dart';

class TokenInformationView extends StatefulWidget {
  const TokenInformationView({
    super.key,
    required this.tokenInfoData,
  });

  final TokenInfoScreenDataModel tokenInfoData;

  @override
  State<TokenInformationView> createState() => _TokenInformationViewState();
}

class _TokenInformationViewState extends State<TokenInformationView> {
  final TokensCubit _vm = sl<TokensCubit>();

  @override
  void initState() {
    _vm.tokenInfoData = widget.tokenInfoData;
    _vm.getTokenInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _vm,
      child: BlocBuilder<TokensCubit, TokensState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: AppStrings.tokenInfo.tr,
              onBack: () {
                _onPopInvoked();
              },
            ),
            body: _vm.tokenInformationModel == null &&
                    _vm.tokenInfoError.isEmpty
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: kPrimaryColor,
                      size: 25.w,
                    ),
                  )
                : _vm.tokenInfoError.isNotEmpty
                    ? Center(
                        child: Text(
                          _vm.tokenInfoError,
                          style: context.textTheme.bodyLarge,
                        ),
                      )
                    : PopScope(
                        canPop: false,
                        onPopInvoked: (did) {
                          _onPopInvoked();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: 1.h,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 3.h,
                              ),
                              TokensInfoLCDWidget(vm: _vm),
                              SizedBox(
                                height: 5.h,
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppStrings.remainingToken.tr,
                                              style: context
                                                  .textTheme.headlineMedium!
                                                  .copyWith(
                                                color: kTextColor,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              _vm.tokenInformationModel
                                                      ?.remainingTokens
                                                      .toString() ??
                                                  '0',
                                              style: context
                                                  .textTheme.bodyLarge!
                                                  .copyWith(
                                                color: kTextColor,
                                                fontWeight: kFontWeightMedium,
                                              ),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 12.h,
                                        width: 0.3.w,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 1.w,
                                        ),
                                        color: kBorderColor,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppStrings.slot.tr,
                                              style: context
                                                  .textTheme.headlineMedium!
                                                  .copyWith(
                                                color: kTextColor,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              _vm.tokenInfoWithSlotModel
                                                          ?.slotName ==
                                                      null
                                                  ? AppStrings
                                                      .yourTokenIsNotInTheSlotYet
                                                      .tr
                                                  : '${AppStrings.pleaseGoTo.tr} ${_vm.tokenInfoWithSlotModel!.slotName}',
                                              style: context
                                                  .textTheme.bodyLarge!
                                                  .copyWith(
                                                color: kTextColor,
                                                fontWeight: kFontWeightMedium,
                                              ),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child:
                                            TokenInformationDetailsItemWidget(
                                          value: widget.tokenInfoData.orgName,
                                          icon: AssetsData.buildingSvg,
                                        ),
                                      ),
                                      Container(
                                        height: 12.h,
                                        width: 0.3.w,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 1.w,
                                        ),
                                        color: kBorderColor,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child:
                                            TokenInformationDetailsItemWidget(
                                          value: widget.tokenInfoData.depName,
                                          icon: AssetsData.serviceImage,
                                          isImage: true,
                                        ),
                                      ),
                                      Container(
                                        height: 12.h,
                                        width: 0.3.w,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 1.w,
                                        ),
                                        color: kBorderColor,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child:
                                            TokenInformationDetailsItemWidget(
                                          value:
                                              '${_vm.tokenInformationModel?.remainingTime.toString() ?? '0'} ${AppStrings.min.tr}',
                                          icon: AssetsData.clockSvg,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.5.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TokenInformationButtonWidget(
                                    text: AppStrings.cancelReservation.tr,
                                    color: kWhiteColor,
                                    icon: AssetsData.closeSvg,
                                    onPressed: () {
                                      _vm.onCancelPressed(
                                        vm: _vm,
                                        context: context,
                                        depId: widget.tokenInfoData.depId
                                            .toString(),
                                        tokenNumber: widget
                                            .tokenInfoData.tokenNumber
                                            .toString(),
                                        tokenScreen: false,
                                      );
                                    },
                                  ),
                                  TokenInformationButtonWidget(
                                    text: AppStrings.transferReservation.tr,
                                    color: kTransferButtonColor,
                                    icon: AssetsData.transferSvg,
                                    onPressed: () {
                                      _vm.onTransferPressed(
                                        context: context,
                                        vm: _vm,
                                        depId: widget.tokenInfoData.depId
                                            .toString(),
                                        tokenNumber: widget
                                            .tokenInfoData.tokenNumber
                                            .toString(),
                                      );
                                    },
                                  ),
                                  TokenInformationButtonWidget(
                                    text: AppStrings.delayReservation.tr,
                                    color: kDelayButtonColor,
                                    icon: AssetsData.delaySvg,
                                    fontWeight: kFontWeightBold,
                                    onPressed: () {
                                      _vm.delayToken(
                                        context: context,
                                        tokenScreen: false,
                                        tokenNumber: widget
                                            .tokenInfoData.tokenNumber
                                            .toString(),
                                        depId: widget.tokenInfoData.depId
                                            .toString(),
                                        orgName: widget.tokenInfoData.orgName
                                            .toString(),
                                        depName: widget.tokenInfoData.depName
                                            .toString(),
                                        branchId: widget.tokenInfoData.branchId
                                            .toString(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
          );
        },
      ),
    );
  }

  void _onPopInvoked() {
    if (_vm.tokenInformationModel?.remainingTokens == 0 &&
        _vm.tokenInfoWithSlotModel?.isServed == 1 &&
        _vm.tokenInfoWithSlotModel != null) {
      Get.dialog(
        TokenRatingDialog(
          tokenNumber: widget.tokenInfoData.tokenNumber,
          tokenId: _vm.tokenInfoWithSlotModel!.tokenId,
          depId: widget.tokenInfoData.depId,
          slotId: _vm.tokenInfoWithSlotModel!.slotId,
        ),
      );
    } else {
      Get.offAllNamed(AppRoutes.homeLayoutPath);
    }
  }
}
