import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '/core/global/widgets/custom_app_bar.dart';
import '/core/localization/app_strings.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import '/features/branches_details/view/widgets/organization_details_success_widget.dart';
import '/features/branches_details/view_model/organization_details_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'widgets/organization_details_loading_widget.dart';

class OrganizationDetailsView extends StatefulWidget {
  const OrganizationDetailsView({
    super.key,
    required this.orgId,
  });

  final String orgId;

  @override
  State<OrganizationDetailsView> createState() =>
      _OrganizationDetailsViewState();
}

class _OrganizationDetailsViewState extends State<OrganizationDetailsView> {
  final OrganizationDetailsCubit _vm = sl<OrganizationDetailsCubit>();

  @override
  void initState() {
    _vm.orgId = widget.orgId;
    _vm.init();
    super.initState();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _vm,
      child: BlocBuilder<OrganizationDetailsCubit, OrganizationDetailsState>(
        bloc: _vm,
        builder: (context, state) {
          if (_vm.organizationDetailsModel == null && _vm.orgError.isEmpty) {
            return const OrganizationDetailsLoadingWidget();
          } else if (_vm.orgError.isNotEmpty) {
            return Center(
              child: Scaffold(
                appBar: CustomAppBar(
                  title: AppStrings.error.tr,
                ),
                body: Center(
                  child: Text(
                    _vm.orgError,
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: kFontWeightBold,
                      fontSize: 17.sp,
                    ),
                  ),
                ),
              ),
            );
          } else if (_vm.organizationDetailsModel != null &&
              _vm.organizationDetailsModel!.data.isEmpty) {
            return Center(
              child: Scaffold(
                appBar: const CustomAppBar(),
                body: Center(
                  child: Text(
                    AppStrings.empty.tr,
                    style: context.textTheme.titleLarge!.copyWith(
                      fontWeight: kFontWeightSemiBold,
                      color: kTextLightColor.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            );
          }
          return OrganizationDetailsSuccessWidget(
            vm: _vm,
          );
        },
      ),
    );
  }
}
