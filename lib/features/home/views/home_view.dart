
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/services/services_locator.dart';
import '/features/home/view_models/home_cubit.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'widgets/home_builders_list_widget.dart';
import 'widgets/home_search_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeCubit _vm = sl<HomeCubit>();

  @override
  void initState() {
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
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 3.h,
          ),
          child: Column(
            children: [
              HomeSearchWidget(
                vm: _vm,
                controller: _vm.searchController,
                searchMethod: (value) {
                  if (value.isNotEmpty) {
                    _vm.searchOrganizations();
                  } else {
                    _vm.getOrganizationsData();
                  }
                },
              ),
              SizedBox(height: 2.h),
              HomeBuildersListWidget(vm: _vm),
            ],
          ),
        ),
      ),
    );
  }
}
