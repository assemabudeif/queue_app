import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '/core/data/models/TokenInfoDataModel.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/font_manger.dart';
import '/features/tokens/view_model/tokens_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'tokens_item_widget.dart';
import 'tokens_loading_view.dart';

class TokensListWidget extends StatelessWidget {
  const TokensListWidget({super.key, required this.vm});

  final TokensCubit vm;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokensCubit, TokensState>(
      bloc: vm,
      builder: (context, state) {
        if (vm.tokenViewModel == null && vm.tokensViewError.isEmpty) {
          return const TokensLoadingView();
        } else if (vm.tokensViewError.isNotEmpty) {
          return Center(
            child: Text(
              vm.tokensViewError,
              style: context.textTheme.bodyLarge,
            ),
          );
        } else if (vm.tokenViewModel?.data.isEmpty ?? true) {
          return Center(
            child: Text(
              AppStrings.empty.tr,
              style: context.textTheme.titleLarge!.copyWith(
                color: kTextLightColor.withOpacity(0.3),
                fontWeight: kFontWeightSemiBold,
              ),
            ),
          );
        } else {
          return ListView.separated(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.tokenInformationPath,
                    arguments: TokenInfoScreenDataModel(
                      branchId:
                          vm.tokenViewModel!.data[index].department.branchId,
                      orgName: vm.tokenViewModel!.data[index].department
                          .organization.orgName,
                      depId: vm.tokenViewModel!.data[index].department.deptId,
                      tokenNumber: vm.tokenViewModel!.data[index].tokenNumber,
                      depName:
                          vm.tokenViewModel!.data[index].department.deptName,
                    ),
                  );
                },
                child: TokensItemWidget(
                  token: vm.tokenViewModel!.data[index],
                  onDelayPressed: () {
                    vm.delayToken(
                      branchId: vm
                          .tokenViewModel!.data[index].department.branchId
                          .toString(),
                      tokenScreen: true,
                      depId: vm.tokenViewModel!.data[index].department.deptId
                          .toString(),
                      context: context,
                      orgName: vm.tokenViewModel!.data[index].department
                          .organization.orgName,
                      depName:
                          vm.tokenViewModel!.data[index].department.deptName,
                      tokenNumber:
                          vm.tokenViewModel!.data[index].tokenNumber.toString(),
                    );
                  },
                  onCancelPressed: () {
                    vm.onCancelPressed(
                      context: context,
                      tokenScreen: true,
                      vm: vm,
                      tokenNumber:
                          vm.tokenViewModel!.data[index].tokenNumber.toString(),
                      depId: vm.tokenViewModel!.data[index].department.deptId
                          .toString(),
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
            itemCount: vm.tokenViewModel!.data.length,
          );
        }
      },
    );
  }
}
