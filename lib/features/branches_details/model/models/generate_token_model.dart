import 'package:equatable/equatable.dart';

class GenerateTokenModel extends Equatable {
  final int exist;
  final int bookingAvailable;
  final int tokenNumber;

  const GenerateTokenModel({
    required this.exist,
    required this.bookingAvailable,
    required this.tokenNumber,
  });

  factory GenerateTokenModel.fromJson(Map<String, dynamic> json) =>
      GenerateTokenModel(
        exist: json["exist"] as int,
        bookingAvailable: json["Booking_available"] as int,
        tokenNumber: json["token_number"] as int,
      );

  @override
  List<Object> get props => [exist, bookingAvailable, tokenNumber];
}
