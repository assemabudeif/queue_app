import 'package:equatable/equatable.dart';
import '/core/localization/language_manger.dart';

class OrganizationDetailsModel extends Equatable {
  final List<OrganizationDetailsDataModel> data;

  const OrganizationDetailsModel({
    required this.data,
  });

  factory OrganizationDetailsModel.fromJson(dynamic json) {
    List<OrganizationDetailsDataModel> data = [];
    if (json is! String) {
      for (var element in json) {
        data.add(OrganizationDetailsDataModel.fromJson(element));
      }
    }
    return OrganizationDetailsModel(data: data);
  }

  @override
  List<Object> get props => [data];
}

class OrganizationDetailsDataModel extends Equatable {
  final int deptId;
  final int branchId;
  final String deptName;
  final String branchName;
  final String logoUrl;
  final Organization organization;

  const OrganizationDetailsDataModel({
    required this.deptId,
    required this.deptName,
    required this.logoUrl,
    required this.organization,
    required this.branchId,
    required this.branchName,
  });

  factory OrganizationDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      OrganizationDetailsDataModel(
        deptId: json["deptId"] as int,
        branchId: json["branch"]["brid"] as int,
        deptName: getAppLanguageCode == LanguageEnum.ar.name
            ? json["deptName"] as String
            : json["deptEnName"] as String,
        branchName: getAppLanguageCode == LanguageEnum.ar.name
            ? json["branch"]["brArName"] as String
            : json["branch"]["brEnName"] as String,
        logoUrl: json["logo_url"] as String,
        organization: Organization.fromJson(json["organization"]),
      );

  @override
  List<Object> get props => [deptId, deptName, logoUrl];
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
