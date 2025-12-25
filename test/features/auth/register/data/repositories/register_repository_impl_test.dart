import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/features/auth/register/data/datasources/register_data_source.dart';
import 'package:online_exam_app/features/auth/register/data/models/register_request/register_request.dart';
import 'package:online_exam_app/features/auth/register/data/models/register_response/register_response.dart';
import 'package:online_exam_app/features/auth/register/data/models/register_response/user.dart';
import 'package:online_exam_app/features/auth/register/data/repositories/register_repository_impl.dart';
import 'package:online_exam_app/features/auth/register/domain/entities/register_entity.dart';

import 'register_repository_impl_test.mocks.dart';

@GenerateMocks([RegisterDataSource])
void main() {
  late RegisterRepositoryImpl repository;
  late MockRegisterDataSource mockDataSource;

  final request = RegisterRequestModel(
    email: "omar@gmail.com",
    firstName: "Omar",
    lastName: "Ahmed",
    password: "123456",
    rePassword: "123456",
    phone: "0123456789",
    gender: "male",
  );

  final user = User(
    firstName: "Omar",
    lastName: "Ahmed",
    email: "omar@gmail.com",
    gender: "male",
    phone: "0123456789",
    createdAt: DateTime.now(),
  );

  final responseModel = RegisterResponseModel(
    message: "success",
    user: user,
    token: "token",
  );

  setUp(() {
    mockDataSource = MockRegisterDataSource();
    repository = RegisterRepositoryImpl(mockDataSource);
  });

  group('RegisterRepositoryImplementation Senarios', () {
    test('should return RegisterEntity when success', () async {
      // Arrange
      when(mockDataSource.register(request)).thenAnswer(
        (_) async => BaseResponse.success(responseModel),
      );

      // Act
      final result = await repository.register(request);

      // Assert
      result.when(
        success: (data) {
          expect(data, isA<RegisterEntity>());
          expect(data.user.email, user.email);
          expect(data.token, 'token');
        },
        failure: (_) => fail('Expected success'),
      );
    });

    test('should return failure when datasource fails', () async {
      // Arrange
      when(mockDataSource.register(request)).thenAnswer(
        (_) async => BaseResponse.failure(
          ErrorHandler.handle(Exception('Registration failed')),
        ),
      );

      // Act
      final result = await repository.register(request);

      // Assert
      result.when(
        success: (_) => fail('Expected failure'),
        failure: (error) {
          expect(error.message, isNotNull);
        },
      );
    });
  });
}
