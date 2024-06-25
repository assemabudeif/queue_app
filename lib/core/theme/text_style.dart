import 'package:flutter/material.dart';
import '/core/utilities/font_manger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_colors_light.dart';

TextStyle _getTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight = kFontWeightRegular,
  FontStyle fontStyle = FontStyle.normal,
  String fontFamily = kDefaultFontFamily,
}) {
  return TextStyle(
    color: color ?? kTextColor,
    fontSize: fontSize ?? 16.sp,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    fontFamily: fontFamily,
    overflow: TextOverflow.ellipsis,
  );
}

TextStyle get getBoldStyle {
  return _getTextStyle(
    fontWeight: kFontWeightBold,
    fontSize: 25.sp,
    color: kPrimaryColor,
  );
}

TextStyle get getSemiBoldStyle {
  return _getTextStyle(
    fontWeight: kFontWeightBold,
    fontSize: 18.sp,
    color: kTextColor,
  );
}

TextStyle get getMediumStyle {
  return _getTextStyle(
    fontWeight: kFontWeightMedium,
    fontSize: 16.sp,
    color: kTextColor,
  );
}

TextStyle get getRegularStyle {
  return _getTextStyle(
    fontWeight: kFontWeightRegular,
    fontSize: 14.sp,
    color: kTextColor,
  );
}

TextStyle get getLightStyle {
  return _getTextStyle(
    fontWeight: kFontWeightLight,
    fontSize: 12.sp,
    color: kTextColor,
  );
}
