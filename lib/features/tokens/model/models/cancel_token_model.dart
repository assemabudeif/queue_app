import 'package:equatable/equatable.dart';

class CancelTokenModel extends Equatable {
  final int exist;
  final int cancelled;

  const CancelTokenModel({
    required this.exist,
    required this.cancelled,
  });

  factory CancelTokenModel.fromJson(Map<String, dynamic> json) =>
      CancelTokenModel(
        exist: json["exist"] as int,
        cancelled: json["cancelled"] as int,
      );

  @override
  List<Object> get props => [exist, cancelled];
}
