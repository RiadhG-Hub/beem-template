import 'package:dartz/dartz.dart';
import 'package:momra/features/auth/data/models/generate_captcha_model.dart';
import 'package:momra/features/auth/data/models/user_credentials.dart';
import 'package:momra/features/auth/data/models/verify_captcha_model.dart';
import 'package:momra/features/auth/data/models/verify_o_t_p_model.dart';

abstract class AuthRepository {
  Future<Either<String, GenerateCaptchaModel>> generateCaptcha(
      {required String password,
      required String userName,
      required int failedAttempts,
      required bool rememberMe});

  Future<Either<String, VerifyCaptchaModel>> verifyCaptcha(
      {required String captcha});

  Future<Either<String, VerifyOTPModel>> verifyOtp(
      {required String otp, required int attempts});

  Future<void> generateOtp();

  Future<UserCredentials?> fetchSavedUserCredentials();
}
