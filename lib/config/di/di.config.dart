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

import '../../core/services/session_manager.dart' as _i570;
import '../../core/services/token_service.dart' as _i115;
import '../../features/auth/change_password/api/api_client/change_password_api_client.dart'
    as _i971;
import '../../features/auth/change_password/api/data_sources/change_password_data_source_impl.dart'
    as _i300;
import '../../features/auth/change_password/data/datasources/change_password_data_source.dart'
    as _i390;
import '../../features/auth/change_password/data/repositories/change_password_repo_impl.dart'
    as _i960;
import '../../features/auth/change_password/domain/repositories/change_password_repo.dart'
    as _i784;
import '../../features/auth/change_password/domain/usecases/change_password_use_case.dart'
    as _i780;
import '../../features/auth/change_password/presentation/cubit/change_password_cubit.dart'
    as _i81;
import '../../features/auth/forget_password/api/api_client/forget_password_api_client.dart'
    as _i478;
import '../../features/auth/forget_password/api/datasources/remote/forget_password_remote_data_source_impl.dart'
    as _i517;
import '../../features/auth/forget_password/data/datasources/remote/forget_password_remote_data_source.dart'
    as _i142;
import '../../features/auth/forget_password/data/repos/forget_password_repo_impl.dart'
    as _i769;
import '../../features/auth/forget_password/domain/repositories/forget_password_repo.dart'
    as _i924;
import '../../features/auth/forget_password/domain/usecases/forget_password_use_case.dart'
    as _i737;
import '../../features/auth/forget_password/domain/usecases/otp_verification_use_case.dart'
    as _i1056;
import '../../features/auth/forget_password/domain/usecases/reset_password_use_case.dart'
    as _i374;
import '../../features/auth/forget_password/presentation/view_models/forget_password/forget_password_cubit.dart'
    as _i105;
import '../../features/auth/forget_password/presentation/view_models/reset_password/reset_password_cubit.dart'
    as _i531;
import '../../features/auth/forget_password/presentation/view_models/verify_otp/verify_otp_code_cubit.dart'
    as _i634;
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
import '../../features/auth/shared/logout/api/datasources/local/logout_local_data_source_impl.dart'
    as _i521;
import '../../features/auth/shared/logout/data/datasoources/local/logout_local_data_source.dart'
    as _i52;
import '../../features/auth/shared/logout/data/repo/logout_repo_impl.dart'
    as _i387;
import '../../features/auth/shared/logout/domain/repo/logout_repo.dart'
    as _i498;
import '../../features/auth/shared/logout/domain/usecases/logout_usecase.dart'
    as _i205;
import '../../features/auth/shared/logout/presentation/view_model/logout_cubit.dart'
    as _i670;
import '../../features/categories/api/api_service/categories_api_client.dart'
    as _i199;
import '../../features/categories/api/datasources_impl/remote_categories_data_source_impl.dart'
    as _i425;
import '../../features/categories/data/datasources/remote_categories_data_source.dart'
    as _i81;
import '../../features/categories/data/repos/categories_repo_impl.dart'
    as _i337;
import '../../features/categories/domain/repos/categories_repo_contract.dart'
    as _i761;
import '../../features/categories/domain/usecases/get_all_categories_usecase.dart'
    as _i943;
import '../../features/categories/domain/usecases/get_categories_products_usecase.dart'
    as _i290;
import '../../features/home/api/api_clinet/home_screen_api_client.dart'
    as _i279;
import '../../features/home/api/data_sources/remote/home_screen_data_source_impl.dart'
    as _i213;
import '../../features/home/data/data_sources/remote/home_screen_data_source.dart'
    as _i525;
import '../../features/home/data/repo/home_screen_repo_impl.dart' as _i209;
import '../../features/home/domain/repo/home_screen_repo.dart' as _i202;
import '../../features/home/domain/usecases/get_home_data_usecase.dart'
    as _i1033;
