import 'package:momra/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:momra/features/settings/data/data_source/base_url.dart';

class Constants {
  static String get loginUrl => '${BaseUrl.urlResult}/action/Login';
  static String get authenticateUrl =>
      '${BaseUrl.urlResult}/action/Authenticate';

  static AuthApiEndpoints get authApiEndpoints => AuthApiEndpoints();
}
