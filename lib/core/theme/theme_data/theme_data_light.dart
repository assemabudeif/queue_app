import 'package:flutter/material.dart';
import '/core/theme/app_colors_light.dart';
import '/core/theme/text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/utilities/font_manger.dart';

ThemeData get getThemeDataLight => ThemeData(
      /// Theme Colors
      primaryColor: kPrimaryColor,
      primarySwatch: kPrimarySwatchColor,
      scaffoldBackgroundColor: kDefaultBackground,
      hintColor: kHintColor,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kPrimaryColor,
      ),
      dividerColor: kDividerColor,
      colorScheme: const ColorScheme.light(
        primary: kPrimaryColor,
        secondary: kPrimaryColor,
        background: kDefaultBackground,
        error: kErrorColor,
      ),

      /// App Bar Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        color: kDefaultBackground,
        actionsIconTheme: IconThemeData(
          color: kDefaultIconColor,
        ),
        titleTextStyle: getMediumStyle.copyWith(
          color: kTextColor,
          fontSize: 24.sp,
          fontFamily: kSFProRoundedFontFamily,
        ),
        iconTheme: IconThemeData(
          color: kDefaultIconColor,
        ),
      ),

      /// Primary Text Theme
      primaryTextTheme: TextTheme(
        titleLarge: getBoldStyle,
        titleMedium: getSemiBoldStyle,
        titleSmall: getMediumStyle.copyWith(fontWeight: kFontWeightBold),
        bodyLarge: getMediumStyle,
        bodyMedium: getRegularStyle,
        bodySmall: getLightStyle,
        displayLarge: getBoldStyle.copyWith(
            fontSize: 32.sp, color: kTextColor.withOpacity(0.8)),
        displayMedium: getBoldStyle.copyWith(
            fontSize: 24.sp, color: kTextColor.withOpacity(0.8)),
        displaySmall: getBoldStyle.copyWith(
            fontSize: 18.sp, color: kTextColor.withOpacity(0.8)),
        headlineLarge: getBoldStyle.copyWith(fontSize: 24.sp),
        headlineMedium: getBoldStyle.copyWith(fontSize: 18.sp),
        headlineSmall: getBoldStyle.copyWith(fontSize: 14.sp),
        labelLarge: getMediumStyle.copyWith(fontSize: 18.sp),
        labelMedium: getMediumStyle.copyWith(fontSize: 14.sp),
        labelSmall: getMediumStyle.copyWith(fontSize: 12.sp),
      ),

      /// Text Theme
      textTheme: TextTheme(
        titleLarge: getBoldStyle,
        titleMedium: getSemiBoldStyle,
        titleSmall: getMediumStyle,
        bodyLarge: getMediumStyle,
        bodyMedium: getRegularStyle,
        bodySmall: getLightStyle,
        displayLarge: getBoldStyle.copyWith(
            fontSize: 32.sp, color: kTextColor.withOpacity(0.8)),
        displayMedium: getBoldStyle.copyWith(
            fontSize: 24.sp, color: kTextColor.withOpacity(0.8)),
        displaySmall: getBoldStyle.copyWith(
            fontSize: 18.sp, color: kTextColor.withOpacity(0.8)),
        headlineLarge: getBoldStyle.copyWith(fontSize: 24.sp),
        headlineMedium: getBoldStyle.copyWith(fontSize: 18.sp),
        headlineSmall: getBoldStyle.copyWith(fontSize: 14.sp),
        labelLarge: getMediumStyle.copyWith(fontSize: 18.sp),
        labelMedium: getMediumStyle.copyWith(fontSize: 14.sp),
        labelSmall: getMediumStyle.copyWith(fontSize: 12.sp),
      ),

      /// Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: getRegularStyle,
          minimumSize: Size(70.w, 8.h),
        ),
      ),

      /// Card Theme
      cardTheme: CardTheme(
        elevation: 8,
        surfaceTintColor: kWhiteColor,
        color: kWhiteColor,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shadowColor: kShadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),

      /// Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        fillColor: kTextFieldFillColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kBorderColor,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kBorderColor,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kBorderColor,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kErrorColor,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kErrorColor,
          ),
        ),
        labelStyle: getMediumStyle.copyWith(color: kTextColor),
        hintStyle: getMediumStyle.copyWith(color: kHintColor),
        errorStyle: getMediumStyle.copyWith(color: kErrorColor),
      ),

      /// Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: getMediumStyle.copyWith(
            color: kTextButtonColor,
          ),
        ),
      ),
    );
