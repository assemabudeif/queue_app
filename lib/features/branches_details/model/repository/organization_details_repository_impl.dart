import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/error/failures.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';
import '/features/branches_details/model/models/generate_token_model.dart';

import '/features/branches_details/model/models/organization_details_model.dart';
import '/features/branches_details/model/models/remaining_tokens_without_token_model.dart';

import 'organization_details_repository.dart';

class OrganizationDetailsRepositoryImpl extends OrganizationDetailsRepository {
  @override
  Future<Either<Failure, OrganizationDetailsModel>> getOrganizationDetails(
      String orgId) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.searchDepartment(orgId),
      );
      return Right(OrganizationDetailsModel.fromJson(response.data));
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
  Future<Either<Failure, RemainingTokensWithoutTokenModel>>
      getRemainingTokensWithoutToken(String depId) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.getRemainingTokensWithoutToken(depId),
      );
      return Right(RemainingTokensWithoutTokenModel.fromJson(response.data));
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
  Future<Either<Failure, GenerateTokenModel>> generateToken({
    required String depId,
    required String branchId,
  }) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.generateToken(
          depId: depId,
          branchId: branchId,
        ),
      );
      return Right(GenerateTokenModel.fromJson(response.data));
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
