import 'package:equatable/equatable.dart';

import '/core/localization/language_manger.dart';

class TokensViewModel extends Equatable {
  final List<TokensViewDataModel> data;

  const TokensViewModel({
    required this.data,
  });

  factory TokensViewModel.fromJson(dynamic json) {
    List<TokensViewDataModel> data = [];
    if (json is! String) {
      for (var element in json) {
        if (element['tokenId'] == 0) {
          return const TokensViewModel(data: []);
        }
        data.add(TokensViewDataModel.fromJson(element));
      }
    }

    return TokensViewModel(data: data);
  }

  @override
  List<Object> get props => [data];
}

class TokensViewDataModel extends Equatable {
  final int tokenId;
  final int tokenNumber;
  final String phoneNumber;
  final String slotDateTime;
  final String tokenDateTime;
  final Department department;
  final int isServed;
  final int selected;

  const TokensViewDataModel({
    required this.tokenId,
    required this.tokenNumber,
    required this.phoneNumber,
    required this.slotDateTime,
    required this.tokenDateTime,
    required this.department,
    required this.isServed,
    required this.selected,
  });

  factory TokensViewDataModel.fromJson(Map<String, dynamic> json) {
    return TokensViewDataModel(
      tokenId: json["tokenId"] as int,
      tokenNumber: json["tokenNumber"] as int,
      phoneNumber: json["phoneNumber"] as String,
      slotDateTime: json["slot_date_time"] ?? '',
      tokenDateTime: json["token_date_time"] ?? '',
      department: Department.fromJson(json["department"]),
      isServed: json["isServed"] as int,
      selected: json["selected"] as int,
    );
  }

  @override
  List<Object> get props => [
        tokenId,
        tokenNumber,
        phoneNumber,
        slotDateTime,
        tokenDateTime,
        department,
        isServed,
        selected,
      ];
}

class Department extends Equatable {
  final int deptId;
  final Organization organization;
  final String deptName;
  final String logoUrl;
  final int maxTokens;
  final int estimatedTimeToken;
  final int branchId;

  const Department({
    required this.deptId,
    required this.branchId,
    required this.organization,
    required this.deptName,
    required this.logoUrl,
    required this.maxTokens,
    required this.estimatedTimeToken,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        deptId: json["deptId"] as int,
        branchId: json["branch"]["brid"] as int,
        organization: Organization.fromJson(json["organization"]),
        deptName: getAppLanguageCode == 'ar'
            ? json["deptName"] as String
            : json["deptEnName"] as String,
        logoUrl: json["logo_url"] as String,
        maxTokens: json["maxTokens"] as int,
        estimatedTimeToken: json["estimatedTimeToken"] as int,
      );

  @override
  List<Object> get props => [
        deptId,
        organization,
        deptName,
        logoUrl,
        maxTokens,
        estimatedTimeToken,
      ];
}

class Organization extends Equatable {
  final int orgId;
  final String orgName;

  const Organization({
    required this.orgId,
    required this.orgName,
  });

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
        orgId: json["orgId"] as int,
        orgName: getAppLanguageCode == 'ar'
            ? json["orgArName"] as String
            : json["orgEnName"] as String,
      );

  @override
  List<Object> get props => [orgId, orgName];
}
