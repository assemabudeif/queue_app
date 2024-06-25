import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';

class TokensTextItemWidget extends StatelessWidget {
  const TokensTextItemWidget({
    super.key,
    required this.text,
    required this.value,
    this.textColor = kTokenTextColor,
    this.colonColor,
  });

  final String text;
  final String value;
  final Color textColor;
  final Color? colonColor;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        children: [
          TextSpan(
            text: ': ',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: kFontWeightSemiBold,
              color: colonColor,
            ),
          ),
          TextSpan(
            text: value,
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: kFontWeightSemiBold,
            ),
          ),
        ],
      ),
      style: context.textTheme.bodyLarge!.copyWith(
        fontWeight: kFontWeightSemiBold,
        color: textColor,
      ),
    );
  }
}
