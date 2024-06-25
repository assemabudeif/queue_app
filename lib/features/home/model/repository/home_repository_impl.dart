import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/data/requests/find_organizations_data_reguest.dart';

import '/core/error/failures.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';
import '/features/home/model/models/branches_data_model.dart';

import 'home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<Either<Failure, BranchesModel>> findOrganizationsData(
    FindOrganizationsDataRequest request,
  ) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.findORGsPath(
            lat: request.latitude, long: request.longitude),
      );
      return Right(BranchesModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        log(ServerFailure.formDioException(e).message, name: 'Request Error');
        return Left(ServerFailure.formDioException(e));
      }
      log(e.toString(), name: 'Request Error');
      return Left(ServerFailure.fromResponse());
    }
  }

  @override
  Future<Either<Failure, BranchesModel>> searchOrganizations(
      String name) async {
    log(name, name: 'Search');
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.search(name),
      );
      return Right(BranchesModel.fromJson(response.data));
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
