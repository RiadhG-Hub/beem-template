import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db_config.dart';

void configureDioForTesting(Dio dio) {
  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
}

@injectable
@singleton
class DioClient {
  final Dio _dio;
  final TokenManager tokenManager;

  DioClient(
    this.tokenManager,
  ) : _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl)) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _handleRequest,
        onResponse: _handleResponse,
        onError: _handleError,
      ),
    );
    configureDioForTesting(_dio);
  }

  Future<void> _handleRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenManager.getToken();
    final String uri = options.uri.toString();
    if (!uri.contains("CheckAppVersion")) {
      options.headers['Authorization'] = 'Basic $token';
    }
    // final isAuthRequest = options.uri.toString() == Constants.loginUrl ||
    //     options.uri.toString() == Constants.authenticateUrl;
//
    // print("\n🚀➡️ [REQUEST]");
    // print("🔹 Method: ${options.method}");
    // print("🔹 URL: ${options.uri}");
    // if (!isAuthRequest) {
    //   final token = await tokenManager.getToken();
    //   if (token != null && token.isNotEmpty) {
    //     options.headers['Token'] = token;
    //     print("🔹 Token attached: $token");
    //   } else {
    //     print("⚠️ No token found");
    //   }
    // } else {
    //   print("🔹 Authentication request, no token added");
    // }

    handler.next(options);
  }

  void _handleResponse(Response response, ResponseInterceptorHandler handler) {
    log("\n🎯✅ [RESPONSE]");
    log("🔹 Status Code: ${response.statusCode}");
    log("🔹 URL: ${response.realUri}");
    log("🔹 Response Data: ${response.data}\n");

    if (response.realUri.toString() == Constants.loginUrl ||
        response.realUri.toString() == Constants.authenticateUrl) {
      final data =
          response.data is String ? jsonDecode(response.data) : response.data;
      final token = data['data']?['token'] as String? ?? '';
      if (token.isNotEmpty) {
        tokenManager.saveToken(token);
        log("🔐 Token saved after auth: $token");
      }
    }

    handler.next(response);
  }

  void _handleError(DioException e, ErrorInterceptorHandler handler) {
    log("\n🚨❌ [ERROR]");
    log("🔹 URL: ${e.requestOptions.uri}");
    log("🔹 Status Code: ${e.response?.statusCode}");
    log("🔹 Message: ${e.message}");
    log("🔹 Error Data: ${e.response?.data}\n");

    handler.next(e);
  }

  Dio get client => _dio;
}

@singleton
@injectable
class TokenManager {
  final SharedPreferences sharedPreferences;

  TokenManager(this.sharedPreferences);

  Future<void> saveToken(String token) async {
    log("\n💾 [TokenManager] Saving token: $token");
    await sharedPreferences.setString('user_token', token);
  }

  Future<String?> getToken() async {
    final token = sharedPreferences.getString('user_token');
    log("\n🔑 [TokenManager] Retrieved token: $token");
    return token;
  }

  Future<void> clearToken() async {
    log("\n🗑️ [TokenManager] Clearing token");
    await sharedPreferences.remove('user_token');
  }

  Future<void> saveBasic(String basic) async {
    log("\n💾 [TokenManager] Saving basic: $basic");
    await sharedPreferences.setString('basic', basic);
  }

  Future<String?> getBasic() async {
    final basic = sharedPreferences.getString('basic');
    log("\n🔑 [TokenManager] Retrieved basic: $basic");
    return basic;
  }

  Future<void> clearBasic() async {
    log("\n🗑️ [TokenManager] Clearing basic");
    await sharedPreferences.remove('basic');
  }
}
