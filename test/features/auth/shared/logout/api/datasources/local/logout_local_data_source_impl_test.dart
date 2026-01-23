import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/cache_modules/secure_storage_module.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/cache_constants.dart';
import 'package:flower_app/features/auth/shared/logout/api/datasources/local/logout_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
        // Arrange
        when(
          mockSecureStorage.clearAuthTokens(),
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

        // Verify all methods were called
        verify(mockSecureStorage.clearAuthTokens()).called(1);
        verify(mockSecureStorage.delete(StorageKeys.isLoggedIn)).called(1);
        verify(mockSecureStorage.delete(StorageKeys.userModel)).called(1);
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );

    test('should return failure when clearAuthTokens fails', () async {
      // Arrange
      final errorHandler = ErrorHandler.handle(
        Exception('Token deletion failed'),
      );

      when(
        mockSecureStorage.clearAuthTokens(),
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
        },
      );

      verify(mockSecureStorage.clearAuthTokens()).called(1);
      verifyNever(mockSecureStorage.delete(StorageKeys.isLoggedIn));
      verifyNever(mockSecureStorage.delete(StorageKeys.userModel));
    });

    test('should return failure when delete isLoggedIn fails', () async {
      // Arrange
      final errorHandler = ErrorHandler.handle(
        Exception('Delete isLoggedIn failed'),
      );

      when(
        mockSecureStorage.clearAuthTokens(),
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
        mockSecureStorage.clearAuthTokens(),
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
