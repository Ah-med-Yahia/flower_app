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

import '../../features/auth/login/api/api_client/login_api_client.dart' as _i32;
import '../../features/auth/login/api/data_sources/local/local_login_data_source_impl.dart'
    as _i654;
import '../../features/auth/login/api/data_sources/remote/remote_login_data_source_impl.dart'
    as _i793;
import '../../features/auth/login/data/datasources/local/local_login_data_source.dart'
    as _i326;
import '../../features/auth/login/data/datasources/remote/remote_login_data_source.dart'
    as _i842;
import '../../features/auth/login/data/repositories/login_repository_impl.dart'
    as _i470;
import '../../features/auth/login/domain/repositories/login_repository.dart'
    as _i176;
import '../../features/auth/login/domain/usecases/login_use_case.dart' as _i316;
import '../../features/auth/login/presentation/cubit/login_cubit.dart' as _i126;
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
    gh.factory<_i32.LoginApiClient>(() => _i32.LoginApiClient(gh<_i361.Dio>()));
    gh.factory<_i517.RegisterApiClient>(
      () => _i517.RegisterApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i113.BestSellerApiClient>(
      () => _i113.BestSellerApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i373.ProductDetailsApiClient>(
      () => _i373.ProductDetailsApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i326.LocalLoginDataSource>(
      () => _i654.LoginLocalDataSourceImpl(
        secureStorageService: gh<_i11.SecureStorageService>(),
      ),
    );
    gh.factory<_i842.RemoteLoginDataSource>(
      () => _i793.RemoteLoginDataSourceImpl(gh<_i32.LoginApiClient>()),
    );
    gh.factory<_i1058.BestSellerRemoteDataSource>(
      () =>
          _i920.BestSellerRemoteDataSourceImpl(gh<_i113.BestSellerApiClient>()),
    );
    gh.factory<_i176.LoginRepository>(
      () => _i470.LoginRepositoryImpl(
        gh<_i842.RemoteLoginDataSource>(),
        gh<_i326.LocalLoginDataSource>(),
      ),
    );
    gh.factory<_i613.RegisterDataSource>(
      () => _i325.RegisterDataSourceImpl(
        registerApiClient: gh<_i517.RegisterApiClient>(),
      ),
    );
    gh.factory<_i856.ProductDetailsDataSourceContract>(
      () => _i749.ProductDetailsDataSourceImpl(
        gh<_i373.ProductDetailsApiClient>(),
      ),
    );
    gh.factory<_i892.BestSellerRepo>(
      () => _i20.BestSellerRepoImpl(gh<_i1058.BestSellerRemoteDataSource>()),
    );
    gh.factory<_i57.RegisterRepository>(
      () => _i200.RegisterRepositoryImpl(gh<_i613.RegisterDataSource>()),
    );
    gh.factory<_i545.RegisterUseCase>(
      () => _i545.RegisterUseCase(gh<_i57.RegisterRepository>()),
    );
    gh.factory<_i198.GetBestSellerUseCase>(
      () => _i198.GetBestSellerUseCase(gh<_i892.BestSellerRepo>()),
    );
    gh.factory<_i338.ProductDetailsRepoContract>(
      () => _i402.ProductDetailsRepoImpl(
        gh<_i856.ProductDetailsDataSourceContract>(),
      ),
    );
    gh.factory<_i316.LoginUseCase>(
      () => _i316.LoginUseCase(gh<_i176.LoginRepository>()),
    );
    gh.factory<_i805.RegisterCubit>(
      () => _i805.RegisterCubit(gh<_i545.RegisterUseCase>()),
    );
    gh.factory<_i888.GetProductDetailsUsecase>(
      () => _i888.GetProductDetailsUsecase(
        gh<_i338.ProductDetailsRepoContract>(),
      ),
    );
    gh.factory<_i126.LoginCubit>(
      () => _i126.LoginCubit(gh<_i316.LoginUseCase>()),
    );
    gh.factory<_i988.BestSellerCubit>(
      () => _i988.BestSellerCubit(gh<_i198.GetBestSellerUseCase>()),
    );
    gh.factory<_i986.ProductDetailsCubit>(
      () => _i986.ProductDetailsCubit(gh<_i888.GetProductDetailsUsecase>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i1059.SharedPreferencesModule {}

class _$DioModule extends _i773.DioModule {}
