import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/features/tokens/model/models/token_info_with_slot_model.dart';
import '/core/data/models/TokenInfoDataModel.dart';
import '/core/functions/remove_session_after_check.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/localization/app_strings.dart';
import '/core/services/notifications_service.dart';
import '/core/utilities/app_routes.dart';
import '/features/base/base_view_model.dart';
import '/features/branches_details/model/repository/organization_details_repository.dart';
import '/features/tokens/model/models/token_information_model.dart';
import '/features/tokens/model/models/tokens_model.dart';
import '/features/tokens/model/repository/tokens_repository.dart';
import '/features/tokens/view/widgets/tokens_cancel_dialog_widget.dart';
import '/features/tokens/view/widgets/tokens_delay_dialog_widget.dart';
import '/features/tokens/view/widgets/tokens_transfer_dialog_widget.dart';

part 'tokens_state.dart';

class TokensCubit extends Cubit<TokensState> with BaseViewModel {
  TokensCubit(this._tokensRepository, this._organizationDetailsRepository)
      : super(TokensInitial());

  final TokensRepository _tokensRepository;
  final OrganizationDetailsRepository _organizationDetailsRepository;

  final String defaultCountrySelection = 'AE';
  final List<String> favoriteCountryCode = ['EG', 'AE', 'SA'];
  String _countryCodeDail = '+971';
  TextEditingController transferNumberController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  double rating = 0;

  TokensViewModel? tokenViewModel;
  String tokensViewError = '';

  TokenInformationModel? tokenInformationModel;
  String tokenInfoError = '';
  late TokenInfoScreenDataModel tokenInfoData;

  int _currentRemainingTokensNumber = -1;

  TokenInfoWithSlotModel? tokenInfoWithSlotModel;

  @override
  Future<void> init() async {
    getAllTokens();
  }

  @override
  void dispose() {
    transferNumberController.dispose();
    questionController.dispose();
  }

  refreshTokensView() {
    tokenViewModel = null;
    tokensViewError = '';
    getAllTokens();
  }

  getAllTokens() async {
    emit(GetAllTokensLoading());
    final response = await _tokensRepository.getAllTokens();
    response.fold(
      (l) {
        log(l.message, name: 'Get All Tokens Failure');
        tokensViewError = l.message;
        emit(GetAllTokensFailure(l.message));
      },
      (r) {
        tokenViewModel = r;
        emit(GetAllTokensSuccess(r));
      },
    );
  }

  getTokenInfo() async {
    emit(GetTokenInformationLoadingState());
    final response = await _tokensRepository.getTokenInformation(
      depId: tokenInfoData.depId.toString(),
      tokenNumber: tokenInfoData.tokenNumber.toString(),
    );
    response.fold(
      (l) {
        log(l.message, name: 'Get Token Failure');
        tokenInfoError = l.message;

        emit(GetTokenInformationErrorState());
      },
      (r) {
        tokenInformationModel = r;
        if (_currentRemainingTokensNumber != r.remainingTokens &&
            r.remainingTokens != 0) {
          NotificationsService.createNewNotification(
            title:
                "${AppStrings.remainingToken.tr} ${AppStrings.forService.tr}: ${tokenInfoData.depName}",
            description: r.remainingTokens.toString(),
          );
          _currentRemainingTokensNumber = r.remainingTokens;
        }
        if (r.remainingTokens == 0) {
          getTokenInfoWithSlot();
        }

        emit(GetTokenInformationSuccessState());
      },
    );
  }

  getTokenInfoWithSlot() async {
    emit(GetTokenInfoWithSlotLoading());
    final response = await _tokensRepository.getTokenInfoWithSlot(
      depId: tokenInfoData.depId.toString(),
      tokenNumber: tokenInfoData.tokenNumber.toString(),
    );
    response.fold(
      (l) {
        log(l.message, name: 'Get Token Failure');
        if (l.message != AppStrings.oopsThereWasAnErrorPleaseTryAgainLater.tr) {
          AppSnackBars.showErrorSnackBar(
            message: l.message,
            title: AppStrings.error.tr,
          );
        }

        emit(GetTokenInfoWithSlotFailed());
      },
      (r) {
        tokenInfoWithSlotModel = r;
        emit(GetTokenInfoWithSlotSuccess());
      },
    );
  }

  void onChangeCountryCode(CountryCode value) {
    _countryCodeDail = value.dialCode!;
    log(_countryCodeDail, name: 'CountryCode');
    log(value.code!, name: 'CountryCode');
  }

