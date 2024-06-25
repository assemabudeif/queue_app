import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '/core/error/failures.dart';
import '/core/localization/app_strings.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';

import 'settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  @override
  Future<Either<Failure, String>> logout() async {
    try {
      await DioLogger.getDio().get(
        ApiConstance.logout,
      );
      return Right(AppStrings.logoutSuccess.tr);
    } catch (e) {
      if (e is DioException) {
        log(ServerFailure.formDioException(e).message, name: 'Request Error');
        return Left(ServerFailure.formDioException(e));
      }
      log(e.toString(), name: 'Request Error');
      return Left(ServerFailure.fromResponse());
    }
  }
}
