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
import 'features/receive_instructions/data/data_source/receive_instruction_remote_data_source.dart'
    as _i536;
import 'features/receive_instructions/data/repositories/receive_instruction_repository_impl.dart'
    as _i151;
import 'features/receive_instructions/presentation/bloc/receive_instruction_bloc.dart'
    as _i1051;
import 'features/send_instructions/data/data_source/send_instruction_remote_data_source.dart'
    as _i174;
import 'features/send_instructions/data/repositories/send_instruction_repository_impl.dart'
    as _i833;
import 'features/send_instructions/presentation/bloc/collect_instruction_cubit/collect_instruction_cubit_cubit.dart'
    as _i899;
import 'features/send_instructions/presentation/bloc/send_instruction_bloc/send_instruction_bloc.dart'
    as _i969;
import 'features/settings/data/data_source/base_url.dart' as _i673;
import 'features/settings/data/data_source/settings_cached_data_source.dart'
    as _i321;
import 'features/settings/data/repositories/settings_repos_impl.dart' as _i561;
import 'features/settings/presentation/controller/settings_cubit.dart' as _i285;
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
    gh.factory<_i321.SettingsCachedDataSource>(
        () => _i321.SettingsCachedDataSource());
    gh.factoryAsync<_i460.SharedPreferences>(() => registerModule.prefs);
    gh.factoryAsync<String>(() => registerModule.baseUrl);
    gh.factory<_i930.EncryptedSharedPreferences>(
        () => registerModule.encryptedSharedPref);
    gh.singleton<_i899.CollectInstructionCubit>(
        () => _i899.CollectInstructionCubit());
    gh.singleton<_i673.BaseUrl>(() => _i673.BaseUrl());
    gh.singleton<_i561.SettingsReposImplement>(() =>
        _i561.SettingsReposImplement(gh<_i321.SettingsCachedDataSource>()));
    gh.factory<_i285.SettingsCubit>(
        () => _i285.SettingsCubit(gh<_i561.SettingsReposImplement>()));
    gh.singletonAsync<_i580.TokenManager>(() async =>
        _i580.TokenManager(await getAsync<_i460.SharedPreferences>()));
    gh.factoryAsync<_i447.AuthCachedDataSource>(
        () async => _i447.AuthCachedDataSource(
              await getAsync<_i460.SharedPreferences>(),
              gh<_i930.EncryptedSharedPreferences>(),
            ));
    gh.factoryAsync<_i580.DioClient>(() async => _i580.DioClient(
          await getAsync<_i580.TokenManager>(),
          await getAsync<String>(),
        ));
    gh.factoryAsync<_i536.ReceiveInstructionDataSource>(() async =>
        _i536.ReceiveInstructionDataSource(await getAsync<_i580.DioClient>()));
    gh.factoryAsync<_i1016.AuthDataSource>(() async => _i1016.AuthDataSource(
          await getAsync<_i580.DioClient>(),
          await getAsync<_i580.TokenManager>(),
        ));
    gh.factoryAsync<_i174.SendInstructionDataSource>(() async =>
        _i174.SendInstructionDataSource(await getAsync<_i580.DioClient>()));
    gh.factoryAsync<_i151.ReceiveInstructionRepositoryImpl>(() async =>
        _i151.ReceiveInstructionRepositoryImpl(
            remoteDataSource:
                await getAsync<_i536.ReceiveInstructionDataSource>()));
    gh.factoryAsync<_i111.AuthRepositoryImpl>(
        () async => _i111.AuthRepositoryImpl(
              remoteDataSource: await getAsync<_i1016.AuthDataSource>(),
              cachedDataSource: await getAsync<_i447.AuthCachedDataSource>(),
            ));
    gh.factoryAsync<_i833.SendInstructionRepositoryImpl>(() async =>
        _i833.SendInstructionRepositoryImpl(
            remoteDataSource:
                await getAsync<_i174.SendInstructionDataSource>()));
    gh.singletonAsync<_i483.UserCredentialsCubit>(() async =>
        _i483.UserCredentialsCubit(await getAsync<_i111.AuthRepositoryImpl>()));
    gh.singletonAsync<_i1051.ReceiveInstructionBloc>(() async =>
        _i1051.ReceiveInstructionBloc(
            await getAsync<_i151.ReceiveInstructionRepositoryImpl>()));
    gh.singletonAsync<_i969.SendInstructionBloc>(() async =>
        _i969.SendInstructionBloc(
            await getAsync<_i833.SendInstructionRepositoryImpl>()));
    gh.singletonAsync<_i37.AuthenticationBloc>(
        () async => _i37.AuthenticationBloc(
              await getAsync<_i111.AuthRepositoryImpl>(),
              await getAsync<_i580.TokenManager>(),
            ));
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
