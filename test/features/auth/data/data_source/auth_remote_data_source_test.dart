// Core testing imports
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momra/core/db_config/dio_interceptor.dart';
import 'package:momra/core/db_config/fake_shared_preferences_async.dart';
import 'package:momra/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:momra/injectables.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock class for SharedPreferences

void main() {
  // Initialize test environment
  setUpAll(() async {
    SharedPreferences.setMockInitialValues(
        {"basic": "Basic dXNlcjk5OTptaW5pc3Rlcg=="});
    await dotenv.load(fileName: ".env");
    configureDependencies();
  });

  // Test group for AuthenticationRepository
  group('AuthenticationRepository', () {
    // Dependencies
    late TokenManager tokenManager;
    late DioClient dioClient;
    late AuthDataSource authenticationRepository;
    late MockSharedPreferences mockSharedPreferences;

    // Setup before each test
    setUp(() async {
      mockSharedPreferences = MockSharedPreferences();
      tokenManager = TokenManager(mockSharedPreferences);
      dioClient = DioClient(tokenManager, "");
      authenticationRepository = AuthDataSource(dioClient, tokenManager);
    });

    // Test cases
    test(' generateCaptcha', () async {
      final result = await authenticationRepository.generateCaptcha(
          password: 'minister', failedAttempts: 1, userName: 'user999');
      expect(result.Status == '1', true);
    });

    test(' verifyCaptcha', () async {
      final result =
          await authenticationRepository.verifyCaptcha(captcha: "N4cSGc");
    });

    test(' verifyOtp', () async {
      final result = await authenticationRepository.verifyOtp(
          otp: 'One-Time Password', attempts: 3);
    });

    test(' checkAppVersion', () async {
      final result = await authenticationRepository.checkAppVersion();
    });
  });
}
