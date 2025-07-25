import 'package:encrypt_shared_preferences/provider.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  String get baseUrl => "baserlexample.com";
  EncryptedSharedPreferences get encryptedSharedPref =>
      EncryptedSharedPreferences.getInstance();
}
