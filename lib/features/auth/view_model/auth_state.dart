part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthChangeGenderValueInitialState extends AuthState {}

class AuthChangeGenderValueState extends AuthState {}

class AuthSendOtpLoadingState extends AuthState {}

class AuthSendOtpSuccessState extends AuthState {}

class AuthSendOtpErrorState extends AuthState {}

class AuthCheckBlacklistLoadingState extends AuthState {}

class AuthCheckBlacklistSuccessState extends AuthState {}

class AuthCheckBlacklistErrorState extends AuthState {}

class AuthVerifyOtpLoadingState extends AuthState {}

class AuthVerifyOtpSuccessState extends AuthState {}

class AuthVerifyOtpErrorState extends AuthState {}
