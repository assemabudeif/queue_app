part of 'tokens_cubit.dart';

@immutable
abstract class TokensState {}

class TokensInitial extends TokensState {}

class GetAllTokensLoading extends TokensState {}

class GetAllTokensSuccess extends TokensState {
  final TokensViewModel tokensViewModel;

  GetAllTokensSuccess(this.tokensViewModel);
}

class GetAllTokensFailure extends TokensState {
  final String message;

  GetAllTokensFailure(this.message);
}

class GetTokenInformationLoadingState extends TokensState {}

class GetTokenInformationSuccessState extends TokensState {}

class GetTokenInformationErrorState extends TokensState {}

class CancelTokenLoadingState extends TokensState {}

class CancelTokenSuccessState extends TokensState {}

class CancelTokenErrorState extends TokensState {}

class GenerateTokenLoading extends TokensState {}

class GenerateTokenSuccess extends TokensState {}

class GenerateTokenFailed extends TokensState {
  final String error;

  GenerateTokenFailed(this.error);
}

class GetRemainingTokensWithoutTokenLoading extends TokensState {}

class GetRemainingTokensWithoutTokenSuccess extends TokensState {}

class GetRemainingTokensWithoutTokenFailed extends TokensState {
  final String error;

  GetRemainingTokensWithoutTokenFailed(this.error);
}

class TransferTokenLoading extends TokensState {}

class TransferTokenSuccess extends TokensState {}

class TransferTokenFailed extends TokensState {}

class GetTokenInfoWithSlotLoading extends TokensState {}

class GetTokenInfoWithSlotSuccess extends TokensState {}

class GetTokenInfoWithSlotFailed extends TokensState {}
