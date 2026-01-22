import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/profile/profile_main/data/datasource/profile_main_remote_data_source.dart';
import 'package:flower_app/features/profile/profile_main/data/models/user_data_response_dto.dart';
import 'package:flower_app/features/profile/profile_main/data/models/user_dto.dart';
import 'package:flower_app/features/profile/profile_main/data/repos/profile_main_repo_impl.dart';
import 'package:flower_app/features/profile/profile_main/domain/entities/user_data_response.dart';
import 'package:flower_app/features/profile/profile_main/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_main_repo_impl_test.mocks.dart';

@GenerateMocks([ProfileMainRemoteDataSource])
void main() {
  late ProfileMainRepoImpl repository;
  late MockProfileMainRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockProfileMainRemoteDataSource();
    repository = ProfileMainRepoImpl(mockRemoteDataSource);
  });

  group('getLoggedUserData', () {
    _testSuccessfulGetLoggedUserData(
      () => mockRemoteDataSource,
      () => repository,
    );
    _testGetBestSellerThrowsException(
      () => mockRemoteDataSource,
      () => repository,
    );
  });
}

void _testSuccessfulGetLoggedUserData(
  MockProfileMainRemoteDataSource Function() getMockRemoteDataSource,
  ProfileMainRepoImpl Function() getRepository,
) {
  test(
    'When call getLoggedUserData, '
    'it should return Success with UserDataResponse when remote data source call succeeds',
    () async {
      final mockRemoteDataSource = getMockRemoteDataSource();
      final repository = getRepository();

      // Arrange
      final userDto = UserDto(
        id: '1',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.c.calhoun@examplepetstore.com',
        phone: '1234567890',
        gender: 'Male',
        photo: 'https://example.com/avatar.jpg',
        role: 'user',
        createdAt: DateTime(2023, 1, 1),
        addresses: const [],
        wishlist: const [],
      );
      final mockDto = UserDataResponseDto(message: 'success', user: userDto);
      when(
        mockRemoteDataSource.getLoggedUserData(),
      ).thenAnswer((_) async => mockDto);

      // Act
      final result = await repository.getLoggedUserData();

      // Assert
      expect(result, isA<Success<UserDataResponse>>());
      result.when(
        success: (data) {
          expect(data, isA<UserDataResponse>());
          expect(data.message, 'success');
          expect(data.user, isA<UserEntity>());
          expect(data.user.id, '1');
          expect(data.user.firstName, 'John');
        },
        failure: (_) => fail('Expected success but got failure'),
      );
      verify(mockRemoteDataSource.getLoggedUserData()).called(1);
    },
  );
}

void _testGetBestSellerThrowsException(
  MockProfileMainRemoteDataSource Function() getMockRemoteDataSource,
  ProfileMainRepoImpl Function() getRepository,
) {
  test(
    'When call getLoggedUserData, '
    'in case of failure, it should return Failure with ErrorHandler DIO connection timeout',
    () async {
      final mockRemoteDataSource = getMockRemoteDataSource();
      final repository = getRepository();

      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
        message: 'Connection timeout. Please try again.',
      );
      when(mockRemoteDataSource.getLoggedUserData()).thenThrow(dioException);

      final errorMessage = ErrorHandler.handle(dioException).message;
      final statusCode = ErrorHandler.handle(dioException).code;

      // Act
      final result = await repository.getLoggedUserData();

      // Assert
      expect(result, isA<Failure<UserDataResponse>>());
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (errorHandler) {
          expect(errorHandler, isA<ErrorHandler>());
          expect(errorHandler.message, errorMessage);
          expect(errorHandler.code, statusCode);
          expect(errorHandler.message, 'Connection timeout. Please try again.');
          expect(errorHandler.code, -1);
        },
      );
      verify(mockRemoteDataSource.getLoggedUserData()).called(1);
    },
  );
}
