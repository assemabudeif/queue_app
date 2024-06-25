import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '/core/global/widgets/custom_network_image.dart';
import '/core/localization/app_strings.dart';
import '/core/localization/language_manger.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/font_manger.dart';
import '/features/home/model/models/branches_data_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeBranchesListWidget extends StatelessWidget {
  const HomeBranchesListWidget({
    super.key,
    required this.branches,
  });
  final List<BranchesDataModel> branches;

  @override
  Widget build(BuildContext context) {
    if (branches.isEmpty) {
      return Center(
        child: Text(
          AppStrings.empty.tr,
          style: context.textTheme.titleLarge!.copyWith(
            color: kTextColor.withOpacity(0.3),
            fontWeight: kFontWeightSemiBold,
          ),
        ),
      );
    }
    return ListView.separated(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.symmetric(vertical: 2.h),
      itemBuilder: (context, index) {
        return Container(
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.w)),
            border: Border.all(
              color: kHomeBorderColor,
              width: 1,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomNetworkImage(
                  imageUrl: branches[index].logoUrl,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          branches[index].brName,
                          style: context.textTheme.headlineMedium!.copyWith(
                            color: kTextColor,
                            fontWeight: kFontWeightMedium,
                          ),
                        ),
                        SizedBox(
                          height: 0.3.h,
                        ),
                        Text(
                          branches[index].brAddress.toString(),
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: kTextLightColor,
                            fontWeight: kFontWeightRegular,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (branches[index].brStatus == 1) {
                        Get.toNamed(
                          AppRoutes.organizationDetailsPath,
                          arguments: branches[index].brid.toString(),
                        );
                      } else {
                        ArtSweetAlert.show(
                          context: context,
                          artDialogArgs: ArtDialogArgs(
                            title: AppStrings.branchNotAvailable.tr,
                            dialogAlignment: Alignment.center,
                            confirmButtonColor: kPrimaryColor,
                            confirmButtonText: AppStrings.ok.tr,
                            type: ArtSweetAlertType.warning,
                            customColumns: [
                              Text(
                                '${AppStrings.branchAvailableDaysIs.tr}\n${_buildDaysString(branches[index].workingSchedule)}',
                                style: context.textTheme.bodyLarge!.copyWith(
                                  color: kTextColor,
                                  fontWeight: kFontWeightRegular,
                                ),
                                textAlign: getAppLanguageCode == 'ar'
                                    ? TextAlign.end
                                    : TextAlign.start,
                                maxLines: 10,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(4.w)),
                        border: Border.all(
                          color: kBlackColor,
                          width: 0.35.w,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.viewDetails.tr,
                            style: context.textTheme.bodyLarge!.copyWith(
                              color: kTextColor,
                              fontWeight: kFontWeightMedium,
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Icon(
                            getAppLanguageCode == 'ar'
                                ? FontAwesomeIcons.chevronLeft
                                : FontAwesomeIcons.chevronRight,
                            color: kTextColor,
                            size: 4.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 2.h,
      ),
      itemCount: branches.length,
    );
  }

  String _buildDaysString(List<WorkingSchedule> days) {
    String daysString = '';
    for (var day in days) {
      if (day.workStartTime.contains('close')) {
        daysString += '${day.workDays}: ${day.workStartTime}\n';
      } else {
        daysString +=
            '${day.workDays}: ${day.workStartTime} - ${day.workEndTime}\n';
      }
    }
    return daysString;
  }
}
