import 'package:equatable/equatable.dart';
import '/core/localization/language_manger.dart';

class TokenInfoWithSlotModel extends Equatable {
  final int tokenId;
  final int tokenNumber;
  final int isServed;
  final int selected;
  final int slotId;
  final int slotStatus;
  final int slotGender;
  final String slotName;

  const TokenInfoWithSlotModel({
    required this.tokenId,
    required this.tokenNumber,
    required this.isServed,
    required this.selected,
    required this.slotId,
    required this.slotStatus,
    required this.slotGender,
    required this.slotName,
  });

  factory TokenInfoWithSlotModel.fromJson(Map<String, dynamic> json) =>
      TokenInfoWithSlotModel(
        tokenId: json["tokenId"] ?? 0,
        tokenNumber: json["tokenNumber"] ?? 0,
        isServed: json["department"]["survey"] ?? 0,
        selected: json["selected"] ?? 0,
        slotId: json["slot"]["slotId"] ?? 0,
        slotName: getAppLanguageCode == 'ar'
            ? json["slot"]["slotArName"] ?? ''
            : json["slot"]["slotName"] ?? '',
        slotStatus: json["slot"]["slotStatus"] ?? 0,
        slotGender: json["slot"]["slotGender"] ?? 0,
      );

  @override
  List<Object> get props => [
        tokenId,
        tokenNumber,
        isServed,
        selected,
        slotId,
        slotStatus,
        slotGender,
        slotName,
      ];
}
