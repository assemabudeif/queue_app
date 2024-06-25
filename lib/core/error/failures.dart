import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '/core/localization/app_strings.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.formDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          AppStrings.connectionTimeoutWithApiServer.tr,
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          AppStrings.receiveTimeoutWithApiServer.tr,
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(AppStrings.sendTimeoutWithApiServer.tr);
      case DioExceptionType.cancel:
        return ServerFailure(
          AppStrings.yourRequestWithApiServerWasCanceled.tr,
        );
      case DioExceptionType.badResponse:
        {
          return ServerFailure.fromResponse(
            statusCode: dioException.response!.statusCode!,
            response: dioException.response!.data,
          );
        }
      case DioExceptionType.badCertificate:
        return ServerFailure(
          AppStrings.failedToAuthenticateWithApiServer.tr,
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          AppStrings.checkYourInternetConnectionPlease.tr,
        );
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure(
            AppStrings.checkYourInternetConnectionPlease.tr,
          );
        }
        return ServerFailure(
          AppStrings.thereWasAnUnknownErrorWithTheServer.tr,
        );
      default:
        return ServerFailure(
          AppStrings.thereWasAnUnknownErrorWithTheServer.tr,
        );
    }
  }

  factory ServerFailure.fromResponse({int statusCode = 0, dynamic response}) {
    if (statusCode == 401 || statusCode == 402) {
      return ServerFailure(
        AppStrings.oopsThereWasAnErrorPleaseTryAgainLater.tr,
      );
    }
    if (statusCode == 400 || statusCode == 403 || statusCode == 422) {
      if (response['message'].contains('Unauthenticated')) {
        sl<AppPreferences>().removeSessionId();
        AppSnackBars.showAlertSnackBar(
          message: AppStrings.yourSessionHasExpiredPleaseLoginAgain.tr,
        );
        Get.offAllNamed(AppRoutes.splashPath);
      }
      if (response['message'].contains('subtype')) {
        return ServerFailure(
          AppStrings.oopsThereWasAnErrorPleaseTryAgainLater.tr,
        );
      }

      return ServerFailure(response['message']);
    } else if (statusCode == 403) {
      return ServerFailure(
        AppStrings.yourRequestNotFoundPleaseTryAgainLater.tr,
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        AppStrings.internalServerErrorPleaseTryAgainLater.tr,
      );
    } else {
      return ServerFailure(
        AppStrings.oopsThereWasAnErrorPleaseTryAgainLater.tr,
      );
    }
  }
}
