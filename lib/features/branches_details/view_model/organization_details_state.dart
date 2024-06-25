part of 'organization_details_cubit.dart';

@immutable
abstract class OrganizationDetailsState {}

class OrganizationDetailsInitial extends OrganizationDetailsState {}

class GetOrganizationDetailsLoading extends OrganizationDetailsState {}

class GetOrganizationDetailsSuccess extends OrganizationDetailsState {}

class GetOrganizationDetailsFailed extends OrganizationDetailsState {}

class GenerateTokenLoading extends OrganizationDetailsState {}

class GenerateTokenSuccess extends OrganizationDetailsState {}

class GenerateTokenFailed extends OrganizationDetailsState {
  final String error;

  GenerateTokenFailed(this.error);
}

class GetRemainingTokensWithoutTokenLoading extends OrganizationDetailsState {}

class GetRemainingTokensWithoutTokenSuccess extends OrganizationDetailsState {}

class GetRemainingTokensWithoutTokenFailed extends OrganizationDetailsState {
  final String error;

  GetRemainingTokensWithoutTokenFailed(this.error);
}
