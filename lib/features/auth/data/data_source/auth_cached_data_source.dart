import 'package:encrypt_shared_preferences/provider.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
@singleton
class AuthCachedDataSource {
  final SharedPreferences sharedPreferences;
  final EncryptedSharedPreferences encryptedSharedPreferences;

  AuthCachedDataSource(this.sharedPreferences, this.encryptedSharedPreferences);
}
