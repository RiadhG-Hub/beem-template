import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/features/auth/data/models/user_credentials.dart';
import 'package:momra/features/auth/data/repositories/auth_repository_impl.dart';

import 'user_credentials_state.dart';

@singleton
@injectable
class UserCredentialsCubit extends Cubit<UserCredentialsState> {
  final AuthRepositoryImpl authRepository;
  UserCredentialsCubit(this.authRepository)
      : super(UserCredentialsState(userCredentials: null).init());

  Future<UserCredentials?> fetchSavedUserCredentials() async {
    final result = await authRepository.fetchSavedUserCredentials();
    emit(state.clone(result));
    print("riadh");
    print(result?.userName ?? "null");
    return result;
  }
}
