import 'package:dartz/dartz.dart';
import '/core/data/requests/find_organizations_data_reguest.dart';
import '/core/error/failures.dart';
import '/features/home/model/models/branches_data_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, BranchesModel>> findOrganizationsData(
    FindOrganizationsDataRequest request,
  );

  Future<Either<Failure, BranchesModel>> searchOrganizations(String name);
}
