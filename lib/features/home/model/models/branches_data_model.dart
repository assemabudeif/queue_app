import 'package:equatable/equatable.dart';
import '/core/localization/language_manger.dart';

class BranchesModel extends Equatable {
  final List<BranchesDataModel> data;

  const BranchesModel({
    required this.data,
  });

  factory BranchesModel.fromJson(dynamic json) {
    List<BranchesDataModel> data = [];
    if (json is! String) {
      for (var element in json) {
        data.add(BranchesDataModel.fromJson(element));
      }
    }
    return BranchesModel(data: data);
  }

  @override
  List<Object> get props => [data];
}

class BranchesDataModel extends Equatable {
  final int brid;
  final String brName;
  final String brAddress;
  final String logoUrl;
  final String brPhone;
  final double brLong;
  final double brLat;
  final int brStatus;
  final Organization organization;
  final Governorate governorate;
  final List<WorkingSchedule> workingSchedule;

  const BranchesDataModel({
    required this.brid,
    required this.brName,
    required this.brAddress,
    required this.logoUrl,
    required this.brPhone,
    required this.brLong,
    required this.brLat,
    required this.brStatus,
    required this.workingSchedule,
    required this.organization,
    required this.governorate,
  });

  factory BranchesDataModel.fromJson(Map<String, dynamic> json) =>
      BranchesDataModel(
        brid: json["brid"] ?? 0,
        brName: getAppLanguageCode == 'ar'
            ? json["brArName"] ?? ''
            : json["brEnName"] ?? '',
        brAddress: getAppLanguageCode == 'ar'
            ? json["brarAddress"] ?? ''
            : json["brenAddress"] ?? '',
        logoUrl: json["logo_url"] ?? '',
        brPhone: json["brPhone"] ?? '',
        brLong: json["brLong"]?.toDouble() ?? 0,
        brLat: json["brLat"]?.toDouble() ?? 0,
        brStatus: json["brStatus"] ?? 0,
        workingSchedule: List<WorkingSchedule>.from(
            json["workingSchedules"].map((x) => WorkingSchedule.fromJson(x))),
        organization: Organization.fromJson(json["organization"]),
        governorate: Governorate.fromJson(json["governorate"]),
      );

  @override
  List<Object> get props => [
        brid,
        brName,
        brAddress,
        logoUrl,
        brPhone,
        brLong,
        brLat,
        brStatus,
        workingSchedule,
        organization,
        governorate,
      ];
}

class Governorate extends Equatable {
  final int govId;
  final String name;
  final Country country;

  const Governorate({
    required this.govId,
    required this.country,
    required this.name,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) => Governorate(
        govId: json["govId"] ?? 0,
        name: getAppLanguageCode == 'ar'
            ? json["arName"] ?? ''
            : json["enName"] ?? '',
        country: Country.fromJson(json["country"]),
      );

  @override
  List<Object> get props => [govId, name, country];
}

class Country extends Equatable {
  final int countryId;
  final String countryName;
  final int countryStatus;

  const Country({
    required this.countryId,
    required this.countryName,
    required this.countryStatus,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryId: json["countryId"],
        countryName: getAppLanguageCode == 'ar'
            ? json["countryArName"] ?? ''
            : json["countryName"] ?? '',
        countryStatus: json["countryStatus"],
      );

  @override
  List<Object> get props => [countryId, countryName, countryStatus];
}

class Organization extends Equatable {
  final int orgId;
  final String orgName;
  final String addressName;
  final Country orgCountry;

  const Organization({
    required this.orgId,
    required this.orgName,
    required this.addressName,
    required this.orgCountry,
  });

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
        orgId: json["orgId"] ?? 0,
        orgName: getAppLanguageCode == 'ar'
            ? json["orgArName"] ?? ''
            : json["orgEnName"] ?? '',
        addressName: getAppLanguageCode == 'ar'
            ? json["arAddress"] ?? ''
            : json["enAddress"] ?? '',
        orgCountry: Country.fromJson(json["orgCountry"]),
      );

  @override
  List<Object> get props => [orgId, orgName, addressName, orgCountry];
}

class WorkingSchedule extends Equatable {
  final int id;
  final String workStartTime;
  final String workEndTime;
  final String workDays;

  const WorkingSchedule({
    required this.id,
    required this.workStartTime,
    required this.workEndTime,
    required this.workDays,
  });

  factory WorkingSchedule.fromJson(Map<String, dynamic> json) =>
      WorkingSchedule(
        id: json["id"] ?? 0,
        workStartTime: json["workStartTime"] ?? '',
        workEndTime: json["workEndTime"] ?? '',
        workDays: json["workDays"] ?? '',
      );

  @override
  List<Object> get props => [id, workStartTime, workEndTime, workDays];
}