import '../../features/home/presentation/view_model/home_screen_cubit.dart'
    as _i193;
import '../../features/occasion/api/api_client/occasion_api_client.dart'
    as _i425;
import '../../features/occasion/api/datasources_impl/remote_occasion_data_source_impl.dart'
    as _i181;
import '../../features/occasion/data/datasources/remote_occasion_data_source.dart'
    as _i948;
import '../../features/occasion/data/repos/occasion_repo_impl.dart' as _i315;
import '../../features/occasion/domain/repos/occasion_repo_contract.dart'
    as _i31;
import '../../features/occasion/domain/usecases/get_all_occasion_usecase.dart'
    as _i401;
import '../../features/occasion/domain/usecases/get_occasion_products_usecase.dart'
    as _i203;
import '../../features/occasion/presentation/view_model/occasion_cubit.dart'
    as _i141;
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
import '../../features/profile/profile_main/api/api_client/profile_main_api_client.dart'
    as _i120;
import '../../features/profile/profile_main/api/datasource/remote/profile_main_remote_data_source_impl.dart'
    as _i550;
import '../../features/profile/profile_main/data/datasource/profile_main_remote_data_source.dart'
    as _i718;
import '../../features/profile/profile_main/data/repos/profile_main_repo_impl.dart'
    as _i753;
import '../../features/profile/profile_main/domain/repos/profile_main_repo.dart'
    as _i652;
import '../../features/profile/profile_main/domain/use_cases/get_user_data_use_case.dart'
    as _i658;
