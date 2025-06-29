import 'package:encrypt_shared_preferences/provider.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/features/settings/data/data_source/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  Future<String> get baseUrl => BaseUrl.url();
  EncryptedSharedPreferences get encryptedSharedPref =>
      EncryptedSharedPreferences.getInstance();
}
