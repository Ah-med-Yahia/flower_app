// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

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

import '../../features/product/best_seller/api/api_client/best_seller_api_client.dart'
    as _i113;
import '../../features/product/best_seller/api/datasource/remote/best_seller_remote_data_source_impl.dart'
    as _i920;
import '../../features/product/best_seller/data/datasource/remote/best_seller_remote_data_source.dart'
    as _i1058;
import '../../features/product/best_seller/data/repos/best_seller_repo_impl.dart'
    as _i20;
import '../../features/product/best_seller/domain/repos/best_seller_repo.dart'
    as _i892;
import '../../features/product/best_seller/domain/use_cases/get_best_seller_use_case.dart'
    as _i198;
import '../../features/product/best_seller/presentation/view_models/best_seller_cubit.dart'
    as _i988;
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
    gh.factory<_i113.BestSellerApiClient>(
      () => _i113.BestSellerApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i1058.BestSellerRemoteDataSource>(
      () =>
          _i920.BestSellerRemoteDataSourceImpl(gh<_i113.BestSellerApiClient>()),
    );
    gh.factory<_i892.BestSellerRepo>(
      () => _i20.BestSellerRepoImpl(gh<_i1058.BestSellerRemoteDataSource>()),
    );
    gh.factory<_i198.GetBestSellerUseCase>(
      () => _i198.GetBestSellerUseCase(gh<_i892.BestSellerRepo>()),
    );
    gh.factory<_i988.BestSellerCubit>(
      () => _i988.BestSellerCubit(gh<_i198.GetBestSellerUseCase>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i1059.SharedPreferencesModule {}

class _$DioModule extends _i773.DioModule {}
