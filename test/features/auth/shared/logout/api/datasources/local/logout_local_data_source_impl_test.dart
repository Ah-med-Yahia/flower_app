// test/features/auth/shared/logout/data/datasources/local/logout_local_data_source_impl_test.dart
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/cache_modules/secure_storage_module.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/cache_constants.dart';
import 'package:flower_app/features/auth/shared/logout/api/datasources/local/logout_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_local_data_source_impl_test.mocks.dart';

@GenerateMocks([SecureStorageService])
void main() {
  late LogoutLocalDataSourceImpl dataSource;
  late MockSecureStorageService mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockSecureStorageService();
    dataSource = LogoutLocalDataSourceImpl(mockSecureStorage);
  });

  group('clearUserTokens', () {
    test(
      'should clear all user data and return success when all deletions succeed',
      () async {
        // Arrange - Mock the base delete method, not the extension
        when(
          mockSecureStorage.delete(StorageKeys.accessToken),
        ).thenAnswer((_) async => BaseResponse<bool>.success(true));
        when(
          mockSecureStorage.delete(StorageKeys.isLoggedIn),
        ).thenAnswer((_) async => BaseResponse<bool>.success(true));
        when(
          mockSecureStorage.delete(StorageKeys.userModel),
        ).thenAnswer((_) async => BaseResponse<bool>.success(true));

        // Act
        final result = await dataSource.clearUserTokens();

        // Assert
        expect(result, isA<BaseResponse<void>>());
        result.when(
          success: (_) {},
          failure: (_) => fail('Expected success but got failure'),
        );

        // Verify all methods were called
        verify(mockSecureStorage.delete(StorageKeys.accessToken)).called(1);
        verify(mockSecureStorage.delete(StorageKeys.isLoggedIn)).called(1);
        verify(mockSecureStorage.delete(StorageKeys.userModel)).called(1);
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );

    test('should return failure when delete accessToken fails', () async {
      // Arrange
      final errorHandler = ErrorHandler.handle(
        Exception('Token deletion failed'),
      );

      when(
        mockSecureStorage.delete(StorageKeys.accessToken),
      ).thenAnswer((_) async => BaseResponse<bool>.failure(errorHandler));
      when(
        mockSecureStorage.delete(StorageKeys.isLoggedIn),
      ).thenAnswer((_) async => BaseResponse<bool>.success(true));
      when(
        mockSecureStorage.delete(StorageKeys.userModel),
      ).thenAnswer((_) async => BaseResponse<bool>.success(true));

      // Act
      final result = await dataSource.clearUserTokens();

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isNotNull);
          expect(error.message, isNotNull);
        },
      );

      verify(mockSecureStorage.delete(StorageKeys.accessToken)).called(1);
      // Future.wait fails fast, so other deletes may or may not be called
    });

    test('should return failure when delete isLoggedIn fails', () async {
      // Arrange
      final errorHandler = ErrorHandler.handle(
        Exception('Delete isLoggedIn failed'),
      );

      when(
        mockSecureStorage.delete(StorageKeys.accessToken),
      ).thenAnswer((_) async => BaseResponse<bool>.success(true));
      when(
        mockSecureStorage.delete(StorageKeys.isLoggedIn),
      ).thenAnswer((_) async => BaseResponse<bool>.failure(errorHandler));
      when(
        mockSecureStorage.delete(StorageKeys.userModel),
      ).thenAnswer((_) async => BaseResponse<bool>.success(true));

      // Act
      final result = await dataSource.clearUserTokens();

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isNotNull);
        },
      );
    });

    test('should return failure when delete userModel fails', () async {
      // Arrange
      final errorHandler = ErrorHandler.handle(
        Exception('Delete userModel failed'),
      );

      when(
        mockSecureStorage.delete(StorageKeys.accessToken),
      ).thenAnswer((_) async => BaseResponse<bool>.success(true));
      when(
        mockSecureStorage.delete(StorageKeys.isLoggedIn),
      ).thenAnswer((_) async => BaseResponse<bool>.success(true));
      when(
        mockSecureStorage.delete(StorageKeys.userModel),
      ).thenAnswer((_) async => BaseResponse<bool>.failure(errorHandler));

      // Act
      final result = await dataSource.clearUserTokens();

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isNotNull);
        },
      );
    });
  });
}
