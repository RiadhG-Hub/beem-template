import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
@singleton
class SettingsCachedDataSource {
  static const baseUrlKey = "base_url";

  SettingsCachedDataSource();

  Future<String> updateBaseUrl({required String baseUrl}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(baseUrlKey, baseUrl);
    return baseUrlKey;
  }

  Future<void> clearBaseUrl() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.remove(baseUrlKey);
  }

  Future<String?> fetchBaseUrl() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(baseUrlKey);
  }
}
