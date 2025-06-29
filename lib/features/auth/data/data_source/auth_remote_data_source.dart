import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/core/db_config/api_response.dart';
import 'package:momra/core/db_config/dio_interceptor.dart';
import 'package:momra/core/util/helper_functions.dart';
import 'package:momra/features/auth/data/models/AuthModel.dart';
import 'package:momra/features/auth/data/models/check_app_version_model.dart';
import 'package:momra/features/auth/data/models/generate_captcha_model.dart';
import 'package:momra/features/auth/data/models/verify_captcha_model.dart';
import 'package:momra/features/auth/data/models/verify_o_t_p_model.dart';

@injectable
@singleton
class AuthDataSource {
  final DioClient _dio;
  final TokenManager tokenManager;
  static const String unknownIssue = "مشكلة غير معروفة";
  static const String checkEnteredInfo = "يرجى التحقق من المعلومات المدخلة";

  AuthDataSource(this._dio, this.tokenManager);

  Future<GenerateCaptchaModel> generateCaptcha(
      {required String password,
      required String userName,
      required int failedAttempts}) async {
    try {
      await tokenManager.saveBasic(
        basicAuth(
          userName: userName,
          password: password,
        ),
      );
      final response = await _dio.client.get(
        AuthApiEndpoints().generateCaptcha,
        options: Options(headers: {
          //'Authorization': basicAuth(userName: userName, password: password),
          'cnt': '$failedAttempts',
        }),
      );

      final result = GenerateCaptchaModel.fromJson(response.data);
      if (result.ErrorMessage.isEmpty) {
        return result;
      } else {
        throw result.ErrorMessage;
      }
    } catch (e) {
      if (e is String) {
        rethrow;
      } else {
        throw unknownIssue;
      }
    }
  }

  Future<VerifyCaptchaModel> verifyCaptcha({required String captcha}) async {
    try {
      final response = await _dio.client.post(
        AuthApiEndpoints().verifyCaptcha,
        options: Options(headers: {
          'Captcha': captcha,
        }),
        data: {},
      );
      final result = VerifyCaptchaModel.fromJson(response.data);
      if (result.ErrorMessage.isEmpty) {
        return result;
      } else {
        throw result.ErrorMessage;
      }
    } catch (e) {
      if (e is String) {
        rethrow;
      } else {
        throw unknownIssue;
      }
    }
  }

  Future<ApiResponse<dynamic>> generateOtp() async {
    try {
      final response = await _dio.client.post(
        AuthApiEndpoints.generateOtp,
      );
      return _handleResponse(response);
    } catch (e) {
      throw unknownIssue;
    }
  }

  Future<VerifyOTPModel> verifyOtp(
      {required String otp, required int attempts}) async {
    try {
      final response = await _dio.client.post(
        AuthApiEndpoints.verifyOtp,
        options: Options(headers: {
          'OTP': otp,
          'OTPCNT': attempts,
        }),
        data: {},
      );
      print("the response is : ${response.data}");
      final result = VerifyOTPModel.fromJson(response.data);
      if (result.ErrorMessage.isEmpty) {
        return result;
      } else {
        throw result.ErrorMessage;
      }
    } catch (e) {
      if (e is String) {
        rethrow;
      } else {
        throw checkEnteredInfo;
      }
    }
  }

  Future<CheckAppVersionModel> checkAppVersion() async {
    try {
      final response = await _dio.client.get(AuthApiEndpoints.checkAppVersion);
      final result = CheckAppVersionModel.fromJson(response.data);
      if (result.ErrorMessage.isEmpty) {
        return result;
      } else {
        throw result.ErrorMessage;
      }
    } catch (e) {
      if (e is String) {
        rethrow;
      } else {
        throw unknownIssue;
      }
    }
  }

  Future<AuthModel> authenticate(
    String captcha,
    String otp,
    Map<String, dynamic> loginDetails,
  ) async {
    try {
      final response = await _dio.client.post(
        AuthApiEndpoints.authenticate,
        options: Options(headers: {
          'Captcha': captcha,
          'OTP': otp,
        }),
        data: loginDetails,
      );
      final AuthModel result = AuthModel.fromJson(response.data);
      if (result.errorMessage == null || result.errorMessage!.isEmpty) {
        return result;
      } else {
        throw result.errorMessage ?? unknownIssue;
      }
    } catch (e) {
      if (e is String) {
        rethrow;
      } else {
        throw unknownIssue;
      }
    }
  }

  ApiResponse<dynamic> _handleResponse(Response response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return ApiResponse.fromJson(
        response.data is String ? jsonDecode(response.data) : response.data,
        (data) => data,
      );
    } else {
      return ApiResponse(
        success: false,
        error: 'Request failed with status: ${response.statusCode}',
      );
    }
  }
}

class AuthApiEndpoints {
  String get generateCaptcha => '/action/GenerateCaptcha';
  String get verifyCaptcha => '/action/VerifyCaptcha';
  static const String generateOtp = '/action/GenerateOtp';
  static const String verifyOtp = '/action/VerifyOTP';
  static const String checkAppVersion = '/action/CheckAppVersion';
  static const String authenticate = '/action/Authenticate';
}
