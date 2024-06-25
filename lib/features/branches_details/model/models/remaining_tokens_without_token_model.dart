import 'package:equatable/equatable.dart';

class RemainingTokensWithoutTokenModel extends Equatable {
  final int exist;
  final int remainingTime;
  final int bookingAvailable;
  final int remainingTokens;

  const RemainingTokensWithoutTokenModel({
    required this.exist,
    required this.remainingTime,
    required this.bookingAvailable,
    required this.remainingTokens,
  });

  factory RemainingTokensWithoutTokenModel.fromJson(
          Map<String, dynamic> json) =>
      RemainingTokensWithoutTokenModel(
        exist: json["exist"] as int,
        remainingTime: json["remaining_time"] as int,
        bookingAvailable: json["Booking_available"] as int,
        remainingTokens: json["remaining_tokens"] as int,
      );

  @override
  List<Object> get props => [
        exist,
        remainingTime,
        bookingAvailable,
        remainingTokens,
      ];
}
