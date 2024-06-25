part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeGetOrganizationsDataLoadingState extends HomeState {}

class HomeGetOrganizationsDataSuccessState extends HomeState {
  final BranchesModel organizationModel;

  HomeGetOrganizationsDataSuccessState({required this.organizationModel});
}

class HomeGetOrganizationsDataErrorState extends HomeState {
  final String message;

  HomeGetOrganizationsDataErrorState({required this.message});
}

class HomeRefreshState extends HomeState {}
