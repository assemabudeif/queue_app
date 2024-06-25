import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors_light.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/localization/app_strings.dart';
import '/core/localization/language_manger.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/assets_data.dart';
import '/features/base/base_view_model.dart';
import '/features/settings/model/models/settings_model.dart';
import '/features/settings/model/repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> with BaseViewModel {
  SettingsCubit(this._settingsRepository) : super(SettingsInitial());

  final SettingsRepository _settingsRepository;
  late final List<SettingsModel> settings;

  @override
  void dispose() {}

  @override
  Future<void> init() async {
    settings = [
      SettingsModel(
        title: AppStrings.changeLanguage.tr,
        icon: AssetsData.languageSvg,
        onTap: (BuildContext context) {
          changeLanguage(context);
        },
      ),
      SettingsModel(
        title: AppStrings.termsAndConditions.tr,
        icon: AssetsData.termsImage,
        isSVG: false,
        onTap: () {},
      ),
      SettingsModel(
        title: AppStrings.privacyPolicy.tr,
        icon: AssetsData.privacySvg,
        onTap: () {},
      ),
      SettingsModel(
        title: AppStrings.logout.tr,
        icon: AssetsData.logoutSvg,
        onTap: (BuildContext context) {
          logout(context);
        },
      ),
    ];
  }

  void changeLanguage(BuildContext context) {
    emit(SettingsChangeAppLanguageInitialState());
    changeAppLanguage(context);
    emit(SettingsChangeAppLanguageSuccessState());
  }

  void logout(BuildContext context) {
    // await _removeSessionId();
    //
    // Get.offAllNamed(AppRoutes.loginPath);

    _showLogoutDialog(context);
  }

  _showLogoutDialog(BuildContext context) async {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        cancelButtonText: AppStrings.cancel.tr,
        type: ArtSweetAlertType.warning,
        title: AppStrings.logout.tr,
        text: AppStrings.areYouSureToLogout.tr,
        confirmButtonColor: kPrimaryColor,
        confirmButtonText: AppStrings.yes.tr,
        cancelButtonColor: kBorderColor.withOpacity(0.3),
        showCancelBtn: true,
        onConfirm: () {
          _logoutRequest();
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }

  _logoutRequest() async {
    emit(SettingsLogoutLoadingState());
    final result = await _settingsRepository.logout();
    result.fold(
      (failure) {
        AppSnackBars.showErrorSnackBar(
          message: failure.message,
          title: AppStrings.error.tr,
        );
        emit(SettingsLogoutErrorState());
      },
      (message) {
        AppSnackBars.showSuccessSnackBar(
          message: AppStrings.logoutSuccess.tr,
          title: AppStrings.logout.tr,
        );
        _removeSessionId();
        emit(SettingsLogoutSuccessState());
      },
    );
  }

  _removeSessionId() async {
    // remove session id from shared preferences
    await sl<AppPreferences>().removeSessionId();
    ApiConstance.sessionId = -1;

    Get.offAllNamed(AppRoutes.loginPath);
  }
}
