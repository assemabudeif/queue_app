import 'package:equatable/equatable.dart';

class SendingOtpModel extends Equatable {
  final int sent;

  const SendingOtpModel({
    required this.sent,
  });

  factory SendingOtpModel.fromJson(Map<String, dynamic> json) =>
      SendingOtpModel(
        sent: json["sent"] as int,
      );

  @override
  List<Object> get props => [sent];
}
