import 'package:beem/features/auth/data/data_source/auth_cached_data_source.dart';
import 'package:beem/features/auth/data/data_source/auth_remote_data_source.dart'
    show AuthDataSource;
import 'package:beem/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource remoteDataSource;
  final AuthCachedDataSource cachedDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.cachedDataSource,
  });
}
