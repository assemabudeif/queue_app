import 'dart:async';

import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/features/branches_details/model/models/generate_token_model.dart';
import '/features/branches_details/model/models/organization_details_model.dart';
import '/features/branches_details/model/models/remaining_tokens_without_token_model.dart';

abstract class OrganizationDetailsRepository {
  Future<Either<Failure, OrganizationDetailsModel>> getOrganizationDetails(
    String orgId,
  );

  Future<Either<Failure, RemainingTokensWithoutTokenModel>>
      getRemainingTokensWithoutToken(
    String depId,
  );

  Future<Either<Failure, GenerateTokenModel>> generateToken({
    required String depId,
    required String branchId,
  });
}
