// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:encrypt_shared_preferences/provider.dart' as _i930;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'core/db_config/dio_interceptor.dart' as _i580;
import 'core/network/network_info.dart' as _i75;
import 'features/auth/data/data_source/auth_cached_data_source.dart' as _i447;
import 'features/auth/data/data_source/auth_remote_data_source.dart' as _i1016;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/presentation/bloc/authentication_bloc.dart' as _i37;
import 'features/auth/presentation/cubit/user_credentials/user_credentials_cubit.dart'
    as _i483;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i75.NetworkInfoImpl>(() => _i75.NetworkInfoImpl());
    gh.factoryAsync<_i460.SharedPreferences>(() => registerModule.prefs);
    gh.factory<String>(() => registerModule.baseUrl);
    gh.factory<_i930.EncryptedSharedPreferences>(
        () => registerModule.encryptedSharedPref);
    gh.singletonAsync<_i580.TokenManager>(() async =>
        _i580.TokenManager(await getAsync<_i460.SharedPreferences>()));
    gh.factoryAsync<_i447.AuthCachedDataSource>(
        () async => _i447.AuthCachedDataSource(
              await getAsync<_i460.SharedPreferences>(),
              gh<_i930.EncryptedSharedPreferences>(),
            ));
    gh.factoryAsync<_i580.DioClient>(() async => _i580.DioClient(
          await getAsync<_i580.TokenManager>(),
          gh<String>(),
        ));
    gh.factoryAsync<_i1016.AuthDataSource>(() async => _i1016.AuthDataSource(
          await getAsync<_i580.DioClient>(),
          await getAsync<_i580.TokenManager>(),
        ));
    gh.factoryAsync<_i111.AuthRepositoryImpl>(
        () async => _i111.AuthRepositoryImpl(
              remoteDataSource: await getAsync<_i1016.AuthDataSource>(),
              cachedDataSource: await getAsync<_i447.AuthCachedDataSource>(),
            ));
    gh.singletonAsync<_i483.UserCredentialsCubit>(() async =>
        _i483.UserCredentialsCubit(await getAsync<_i111.AuthRepositoryImpl>()));
    gh.singletonAsync<_i37.AuthenticationBloc>(
        () async => _i37.AuthenticationBloc(
              await getAsync<_i111.AuthRepositoryImpl>(),
              await getAsync<_i580.TokenManager>(),
            ));
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
