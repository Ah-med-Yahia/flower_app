// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/register/api/api_client/register_api_client.dart'
    as _i517;
import '../../features/auth/register/api/datasource/register_data_source_impl.dart'
    as _i325;
import '../../features/auth/register/data/datasources/register_data_source.dart'
    as _i613;
import '../../features/auth/register/data/repositories/register_repository_impl.dart'
    as _i200;
import '../../features/auth/register/domain/repositories/register_repository.dart'
    as _i57;
import '../../features/auth/register/domain/usecases/register_use_case.dart'
    as _i545;
import '../../features/auth/register/presentation/cubit/register_cubit.dart'
    as _i805;
import '../cache_modules/secure_storage_module.dart' as _i11;
import '../cache_modules/shared_preferences_module.dart' as _i1059;
import '../dio_module/dio_module.dart' as _i773;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i11.SecureStorageService>(
      () => _i11.SecureStorageService(),
    );
    gh.lazySingleton<_i1059.CacheHelper>(
      () => _i1059.CacheHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i517.RegisterApiClient>(
      () => _i517.RegisterApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i613.RegisterDataSource>(
      () => _i325.RegisterDataSourceImpl(
        registerApiClient: gh<_i517.RegisterApiClient>(),
      ),
    );
    gh.factory<_i57.RegisterRepository>(
      () => _i200.RegisterRepositoryImpl(gh<_i613.RegisterDataSource>()),
    );
    gh.factory<_i545.RegisterUseCase>(
      () => _i545.RegisterUseCase(gh<_i57.RegisterRepository>()),
    );
    gh.factory<_i805.RegisterCubit>(
      () => _i805.RegisterCubit(gh<_i545.RegisterUseCase>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i1059.SharedPreferencesModule {}

class _$DioModule extends _i773.DioModule {}
