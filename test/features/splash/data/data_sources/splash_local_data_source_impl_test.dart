import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/cache_modules/secure_storage_module.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/cache_constants.dart';
import 'package:flower_app/features/splash/data/data_sources/splash_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../auth/login/api/data_sources/local/local_login_data_source_impl_test.mocks.dart';

@GenerateMocks([SecureStorageService])
void main() {
  late SplashLocalDataSourceImpl splashLocalDataSourceImpl;
  late SecureStorageService secureStorageService;
  setUpAll(() {
    secureStorageService = MockSecureStorageService();
    splashLocalDataSourceImpl = SplashLocalDataSourceImpl(secureStorageService);
  });

  group('isLogged', () {
    group('Success case', () {
      test('should return true if user is logged in', () async {
        when(
          secureStorageService.readBool(StorageKeys.isLoggedIn),
        ).thenAnswer((_) async => const BaseResponse<bool?>.success(true));
        final response = await splashLocalDataSourceImpl.isLogged();
        expect(response, isA<Success<bool>>());
        final responseValue = response as Success<bool?>;
        expect(responseValue.data, true);
      });

      test('should return false if user is not logged in', () async {
        when(
          secureStorageService.readBool(StorageKeys.isLoggedIn),
        ).thenAnswer((_) async => const BaseResponse<bool?>.success(false));
        final response = await splashLocalDataSourceImpl.isLogged();
        expect(response, isA<Success<bool>>());
        final responseValue = response as Success<bool?>;
        expect(responseValue.data, false);
      });
    });

    test('should return false if response is null', () async {
      when(
        secureStorageService.readBool(StorageKeys.isLoggedIn),
      ).thenAnswer((_) async => const BaseResponse<bool?>.success(null));
      final response = await splashLocalDataSourceImpl.isLogged();
      expect(response, isA<Success<bool>>());
      final responseValue = response as Success<bool?>;
      expect(responseValue.data, false);
    });
  });

  group('Failure case', () {
    test('should return failure if user is not logged in', () async {
      when(secureStorageService.readBool(StorageKeys.isLoggedIn)).thenAnswer(
        (_) async => BaseResponse<bool?>.failure(ErrorHandler.handle('error')),
      );
      final response = await splashLocalDataSourceImpl.isLogged();
      expect(response, isA<Failure<bool>>());
    });
  });
}
