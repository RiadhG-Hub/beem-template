import 'package:momra/features/auth/data/models/user_credentials.dart'
    show UserCredentials;

class UserCredentialsState {
  final UserCredentials? userCredentials;

  UserCredentialsState({required this.userCredentials});

  UserCredentialsState init() {
    return UserCredentialsState(userCredentials: null);
  }

  UserCredentialsState clone(UserCredentials? userCredentials) {
    return UserCredentialsState(userCredentials: userCredentials);
  }
}
