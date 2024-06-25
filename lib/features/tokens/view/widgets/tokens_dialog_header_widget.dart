import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '/core/utilities/font_manger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TokensDialogHeaderWidget extends StatelessWidget {
  const TokensDialogHeaderWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 2.h,
      ),
      child: SizedBox(
        height: 3.h,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              left: 0,
              child: Text(
                title,
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: kFontWeightSemiBold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            PositionedDirectional(
              start: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  FontAwesomeIcons.xmark,
                  size: 5.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
