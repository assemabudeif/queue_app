import 'package:flutter/material.dart';
import '/core/functions/build_material_color.dart';

const Color kPrimaryColor = Color(0xFFFFE393);
MaterialColor kPrimarySwatchColor = buildMaterialColor(const Color(0xFFFFE393));
const Color kHintColor = Color(0xFF707070);
const Color kTextColor = Color(0xFF000000);
Color kTextLightColor = const Color(0xFF000000).withOpacity(0.6);
const Color kDefaultBackground = Color(0xFFffffff);
Color kDefaultIconColor = const Color(0xFF000000);
Color kIconLightColor = const Color(0xFF3C3C43).withOpacity(0.6);
const Color kTextFieldFillColor = Color(0xFFF2F2F7);
const kSuccessColor = Color(0xFF00C851);
const kErrorColor = Color(0xFFff4444);
const kAlertColor = Color(0xFFffbb33);
const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF000000);
Color kShadowColor = buildMaterialColor(Colors.black).shade200;
const kBorderColor = Color(0xFF929292);
const kHomeBorderColor = Color(0xFFE0E0E0);
Color kDividerColor = const Color(0xFF292826).withOpacity(0.2);
const kTransparentColor = Colors.transparent;
const kTextButtonColor = Color(0xff885EFF);
const kTokenTextColor = Color(0xff2B3594);
const kOtpButtonColor = Color(0xff263238);
Color kTokenCardColor = const Color(0xffFBFBFB).withOpacity(0.1);
Color kTokenCardShadowColor = const Color.fromRGBO(0, 0, 0, 0.25);
const Color kTokenNumberColor = Color(0xFFFA4A0C);
const Color kTokenDisableNumberColor = Color(0xFF313131);
const Color kTransferButtonColor = Color(0xFFE0E0E0);
const Color kDelayButtonColor = Color(0xFFFFE393);
LinearGradient kShimmerGradientColor = LinearGradient(
  colors: [
    Colors.grey[300]!,
    Colors.grey[100]!,
    Colors.grey[300]!,
  ],
);
