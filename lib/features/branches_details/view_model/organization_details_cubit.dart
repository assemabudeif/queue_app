import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/data/models/TokenInfoDataModel.dart';
import '/core/functions/remove_session_after_check.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/localization/app_strings.dart';
import '/core/utilities/app_routes.dart';
import '/features/base/base_view_model.dart';
import '/features/branches_details/model/models/organization_details_model.dart';
import '/features/branches_details/model/models/remaining_tokens_without_token_model.dart';
import '/features/branches_details/model/repository/organization_details_repository.dart';
import '/features/branches_details/view/widgets/get_token_dialog_widget.dart';

part 'organization_details_state.dart';

class OrganizationDetailsCubit extends Cubit<OrganizationDetailsState>
    with BaseViewModel {
  OrganizationDetailsCubit(this._organizationDetailsRepository)
      : super(OrganizationDetailsInitial());

  final OrganizationDetailsRepository _organizationDetailsRepository;

  String orgId = '';
  OrganizationDetailsModel? organizationDetailsModel;
  String orgError = '';
  @override
  Future<void> init() async {
    getOrganizationDetails(orgId);
  }

  @override
  void dispose() {}

  getOrganizationDetails(String orgId) async {
    emit(GetOrganizationDetailsLoading());
    final result =
        await _organizationDetailsRepository.getOrganizationDetails(orgId);
    result.fold(
      (error) {
        orgError = error.message;
        emit(GetOrganizationDetailsFailed());
      },
      (organizationDetailsModel) {
        this.organizationDetailsModel = organizationDetailsModel;
        emit(GetOrganizationDetailsSuccess());
      },
    );
  }

  void onRefresh() {
    getOrganizationDetails(orgId);
  }

  void onGenerateTokenPressed({
    required String depId,
    required String branchId,
    required String depName,
    required String orgName,
  }) async {
    emit(GenerateTokenLoading());
    final result = await _organizationDetailsRepository.generateToken(
      depId: depId,
      branchId: branchId,
    );
    result.fold(
      (error) => emit(GenerateTokenFailed(error.message)),
      (generateTokenModel) {
        if (generateTokenModel.exist == 0) {
          removeSessionAfterCheck();
        } else if (generateTokenModel.tokenNumber == 0) {
          AppSnackBars.showAlertSnackBar(
            message: AppStrings.noTokenAvailable.tr,
          );
        } else {
          Get.toNamed(
            AppRoutes.tokenInformationPath,
            arguments: TokenInfoScreenDataModel(
              tokenNumber: generateTokenModel.tokenNumber,
              depId: int.parse(depId),
              depName: depName,
              orgName: orgName,
              branchId: int.parse(branchId),
            ),
          );
        }
        emit(GenerateTokenSuccess());
      },
    );
  }

  void onGetRemainingTokensWithoutTokenPressed({
    required BuildContext context,
    required String depId,
    required String branchId,
    required String depName,
    required String orgName,
  }) async {
    emit(GetRemainingTokensWithoutTokenLoading());
    final result = await _organizationDetailsRepository
        .getRemainingTokensWithoutToken(depId);
    result.fold(
      (error) {
        emit(GetRemainingTokensWithoutTokenFailed(error.message));
      },
      (remainingTokensWithoutTokenModel) {
        if (remainingTokensWithoutTokenModel.exist == 0) {
          removeSessionAfterCheck();
        } else if (remainingTokensWithoutTokenModel.bookingAvailable == 0) {
          AppSnackBars.showAlertSnackBar(
            message: AppStrings.noTokenAvailable.tr,
          );
        } else {
          _showGetTokenDialog(
            context: context,
            depId: depId,
            branchId: branchId,
            depName: depName,
            orgName: orgName,
            remainingTokensWithoutTokenModel: remainingTokensWithoutTokenModel,
          );
        }
        emit(GetRemainingTokensWithoutTokenSuccess());
      },
    );
  }

  void _showGetTokenDialog({
    required BuildContext context,
    required String depId,
    required String branchId,
    required String depName,
    required String orgName,
    required RemainingTokensWithoutTokenModel remainingTokensWithoutTokenModel,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return GetTokenDialogWidget(
          depId: depId,
          branchId: branchId,
          orgName: orgName,
          depName: depName,
          remainingTokensWithoutTokenModel: remainingTokensWithoutTokenModel,
        );
      },
    );
  }
}
