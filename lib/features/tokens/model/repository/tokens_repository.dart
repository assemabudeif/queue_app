import 'dart:async';

import 'package:dartz/dartz.dart';
import '/core/data/requests/send_answers_request.dart';
import '/features/tokens/model/models/department_questions_model.dart';
import '/features/tokens/model/models/token_info_with_slot_model.dart';
import '/core/error/failures.dart';
import '/features/branches_details/model/models/remaining_tokens_without_token_model.dart';
import '/features/tokens/model/models/cancel_token_model.dart';
import '/features/tokens/model/models/token_information_model.dart';
import '/features/tokens/model/models/tokens_model.dart';
import '/features/tokens/model/models/transfer_token_model.dart';

abstract class TokensRepository {
  Future<Either<Failure, TokensViewModel>> getAllTokens();
  Future<Either<Failure, TokenInformationModel>> getTokenInformation({
    required String depId,
    required String tokenNumber,
  });

  Future<Either<Failure, TokenInfoWithSlotModel>> getTokenInfoWithSlot({
    required String depId,
    required String tokenNumber,
  });

  Future<Either<Failure, CancelTokenModel>> cancelToken({
    required String tokenNumber,
    required String depId,
  });

  Future<Either<Failure, RemainingTokensWithoutTokenModel>>
      getRemainingTokensWithoutTokenWithReservation(
    String depId,
  );

  Future<Either<Failure, TransferTokenModel>> transferToken({
    required String depId,
    required String phoneNumber,
    required String tokenNumber,
  });

  Future<Either<Failure, DepartmentQuestionsModel>> getDepartmentQuestions({
    required String depId,
  });

  Future<Either<Failure, int>> rateService({
    required int depId,
    required int slotId,
    required int tokenNumber,
    required int tokenId,
    required int rating,
  });

  Future<Either<Failure, int>> sendAnswers({
    required List<SendAnswersRequest> answers,
  });
}
