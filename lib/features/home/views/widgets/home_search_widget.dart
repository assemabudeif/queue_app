import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/assets_data.dart';
import '/features/home/view_models/home_cubit.dart';
import '/features/home/views/qr_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({
    super.key,
    required this.controller,
    required this.searchMethod,
    required this.vm,
  });

  final TextEditingController controller;
  final Function(String) searchMethod;
  final HomeCubit vm;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.elliptical(3.w, 2.w)),
      ),
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: (value) {
          searchMethod(value);
        },
        onChanged: (value) {
          searchMethod(value);
        },
        decoration: InputDecoration(
          hintText: AppStrings.search.tr,
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          filled: true,
          prefixIcon: Icon(
            FontAwesomeIcons.search,
            size: 5.w,
            color: kIconLightColor,
          ),
          suffixIcon: Container(
            margin: EdgeInsetsDirectional.only(end: 5.w),
            child: InkWell(
              onTap: () async {
                controller.text = await Get.to(() => const QRScanPage()) ?? '';
                vm.searchOrganizations();
              },
              child: SvgPicture.asset(
                AssetsData.qrSvg,
                width: 4.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
