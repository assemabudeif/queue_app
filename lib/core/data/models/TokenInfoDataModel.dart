import 'package:equatable/equatable.dart';

class TokenInfoScreenDataModel extends Equatable {
  final int depId;
  final int branchId;
  final int tokenNumber;
  final String orgName;
  final String depName;

  const TokenInfoScreenDataModel({
    required this.depId,
    required this.branchId,
    required this.tokenNumber,
    required this.orgName,
    required this.depName,
  });

  @override
  List<Object> get props => [
        depId,
        tokenNumber,
        orgName,
        depName,
        branchId,
      ];
}
