import 'dart:convert';
import 'dart:developer';

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/features/auth/data/models/AuthModel.dart';
import 'package:momra/features/auth/data/models/user_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
@singleton
class AuthCachedDataSource {
  final SharedPreferences sharedPreferences;
  final EncryptedSharedPreferences encryptedSharedPreferences;

  AuthCachedDataSource(this.sharedPreferences, this.encryptedSharedPreferences);
  static const key = 'auth_model';
  static const _userNameKey = "user_name";
  static const _password = "password";

  Future<void> saveAuthModel(AuthModel model) async {
    await sharedPreferences.setString(key, jsonEncode(model.toJson()));
  }

  Future<AuthModel?> getAuthModel() async {
    final jsonStr = sharedPreferences.getString(key);
    if (jsonStr == null) return null;
    return AuthModel.fromJson(jsonDecode(jsonStr));
  }

  Future<void> clearAuthModel() async {
    sharedPreferences.remove(key);
  }

  Future<void> saveUserCredentials(
      {required String userName, required String password}) async {
    try {
      await encryptedSharedPreferences.setString(_userNameKey, userName);
      await encryptedSharedPreferences.setString(_password, password);
    } catch (e) {
      log("something wrong in saving of user Credentials");
      return;
    }
  }

  Future<UserCredentials?> fetchUserCredentials() async {
    try {
      final userName = encryptedSharedPreferences.getString(
        _userNameKey,
      );
      final password = encryptedSharedPreferences.getString(
        _password,
      );
      if (userName == null || password == null) {
        return null;
      } else {
        return UserCredentials(userName: userName, password: password);
      }
    } catch (e) {
      log("something wrong in saving of user Credentials");
      return null;
    }
  }
}
