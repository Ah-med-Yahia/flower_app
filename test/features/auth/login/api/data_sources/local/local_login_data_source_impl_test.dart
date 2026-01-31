import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/cache_modules/secure_storage_module.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/cache_constants.dart';
import 'package:flower_app/features/auth/login/api/data_sources/local/local_login_data_source_impl.dart';
import 'package:flower_app/features/auth/login/data/models/login_response_model/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'local_login_data_source_impl_test.mocks.dart';

@GenerateMocks([SecureStorageService])
void main() {
  late LoginLocalDataSourceImpl dataSource;
  late MockSecureStorageService mockSecureStorageService;

  final testUser = UserModel(
    id: '1',
    firstName: 'Ahmed',
    lastName: 'Yahia',
    email: 'ahmed@example.com',
    addresses: [],
    wishlist: [],
    role: 'user',
    phone: '01091391955',
    gender: 'Male',
    photo: '',
    createdAt: DateTime.now(),
  );
  const testToken = 'token_123';

  setUpAll(() {
    mockSecureStorageService = MockSecureStorageService();
    dataSource = LoginLocalDataSourceImpl(
      secureStorageService: mockSecureStorageService,
    );
  });

  group('saveLoggedUserData', () {
    test('should return success when all storage operations succeed', () async {
      when(
        mockSecureStorageService.write(StorageKeys.accessToken, testToken),
      ).thenAnswer((_) async => const BaseResponse<bool>.success(true));

      when(
        mockSecureStorageService.writeBool(any, any),
      ).thenAnswer((_) async => const BaseResponse<bool>.success(true));

      when(
        mockSecureStorageService.writeJson(any, any),
      ).thenAnswer((_) async => const BaseResponse<bool>.success(true));

      final result = await dataSource.saveLoggedUserData(
        token: testToken,
        user: testUser,
      );

      expect(result, isA<Success<void>>());

      verify(
        mockSecureStorageService.write(StorageKeys.accessToken, testToken),
      ).called(1);
      verify(mockSecureStorageService.writeBool(any, any)).called(1);
      verify(mockSecureStorageService.writeJson(any, any)).called(1);
    });

    group('should return failure if any storage operation fails', () {
      test('should return failure if write fail', () async {
        when(
          mockSecureStorageService.write(StorageKeys.accessToken, testToken),
        ).thenAnswer(
          (_) async => BaseResponse<bool>.failure(ErrorHandler.handle('')),
        );
        when(
          mockSecureStorageService.writeBool(any, any),
        ).thenAnswer((_) async => const BaseResponse<bool>.success(true));
        when(
          mockSecureStorageService.writeJson(any, any),
        ).thenAnswer((_) async => const BaseResponse<bool>.success(true));

        final result = await dataSource.saveLoggedUserData(
          token: testToken,
          user: testUser,
        );

        expect(result, isA<Failure<void>>());
      });

      test('should return failure if writeBool fails', () async {
        when(
          mockSecureStorageService.write(StorageKeys.accessToken, testToken),
        ).thenAnswer((_) async => const BaseResponse<bool>.success(true));

        when(mockSecureStorageService.writeBool(any, any)).thenAnswer(
          (_) async => BaseResponse<bool>.failure(
            ErrorHandler.handle('writeBool error'),
          ),
        );

        when(
          mockSecureStorageService.writeJson(any, any),
        ).thenAnswer((_) async => const BaseResponse<bool>.success(true));

        final result = await dataSource.saveLoggedUserData(
          token: testToken,
          user: testUser,
        );

        expect(result, isA<Failure<void>>());
      });

      test('should return failure if writeJson fails', () async {
        when(
          mockSecureStorageService.write(StorageKeys.accessToken, testToken),
        ).thenAnswer((_) async => const BaseResponse<bool>.success(true));

        when(
          mockSecureStorageService.writeBool(any, any),
        ).thenAnswer((_) async => const BaseResponse<bool>.success(true));

        when(mockSecureStorageService.writeJson(any, any)).thenAnswer(
          (_) async => BaseResponse<bool>.failure(
            ErrorHandler.handle('writeJson error'),
          ),
        );

        final result = await dataSource.saveLoggedUserData(
          token: testToken,
          user: testUser,
        );

        expect(result, isA<Failure<void>>());
      });
    });
  });
}
