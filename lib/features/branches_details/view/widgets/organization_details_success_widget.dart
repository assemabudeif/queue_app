import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/global/widgets/custom_app_bar.dart';
import '/core/global/widgets/custom_network_image.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import '/features/branches_details/view_model/organization_details_cubit.dart';
import '/features/tokens/view/widgets/tokens/token_button_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrganizationDetailsSuccessWidget extends StatelessWidget {
  const OrganizationDetailsSuccessWidget({
    super.key,
    required this.vm,
  });
  final OrganizationDetailsCubit vm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: vm.organizationDetailsModel?.data[0].branchName ?? '',
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.w,
          mainAxisSpacing: 4.w,
          mainAxisExtent: 31.h,
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        itemCount: vm.organizationDetailsModel?.data.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(3.w),
            ),
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                Expanded(
                  child: CustomNetworkImage(
                    imageUrl: vm.organizationDetailsModel!.data[index].logoUrl,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  vm.organizationDetailsModel!.data[index].deptName,
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: kFontWeightBold,
                    fontSize: 17.sp,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: 3.h),
                TokenButtonWidget(
                  text: AppStrings.getToken.tr,
                  onPressed: () {
                    vm.onGetRemainingTokensWithoutTokenPressed(
                      context: context,
                      depId: vm.organizationDetailsModel!.data[index].deptId
                          .toString(),
                      branchId: vm
                          .organizationDetailsModel!.data[index].branchId
                          .toString(),
                      depName:
                          vm.organizationDetailsModel!.data[index].deptName,
                      orgName: vm.organizationDetailsModel!.data[index]
                          .organization.orgName,
                    );
                  },
                  color: kPrimaryColor,
                  width: double.infinity,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
