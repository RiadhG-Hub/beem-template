import 'package:injectable/injectable.dart';
import 'package:momra/core/db_config/dio_interceptor.dart';

@injectable
@singleton
class AuthDataSource {
  final DioClient _dio;
  final TokenManager tokenManager;

  AuthDataSource(this._dio, this.tokenManager);
}
