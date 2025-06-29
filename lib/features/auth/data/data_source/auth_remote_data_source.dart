import 'package:injectable/injectable.dart';
import 'package:momra/core/db_config/dio_interceptor.dart';

@injectable
@singleton
class AuthDataSource {
  final DioClient _dio;
  final TokenManager tokenManager;

  AuthDataSource(this._dio, this.tokenManager);
}

class AuthApiEndpoints {
  String get generateCaptcha => '/action/GenerateCaptcha';
  String get verifyCaptcha => '/action/VerifyCaptcha';
  static const String generateOtp = '/action/GenerateOtp';
  static const String verifyOtp = '/action/VerifyOTP';
  static const String checkAppVersion = '/action/CheckAppVersion';
  static const String authenticate = '/action/Authenticate';
}
