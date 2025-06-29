part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class GenerateCaptchaLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class GenerateCaptchaSuccess extends AuthenticationState {
  final GenerateCaptchaModel generateCaptchaModel;

  const GenerateCaptchaSuccess(this.generateCaptchaModel);

  @override
  List<Object> get props => [generateCaptchaModel];
}

class GenerateCaptchaFailed extends AuthenticationState {
  final String message;

  const GenerateCaptchaFailed(this.message);

  @override
  List<Object> get props => [message];
}

class VerifyCaptchaLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class VerifyCaptchaSuccess extends AuthenticationState {
  final VerifyCaptchaModel verifyCaptchaModel;

  const VerifyCaptchaSuccess(this.verifyCaptchaModel);

  @override
  List<Object> get props => [verifyCaptchaModel];
}

class VerifyCaptchaFailed extends AuthenticationState {
  final String message;

  const VerifyCaptchaFailed(this.message);

  @override
  List<Object> get props => [message];
}

class GenerateOtpLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class GenerateOtpSuccess extends AuthenticationState {
  final VerifyCaptchaModel verifyCaptchaModel;

  const GenerateOtpSuccess(this.verifyCaptchaModel);

  @override
  List<Object> get props => [verifyCaptchaModel];
}

class GenerateOtpFailed extends AuthenticationState {
  final String message;

  const GenerateOtpFailed(this.message);

  @override
  List<Object> get props => [message];
}

class VerifyOtpLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class VerifyOtpSuccess extends AuthenticationState {
  final VerifyOTPModel verifyOTPModel;

  const VerifyOtpSuccess(this.verifyOTPModel);

  @override
  List<Object> get props => [verifyOTPModel];
}

class VerifyOtpFailed extends AuthenticationState {
  final String message;

  const VerifyOtpFailed(this.message);

  @override
  List<Object> get props => [message];
}
