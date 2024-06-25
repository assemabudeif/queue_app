import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '/core/theme/app_colors_light.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.btnColor = kPrimaryColor,
    this.textColor = kTextColor,
  });

  final String text;
  final Color btnColor;
  final Color textColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      color: btnColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.elliptical(3.w, 2.w)),
      ),
      elevation: 0.0,
      height: 6.h,
      minWidth: 70.w,
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
