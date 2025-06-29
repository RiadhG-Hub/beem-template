import 'package:momra/features/auth/data/data_source/auth_remote_data_source.dart';

class Constants {
  static const baseUrl = "https://beemApi.com";
  static String get loginUrl => '$baseUrl/action/Login';
  static String get authenticateUrl => '$baseUrl/action/Authenticate';

  static AuthApiEndpoints get authApiEndpoints => AuthApiEndpoints();
}
