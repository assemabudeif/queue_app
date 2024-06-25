import 'package:equatable/equatable.dart';
import '/core/utilities/enums.dart';

class SendOtpRequest extends Equatable {
  final String phone;
  final GenderEnum gender;
  final String deviceId;
  const SendOtpRequest({
    required this.phone,
    required this.gender,
    required this.deviceId,
  });

  @override
  List<Object> get props => [phone, gender, deviceId];
}
