import 'package:equatable/equatable.dart';

class DefaultModel extends Equatable {
  final int exist;

  const DefaultModel({
    required this.exist,
  });

  factory DefaultModel.fromJson(Map<String, dynamic> json) {
    return DefaultModel(
      exist: json['exist'],
    );
  }

  @override
  List<Object?> get props => [exist];
}
