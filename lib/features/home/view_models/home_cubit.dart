import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '/core/data/requests/find_organizations_data_reguest.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/localization/app_strings.dart';
import '/features/base/base_view_model.dart';
import '/features/home/model/models/branches_data_model.dart';
import '/features/home/model/repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with BaseViewModel {
  HomeCubit(this._homeRepository) : super(HomeInitial());

  final HomeRepository _homeRepository;

  late TextEditingController searchController;
  Position? _position;
  bool firstTimeForLocation = true;

  @override
  void dispose() {
    searchController.dispose();
    // close();
  }

  @override
  Future<void> init() async {
    searchController = TextEditingController();
    _position = await _determinePosition();
    getOrganizationsData();
  }

  refresh() {
    if (searchController.text.isEmpty) {
      getOrganizationsData();
    } else {
      searchOrganizations();
    }
    emit(HomeRefreshState());
  }

  void getOrganizationsData() async {
    _position = await _determinePosition();

    emit(HomeGetOrganizationsDataLoadingState());
    final result = await _homeRepository.findOrganizationsData(
      FindOrganizationsDataRequest(
        latitude: _position?.latitude ?? 0.0,
        longitude: _position?.longitude ?? 0.0,
      ),
    );
    result.fold(
      (failure) {
        log(failure.message, name: 'HomeCubit');

        emit(HomeGetOrganizationsDataErrorState(message: failure.message));
      },
      (organizationModel) {
        log(organizationModel.data.toString(), name: 'HomeCubit Data');
        emit(HomeGetOrganizationsDataSuccessState(
          organizationModel: organizationModel,
        ));
      },
    );
  }

  void searchOrganizations() async {
    emit(HomeGetOrganizationsDataLoadingState());
    final result = await _homeRepository.searchOrganizations(
      searchController.text,
    );
    result.fold(
      (failure) {
        log(failure.message, name: 'HomeCubit');
        emit(HomeGetOrganizationsDataErrorState(message: failure.message));
      },
      (organizationModel) {
        log(organizationModel.data.toString(), name: 'HomeCubit Data');
        // final distanceBetween = Geolocator.distanceBetween(
        //   _position?.latitude ?? 0.0,
        //   _position?.longitude ?? 0.0,
        //   organizationModel.data[0].orgLat,
        //   organizationModel.data[0].orgLong,
        // );

        // log('Distance Between: $distanceBetween', name: 'HomeCubit Data');

        emit(
          HomeGetOrganizationsDataSuccessState(
            organizationModel: organizationModel,
          ),
        );
      },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AppSnackBars.showAlertSnackBar(
          message: AppStrings.locationPermissionsAreDenied.tr,
        );
        return Future.error(AppStrings.locationPermissionsAreDenied.tr);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      AppSnackBars.showAlertSnackBar(
        message: AppStrings.locationPermissionsAreDenied.tr,
      );
      return Future.error(
        AppStrings.locationPermissionsAreDenied.tr,
      );
    }

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && firstTimeForLocation) {
      // AppSnackBars.showErrorSnackBar(
      //   title: AppStrings.error.tr,
      //   message: AppStrings.locationServicesAreDisabled.tr,
      // );
      Geolocator.openLocationSettings();
      firstTimeForLocation = false;
      getOrganizationsData();

      return Future.error(AppStrings.locationServicesAreDisabled.tr);
    }

    return await Geolocator.getCurrentPosition();
  }
}