  void onDelayPressed({
    required BuildContext context,
    required TokensCubit vm,
    required String remainingToken,
    required String estimatedToken,
    required String tokenNumber,
    required String depId,
    required String branchId,
    required String orgName,
    required String depName,
    required bool tokenScreen,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return TokensDelayDialogWidget(
          vm: vm,
          remainingToken: remainingToken,
          estimatedToken: estimatedToken,
          depId: depId,
          branchId: branchId,
          orgName: orgName,
          depName: depName,
          tokenNumber: tokenNumber,
          tokenScreen: tokenScreen,
        );
      },
    );
  }

  void onCancelPressed({
    required BuildContext context,
    required TokensCubit vm,
    required String depId,
    required String tokenNumber,
    required bool tokenScreen,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return TokensCancelDialogWidget(
          vm: vm,
          depId: depId,
          tokenNumber: tokenNumber,
          tokensScreen: tokenScreen,
        );
      },
    );
  }

  void onTransferPressed({
    required BuildContext context,
    required TokensCubit vm,
    required String depId,
    required String tokenNumber,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return TokensTransferDialogWidget(
          vm: vm,
          depId: depId,
          tokenNumber: tokenNumber,
        );
      },
    );
  }

  Future<void> cancelToken({
    required String tokenNumber,
    required String depId,
    required Function afterCancel,
  }) async {
    emit(CancelTokenLoadingState());
    final result = await _tokensRepository.cancelToken(
      tokenNumber: tokenNumber,
      depId: depId,
    );

    result.fold(
      (l) {
        AppSnackBars.showErrorSnackBar(
          message: l.message,
          title: AppStrings.error.tr,
        );
        emit(CancelTokenErrorState());
      },
      (r) {
        if (r.exist == 0) {
          removeSessionAfterCheck();
        } else {
          if (r.cancelled == 0) {
            AppSnackBars.showAlertSnackBar(
              message: AppStrings.cantCanceledTokenTryAgain.tr,
            );
            emit(CancelTokenErrorState());
          } else {
            afterCancel();
            emit(CancelTokenSuccessState());
          }
        }
      },
    );
  }

  delayToken({
    required BuildContext context,
    required String depId,
    required String branchId,
    required String depName,
    required String orgName,
    required String tokenNumber,
    required bool tokenScreen,
  }) async {
    await _onGetRemainingTokensWithoutTokenPressed(
      context: context,
      depId: depId,
      branchId: branchId,
      depName: depName,
      orgName: orgName,
      tokenNumber: tokenNumber,
      tokenScreen: tokenScreen,
    );
  }

  void onGenerateTokenPressed({
    required String depId,
    required String branchId,
    required String depName,
    required String orgName,
    required bool tokenScreen,
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
        } else {
          if (tokenScreen) {
            refreshTokensView();
          } else {
            tokenInfoData = TokenInfoScreenDataModel(
              depId: int.parse(depId),
              branchId: int.parse(branchId),
              depName: depName,
              orgName: orgName,
              tokenNumber: generateTokenModel.tokenNumber,
            );
            tokenInformationModel = null;
            tokenInfoError = '';
            getTokenInfo();
          }
        }
        emit(GenerateTokenSuccess());
      },
    );
  }

  Future<void> _onGetRemainingTokensWithoutTokenPressed({
    required BuildContext context,
    required String depId,
    required String branchId,
    required String depName,
    required String orgName,
    required String tokenNumber,
    required bool tokenScreen,
  }) async {
    emit(GetRemainingTokensWithoutTokenLoading());
    final result = await _tokensRepository
        .getRemainingTokensWithoutTokenWithReservation(depId);
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
          onDelayPressed(
            branchId: branchId,
            context: context,
            depName: depName,
            depId: depId,
            vm: this,
            orgName: orgName,
            tokenNumber: tokenNumber,
            tokenScreen: tokenScreen,
            estimatedToken:
                remainingTokensWithoutTokenModel.remainingTime.toString(),
            remainingToken:
                remainingTokensWithoutTokenModel.remainingTokens.toString(),
          );
        }
        emit(GetRemainingTokensWithoutTokenSuccess());
      },
    );
  }

  transferToken({
    required String depId,
    required String tokenNumber,
  }) async {
    emit(TransferTokenLoading());
    final result = await _tokensRepository.transferToken(
      depId: depId,
      phoneNumber: _countryCodeDail + transferNumberController.text,
      tokenNumber: tokenNumber,
    );
    result.fold(
      (error) {
        emit(TransferTokenFailed());
      },
      (transferTokenModel) {
        if (transferTokenModel.receiverExist == 0) {
          AppSnackBars.showAlertSnackBar(
            message: AppStrings.phoneNumberNotFound.tr,
          );
        } else {
          AppSnackBars.showSuccessSnackBar(
            message: AppStrings.tokenTransferredSuccessfully.tr,
            title: AppStrings.success.tr,
          );
          Get.offAllNamed(AppRoutes.homeLayoutPath);
          emit(TransferTokenSuccess());
        }
      },
    );
  }
}
