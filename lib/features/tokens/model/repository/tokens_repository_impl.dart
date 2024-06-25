import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/data/requests/send_answers_request.dart';
import '/features/tokens/model/models/department_questions_model.dart';
import '/features/tokens/model/models/token_info_with_slot_model.dart';

import '/core/error/failures.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';
import '/features/branches_details/model/models/remaining_tokens_without_token_model.dart';
import '/features/tokens/model/models/cancel_token_model.dart';
import '/features/tokens/model/models/token_information_model.dart';

import '/features/tokens/model/models/tokens_model.dart';
import '/features/tokens/model/models/transfer_token_model.dart';

import 'tokens_repository.dart';

class TokensRepositoryImpl implements TokensRepository {
  @override
  Future<Either<Failure, TokensViewModel>> getAllTokens() async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.viewTokens,
      );
      return Right(TokensViewModel.fromJson(response.data));
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
  Future<Either<Failure, TokenInformationModel>> getTokenInformation({
    required String depId,
    required String tokenNumber,
  }) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.getRemainingToken(
          depId: depId,
          tokenNumber: tokenNumber,
        ),
      );
      return Right(TokenInformationModel.fromJson(response.data));
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
  Future<Either<Failure, TokenInfoWithSlotModel>> getTokenInfoWithSlot({
    required String depId,
    required String tokenNumber,
  }) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.getTokenInfoWithSlot(
          depId: depId,
          tokenNumber: tokenNumber,
        ),
      );
      return Right(TokenInfoWithSlotModel.fromJson(response.data));
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
  Future<Either<Failure, CancelTokenModel>> cancelToken({
    required String tokenNumber,
    required String depId,
  }) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.cancelToken(
          depId: depId,
          tokenNumber: tokenNumber,
        ),
      );
      return Right(CancelTokenModel.fromJson(response.data));
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
      getRemainingTokensWithoutTokenWithReservation(String depId) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.getRemainingTokensWithoutTokenWithReservation(depId),
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
  Future<Either<Failure, TransferTokenModel>> transferToken({
    required String depId,
    required String phoneNumber,
    required String tokenNumber,
  }) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.transferToken(
          depId: depId,
          phoneNumber: phoneNumber,
          tokenNumber: tokenNumber,
        ),
      );
      return Right(TransferTokenModel.fromJson(response.data));
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
  Future<Either<Failure, DepartmentQuestionsModel>> getDepartmentQuestions({
    required String depId,
  }) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.getDepQuestions(
          depId: depId,
        ),
      );
      return Right(DepartmentQuestionsModel.fromJson(response.data));
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
  Future<Either<Failure, int>> rateService({
    required int depId,
    required int slotId,
    required int tokenNumber,
    required int tokenId,
    required int rating,
  }) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.rateToken(
          depId: depId,
          slotId: slotId,
          tokenNumber: tokenNumber,
          tokenId: tokenId,
          rate: rating,
        ),
      );
      return Right(response.data['submated'] ?? 0);
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
  Future<Either<Failure, int>> sendAnswers({
    required List<SendAnswersRequest> answers,
  }) async {
    try {
      final response = await DioLogger.getDio().post(
        ApiConstance.sendAnswer,
        data: [
          for (var answer in answers) answer.toJson(),
        ],
      );
      return Right(response.data['submated'] ?? 0);
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
