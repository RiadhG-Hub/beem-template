import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {
  static String token =
      '1dfc8a6305778e57aee82a4f78702f5ac6bd7f6c1b066abcb5299c891d7d1c3efe99c15e2593e86bff8e73f26da5d050';

  @override
  Future<bool> setString(String key, String value) async {
    return true;
  }

  @override
  String? getString(String key) {
    return key == 'auth_token' ? token : "";
  }
}