import '../cache_modules/secure_storage_module.dart' as _i11;
import '../cache_modules/shared_preferences_module.dart' as _i1059;
import '../dio_module/auth_interceptor.dart' as _i815;
import '../dio_module/dio_module.dart' as _i773;
import '../dio_module/logger_interceptor.dart' as _i754;

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
    gh.singleton<_i754.LoggerInterceptor>(() => _i754.LoggerInterceptor());
    gh.singleton<_i570.SessionManager>(
      () => _i570.SessionManager(),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i11.SecureStorageService>(
      () => _i11.SecureStorageService(),
    );
    gh.factory<_i115.TokenService>(
      () => _i115.TokenService(gh<_i11.SecureStorageService>()),
    );
    gh.factory<_i815.AuthInterceptor>(
      () => _i815.AuthInterceptor(
        gh<_i11.SecureStorageService>(),
        gh<_i570.SessionManager>(),
      ),
    );
    gh.lazySingleton<_i1059.CacheHelper>(
      () => _i1059.CacheHelper(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i326.LocalLoginDataSource>(
      () => _i654.LoginLocalDataSourceImpl(
        secureStorageService: gh<_i11.SecureStorageService>(),
      ),
    );
    gh.singleton<_i361.Dio>(
      () => dioModule.dio(
        gh<_i815.AuthInterceptor>(),
        gh<_i754.LoggerInterceptor>(),
      ),
    );
    gh.factory<_i52.LogoutLocalDataSource>(
      () => _i521.LogoutLocalDataSourceImpl(gh<_i11.SecureStorageService>()),
    );
    gh.lazySingleton<_i199.CategoriesApiClient>(
      () => _i199.CategoriesApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i425.OccasionApiClient>(
      () => _i425.OccasionApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i971.ChangePasswordApiClient>(
      () => _i971.ChangePasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i478.ForgetPasswordApiClient>(
      () => _i478.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i32.LoginApiClient>(() => _i32.LoginApiClient(gh<_i361.Dio>()));
    gh.factory<_i517.RegisterApiClient>(
      () => _i517.RegisterApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i279.HomeScreenApiClient>(
      () => _i279.HomeScreenApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i113.BestSellerApiClient>(
      () => _i113.BestSellerApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i373.ProductDetailsApiClient>(
      () => _i373.ProductDetailsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i120.ProfileMainApiClient>(
      () => _i120.ProfileMainApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i948.RemoteOccasionDataSource>(
      () => _i181.RemoteOccasionDataSourceImpl(gh<_i425.OccasionApiClient>()),
    );
    gh.factory<_i842.RemoteLoginDataSource>(
      () => _i793.RemoteLoginDataSourceImpl(gh<_i32.LoginApiClient>()),
    );
    gh.factory<_i142.ForgetPasswordRemoteDataSource>(
      () => _i517.ForgetPasswordRemoteDataSourceImpl(
        gh<_i478.ForgetPasswordApiClient>(),
      ),
    );
    gh.factory<_i390.ChangePasswordDataSource>(
      () => _i300.ChangePasswordDataSourceImpl(
        gh<_i971.ChangePasswordApiClient>(),
      ),
    );
    gh.factory<_i718.ProfileMainRemoteDataSource>(
      () => _i550.ProfileMainRemoteDataSourceImpl(
        gh<_i120.ProfileMainApiClient>(),
      ),
    );
    gh.factory<_i1058.BestSellerRemoteDataSource>(
      () =>
          _i920.BestSellerRemoteDataSourceImpl(gh<_i113.BestSellerApiClient>()),
    );
    gh.factory<_i784.ChangePasswordRepo>(
      () => _i960.ChangePasswordRepoImpl(
        gh<_i390.ChangePasswordDataSource>(),
        gh<_i11.SecureStorageService>(),
      ),
    );
    gh.factory<_i498.LogoutRepo>(
      () => _i387.LogoutRepoImpl(gh<_i52.LogoutLocalDataSource>()),
    );
    gh.factory<_i81.RemoteCategoriesDataSource>(
      () =>
          _i425.RemoteCategoriesDataSourceImpl(gh<_i199.CategoriesApiClient>()),
    );
    gh.factory<_i525.HomeScreenDataSource>(
      () => _i213.HomeScreenDataSourceImpl(gh<_i279.HomeScreenApiClient>()),
    );
    gh.factory<_i205.LogoutUsecase>(
      () => _i205.LogoutUsecase(gh<_i498.LogoutRepo>()),
    );
    gh.factory<_i31.OccasionRepoContract>(
      () => _i315.OccasionRepoImpl(gh<_i948.RemoteOccasionDataSource>()),
    );
    gh.factory<_i780.ChangePasswordUseCase>(
      () => _i780.ChangePasswordUseCase(gh<_i784.ChangePasswordRepo>()),
    );
    gh.factory<_i670.LogoutCubit>(
      () => _i670.LogoutCubit(gh<_i205.LogoutUsecase>()),
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
    gh.factory<_i81.ChangePasswordCubit>(
      () => _i81.ChangePasswordCubit(gh<_i780.ChangePasswordUseCase>()),
    );
    gh.factory<_i924.ForgetPasswordRepo>(
      () => _i769.ForgetPasswordRepoImpl(
        gh<_i142.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i856.ProductDetailsDataSourceContract>(
      () => _i749.ProductDetailsDataSourceImpl(
        gh<_i373.ProductDetailsApiClient>(),
      ),
    );
    gh.factory<_i652.ProfileMainRepo>(
      () => _i753.ProfileMainRepoImpl(gh<_i718.ProfileMainRemoteDataSource>()),
    );
    gh.factory<_i202.HomeScreenRepo>(
      () => _i209.HomeScreenRepoImpl(gh<_i525.HomeScreenDataSource>()),
    );
    gh.factory<_i892.BestSellerRepo>(
      () => _i20.BestSellerRepoImpl(gh<_i1058.BestSellerRemoteDataSource>()),
    );
    gh.factory<_i761.CategoriesRepoContract>(
      () => _i337.CategoriesRepoImpl(gh<_i81.RemoteCategoriesDataSource>()),
    );
    gh.factory<_i57.RegisterRepository>(
      () => _i200.RegisterRepositoryImpl(gh<_i613.RegisterDataSource>()),
    );
    gh.factory<_i658.GetUserDataUseCase>(
      () => _i658.GetUserDataUseCase(gh<_i652.ProfileMainRepo>()),
    );
    gh.factory<_i545.RegisterUseCase>(
      () => _i545.RegisterUseCase(gh<_i57.RegisterRepository>()),
    );
    gh.factory<_i943.GetAllCategoriesUsecase>(
      () => _i943.GetAllCategoriesUsecase(gh<_i761.CategoriesRepoContract>()),
    );
    gh.factory<_i290.GetCategoryProductsUsecase>(
      () =>
          _i290.GetCategoryProductsUsecase(gh<_i761.CategoriesRepoContract>()),
    );
    gh.factory<_i401.GetAllOccasionUsecase>(
      () => _i401.GetAllOccasionUsecase(gh<_i31.OccasionRepoContract>()),
    );
    gh.factory<_i203.GetOccasionProductsUsecase>(
      () => _i203.GetOccasionProductsUsecase(gh<_i31.OccasionRepoContract>()),
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
    gh.factory<_i960.CategoriesCubit>(
      () => _i960.CategoriesCubit(
        gh<_i943.GetAllCategoriesUsecase>(),
        gh<_i290.GetCategoryProductsUsecase>(),
      ),
    );
    gh.factory<_i737.ForgetPasswordUseCase>(
      () => _i737.ForgetPasswordUseCase(gh<_i924.ForgetPasswordRepo>()),
    );
    gh.factory<_i1056.OtpVerificationUseCase>(
      () => _i1056.OtpVerificationUseCase(gh<_i924.ForgetPasswordRepo>()),
    );
    gh.factory<_i374.ResetPasswordUseCase>(
      () => _i374.ResetPasswordUseCase(gh<_i924.ForgetPasswordRepo>()),
    );
    gh.factory<_i805.RegisterCubit>(
      () => _i805.RegisterCubit(gh<_i545.RegisterUseCase>()),
    );
    gh.factory<_i105.ForgetPasswordCubit>(
      () => _i105.ForgetPasswordCubit(gh<_i737.ForgetPasswordUseCase>()),
    );
    gh.factory<_i1033.GetHomeDataUsecase>(
      () => _i1033.GetHomeDataUsecase(gh<_i202.HomeScreenRepo>()),
    );
    gh.factory<_i888.GetProductDetailsUsecase>(
      () => _i888.GetProductDetailsUsecase(
        gh<_i338.ProductDetailsRepoContract>(),
      ),
    );
    gh.factory<_i126.LoginCubit>(
      () => _i126.LoginCubit(gh<_i316.LoginUseCase>()),
    );
    gh.factory<_i141.OccasionCubit>(
      () => _i141.OccasionCubit(
        gh<_i401.GetAllOccasionUsecase>(),
        gh<_i203.GetOccasionProductsUsecase>(),
      ),
    );
    gh.factory<_i531.ResetPasswordCubit>(
      () => _i531.ResetPasswordCubit(gh<_i374.ResetPasswordUseCase>()),
    );
    gh.factory<_i988.BestSellerCubit>(
      () => _i988.BestSellerCubit(gh<_i198.GetBestSellerUseCase>()),
    );
    gh.factory<_i634.VerifyOtpCodeCubit>(
      () => _i634.VerifyOtpCodeCubit(
        gh<_i1056.OtpVerificationUseCase>(),
        gh<_i105.ForgetPasswordCubit>(),
      ),
    );
    gh.factory<_i193.HomeScreenCubit>(
      () => _i193.HomeScreenCubit(gh<_i1033.GetHomeDataUsecase>()),
    );
    gh.factory<_i986.ProductDetailsCubit>(
      () => _i986.ProductDetailsCubit(gh<_i888.GetProductDetailsUsecase>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i1059.SharedPreferencesModule {}

class _$DioModule extends _i773.DioModule {}
