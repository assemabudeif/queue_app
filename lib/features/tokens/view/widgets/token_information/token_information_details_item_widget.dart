import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/core/utilities/font_manger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TokenInformationDetailsItemWidget extends StatelessWidget {
  const TokenInformationDetailsItemWidget({
    super.key,
    required this.value,
    required this.icon,
    this.isImage = false,
  });

  final String value;
  final String icon;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      // width: 30.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (isImage)
            Image.asset(
              icon,
              width: 8.w,
            )
          else
            SvgPicture.asset(
              icon,
              width: 6.5.w,
            ),
          SizedBox(
            height: 1.h,
          ),
          Expanded(
            child: Center(
              child: Text(
                value,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: kFontWeightMedium,
                  fontFamily: kSFProRoundedFontFamily,
                ),
                textWidthBasis: TextWidthBasis.parent,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
