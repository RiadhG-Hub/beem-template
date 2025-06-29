import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/features/auth/data/data_source/auth_cached_data_source.dart';
import 'package:momra/features/auth/data/data_source/auth_remote_data_source.dart'
    show AuthDataSource;
import 'package:momra/features/auth/data/models/AuthModel.dart';
import 'package:momra/features/auth/data/models/generate_captcha_model.dart';
import 'package:momra/features/auth/data/models/user_credentials.dart';
import 'package:momra/features/auth/data/models/verify_captcha_model.dart';
import 'package:momra/features/auth/data/models/verify_o_t_p_model.dart';
import 'package:momra/features/auth/domain/repositories/auth_repository.dart';

@injectable
@singleton
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource remoteDataSource;
  final AuthCachedDataSource cachedDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.cachedDataSource,
  });

  @override
  Future<Either<String, GenerateCaptchaModel>> generateCaptcha(
      {required String password,
      required String userName,
      required int failedAttempts,
      required bool rememberMe}) async {
    try {
      final result = await remoteDataSource.generateCaptcha(
        password: password,
        userName: userName,
        failedAttempts: failedAttempts,
      );

      //todo make it save only if status equal to 1
      if (result.Status == "1") {
        if (rememberMe) {
          await cachedDataSource.saveUserCredentials(
            userName: userName,
            password: password,
          );
        }
        return Right(result);
      } else {
        return Left(result.ErrorMessage);
      }
    } catch (e) {
      if (e is String) {
        return Left(e);
      }
      return Left(AuthDataSource.unknownIssue);
    }
  }

  @override
  Future<Either<String, VerifyCaptchaModel>> verifyCaptcha(
      {required String captcha}) async {
    try {
      final result = await remoteDataSource.verifyCaptcha(captcha: captcha);

      if (result.ErrorMessage == "") {
        await generateOtp();
        return Right(result);
      } else {
        return Left(result.ErrorMessage);
      }
    } catch (e) {
      if (e is String) {
        return Left(e);
      }
      return Left(AuthDataSource.unknownIssue);
    }
  }

  @override
  Future<Either<String, VerifyOTPModel>> verifyOtp(
      {required String otp, required int attempts}) async {
    try {
      final result =
          await remoteDataSource.verifyOtp(otp: otp, attempts: attempts);
      if (result.ErrorMessage == "") {
        return Right(result);
      } else {
        return Left(result.ErrorMessage);
      }
    } catch (e) {
      if (e is String) {
        return Left(e);
      }
      return Left(AuthDataSource.unknownIssue);
    }
  }

  @override
  Future<void> generateOtp() async {
    try {
      await remoteDataSource.generateOtp();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<Either<String, AuthModel>> authenticate({
    required String captcha,
    required String otp,
    required Map<String, dynamic> loginDetails,
  }) async {
    try {
      final result =
          await remoteDataSource.authenticate(captcha, otp, loginDetails);
      if (result.status == 1) {
        await cachedDataSource.saveAuthModel(result);
        await cachedDataSource.saveAuthModel(result);
        return Right(result);
      } else {
        return Left(result.errorMessage ?? AuthDataSource.unknownIssue);
      }
    } catch (e) {
      if (e is String) {
        return Left(e);
      }
      return Left(AuthDataSource.unknownIssue);
    }
  }

  @override
  Future<UserCredentials?> fetchSavedUserCredentials() async {
    final result = await cachedDataSource.fetchUserCredentials();
    return result;
  }
}
