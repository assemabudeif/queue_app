import 'package:dartz/dartz.dart';
import '/features/auth/model/models/login/black_listed_model.dart';
import '/features/auth/model/models/login/sending_otp_model.dart';
import '/features/auth/model/models/otp/verify_otp_model.dart';
import '/core/data/models/default_model.dart';
import '/core/data/requests/send_otp_request.dart';
import '/core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, BlackListedModel>> checkBlacklist({
    required String phone,
  });

  Future<Either<Failure, DefaultModel>> login();

  Future<Either<Failure, SendingOtpModel>> sendOtp(SendOtpRequest request);

  Future<Either<Failure, VerifyOtpModel>> verifyOtp({
    required String otp,
  });
}
