import 'package:equatable/equatable.dart';

class VerifyOtpModel extends Equatable {
  final int otpIsValid;
  final int sessionId;

  const VerifyOtpModel({
    required this.otpIsValid,
    required this.sessionId,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        otpIsValid: json["otp_is_valid"] ?? 0,
        sessionId: json["sessionID"] ?? 0,
      );

  @override
  List<Object> get props => [otpIsValid, sessionId];
}
