import 'package:equatable/equatable.dart';

class TokenInformationModel extends Equatable {
  final int exist;
  final int remainingTime;
  final int remainingTokens;

  const TokenInformationModel({
    required this.exist,
    required this.remainingTime,
    required this.remainingTokens,
  });

  factory TokenInformationModel.fromJson(Map<String, dynamic> json) =>
      TokenInformationModel(
        exist: json["exist"] as int,
        remainingTime: json["remaining_time"] as int,
        remainingTokens: json["remaining_tokens"] as int,
      );

  @override
  List<Object> get props => [exist, remainingTime, remainingTokens];
}
