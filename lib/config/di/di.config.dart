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

import '../../features/product_details/api/api_clinet/product_details_api_client.dart'
    as _i373;
import '../../features/product_details/api/data_sources/remote/product_details_data_source_impl.dart'
    as _i749;
import '../../features/product_details/data/data_sources/remote/product_details_data_source_contract.dart'
    as _i856;
import '../../features/product_details/data/repo/product_details_repo_impl.dart'
    as _i402;
import '../../features/product_details/domain/repo/product_details_repo_contract.dart'
    as _i338;
import '../../features/product_details/domain/use_cases/get_product_details_usecase.dart'
    as _i888;
import '../../features/product_details/presentaion/view_model/product_details_cubit.dart'
    as _i986;
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
    gh.factory<_i373.ProductDetailsApiClient>(
      () => _i373.ProductDetailsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i856.ProductDetailsDataSourceContract>(
      () => _i749.ProductDetailsDataSourceImpl(
        gh<_i373.ProductDetailsApiClient>(),
      ),
    );
    gh.factory<_i338.ProductDetailsRepoContract>(
      () => _i402.ProductDetailsRepoImpl(
        gh<_i856.ProductDetailsDataSourceContract>(),
      ),
    );
    gh.factory<_i888.GetProductDetailsUsecase>(
      () => _i888.GetProductDetailsUsecase(
        gh<_i338.ProductDetailsRepoContract>(),
      ),
    );
    gh.factory<_i986.ProductDetailsCubit>(
      () => _i986.ProductDetailsCubit(gh<_i888.GetProductDetailsUsecase>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i1059.SharedPreferencesModule {}

class _$DioModule extends _i773.DioModule {}
