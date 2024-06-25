import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/core/localization/language_manger.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/assets_data.dart';
import '/core/utilities/enums.dart';
import '/features/auth/view_model/auth_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
    required this.vm,
  });
  final AuthCubit vm;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 45.h,
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        margin: EdgeInsets.only(top: 15.h),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 5.0.h,
              ),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Form(
                    key: vm.loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextFormField(
                            controller: vm.phoneNumberController,
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
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.phoneNumberRequired.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        DropdownButtonFormField<GenderEnum>(
                          hint: Text(
                            AppStrings.selectGender.tr,
                            style: context.textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          value: vm.genderValue,
                          icon: Image.asset(
                            AssetsData.arrowDownImage,
                            width: 3.w,
                          ),
                          isExpanded: true,
                          alignment: Alignment.center,
                          // itemHeight: 4.h,
                          items: [
                            ...GenderEnum.values.map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  getAppLanguageCode == 'ar'
                                      ? e.nameAr
                                      : e.nameEn,
                                  style: context.textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ],
                          onChanged: vm.onChangeGenderValue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(2.w),
                margin: EdgeInsets.only(top: 10.h),
                height: 10.h,
                width: 10.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: kShadowColor.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: vm.onLoginButtonPressed,
                  child: Image.asset(
                    AssetsData.loginImage,
                    width: 10.h,
                    height: 10.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
