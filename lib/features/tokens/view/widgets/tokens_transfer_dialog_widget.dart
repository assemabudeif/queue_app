import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/features/tokens/view_model/tokens_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'tokens/token_button_widget.dart';
import 'tokens_dialog_header_widget.dart';

class TokensTransferDialogWidget extends StatelessWidget {
  const TokensTransferDialogWidget({
    super.key,
    required this.vm,
    required this.depId,
    required this.tokenNumber,
  });

  final TokensCubit vm;
  final String depId;
  final String tokenNumber;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokensCubit, TokensState>(
      bloc: vm,
      builder: (context, state) {
        return Dialog(
          child: SizedBox(
            width: 100.w,
            height: 30.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TokensDialogHeaderWidget(
                  title: AppStrings.transferReservation.tr,
                ),
                const Divider(
                  color: kBorderColor,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                      ),
                      height: 6.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.w),
                        color: kTextFieldFillColor,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextFormField(
                          controller: vm.transferNumberController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            prefixIcon: CountryCodePicker(
                              textOverflow: TextOverflow.ellipsis,
                              favorite: vm.favoriteCountryCode,
                              onChanged: vm.onChangeCountryCode,
                              initialSelection: vm.defaultCountrySelection,
                              textStyle: context.textTheme.bodyLarge,
                              flagWidth: 7.5.w,
                              padding: EdgeInsets.zero,
                            ),
                            filled: true,
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            hintText: AppStrings.phoneNumber.tr,
                          ),
                        ),
                      ),
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
                        text: AppStrings.cancel.tr,
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
                        text: AppStrings.send.tr,
                        onPressed: () {
                          if (vm.transferNumberController.text.isEmpty) {
                            AppSnackBars.showAlertSnackBar(
                              message: AppStrings.phoneNumberRequired.tr,
                            );
                          } else {
                            vm.transferToken(
                              depId: depId,
                              tokenNumber: tokenNumber,
                            );
                          }
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
