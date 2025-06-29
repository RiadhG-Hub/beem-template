part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class GenerateCaptchaEvent extends AuthenticationEvent {
  final String? userName;
  final String? password;
  final bool rememberMe;

  const GenerateCaptchaEvent(
      {required this.userName,
      required this.password,
      required this.rememberMe});

  @override
  List<Object?> get props => [userName, password];
}

class VerifyCaptchaEvent extends AuthenticationEvent {
  final String captcha;

  const VerifyCaptchaEvent({
    required this.captcha,
  });

  @override
  List<Object?> get props => [captcha];
}

class GenerateOtpEvent extends AuthenticationEvent {
  const GenerateOtpEvent();

  @override
  List<Object?> get props => [];
}

class VerifyOtpEvent extends AuthenticationEvent {
  final String otp;
  const VerifyOtpEvent(this.otp);

  @override
  List<Object?> get props => [];
}

class AuthenticateEvent extends AuthenticationEvent {
  const AuthenticateEvent();

  @override
  List<Object?> get props => [];
}
