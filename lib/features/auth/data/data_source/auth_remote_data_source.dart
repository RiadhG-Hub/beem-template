import 'package:beem/core/db_config/dio_interceptor.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class AuthDataSource {
  final DioClient _dio;
  final TokenManager tokenManager;

  AuthDataSource(this._dio, this.tokenManager);
}
