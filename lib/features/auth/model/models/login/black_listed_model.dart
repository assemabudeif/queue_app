import 'package:equatable/equatable.dart';

class BlackListedModel extends Equatable {
  final int blacklisted;

  const BlackListedModel({
    required this.blacklisted,
  });

  factory BlackListedModel.fromJson(Map<String, dynamic> json) =>
      BlackListedModel(
        blacklisted: json["Blacklisted"] as int,
      );

  @override
  List<Object?> get props => [blacklisted];
}
