import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import '/features/home/view_models/home_cubit.dart';

import 'home_loading_widget.dart';
import 'home_branches_list_widget.dart';

class HomeBuildersListWidget extends StatelessWidget {
  const HomeBuildersListWidget({
    super.key,
    required this.vm,
  });

  final HomeCubit vm;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<HomeCubit, HomeState>(
        bloc: vm,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeGetOrganizationsDataLoadingState) {
            return const Center(
              child: HomeLoadingWidget(),
            );
          } else if (state is HomeGetOrganizationsDataErrorState) {
            return Center(
              child: Text(
                state.message,
                style: context.textTheme.headlineMedium!.copyWith(
                  color: kTextColor,
                  fontWeight: kFontWeightMedium,
                ),
              ),
            );
          } else if (state is HomeGetOrganizationsDataSuccessState) {
            return RefreshIndicator(
              onRefresh: () async {
                await vm.refresh();
              },
              child: HomeBranchesListWidget(
                branches: state.organizationModel.data,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
