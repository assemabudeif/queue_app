import 'package:dartz/dartz.dart';
import '/features/auth/model/models/login/black_listed_model.dart';
import '/features/auth/model/models/login/sending_otp_model.dart';
import '/features/auth/model/models/otp/verify_otp_model.dart';
import '/core/data/models/default_model.dart';

import '/core/data/requests/send_otp_request.dart';

import '/core/error/failures.dart';
import '/core/network/api_constance.dart';
import '/core/network/custom_request.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, BlackListedModel>> checkBlacklist({
    required String phone,
  }) {
    return CustomRequest<BlackListedModel>(
        path: ApiConstance.blackList(phone),
        fromJson: (json) {
          return BlackListedModel.fromJson(json);
        }).sendGetRequest();
  }

  @override
  Future<Either<Failure, DefaultModel>> login() {
    return CustomRequest<DefaultModel>(
        path: ApiConstance.login,
        fromJson: (json) {
          return DefaultModel.fromJson(json);
        }).sendGetRequest();
  }

  @override
  Future<Either<Failure, SendingOtpModel>> sendOtp(SendOtpRequest request) {
    return CustomRequest<SendingOtpModel>(
        path: ApiConstance.sedOtp(
          gender: request.gender,
          phoneNumber: request.phone,
          deviceId: request.deviceId,
        ),
        fromJson: (json) {
          return SendingOtpModel.fromJson(json);
        }).sendGetRequest();
  }

  @override
  Future<Either<Failure, VerifyOtpModel>> verifyOtp({required String otp}) {
    return CustomRequest<VerifyOtpModel>(
        path: ApiConstance.verifyOtp(otp),
        fromJson: (json) {
          return VerifyOtpModel.fromJson(json);
        }).sendGetRequest();
  }
}
