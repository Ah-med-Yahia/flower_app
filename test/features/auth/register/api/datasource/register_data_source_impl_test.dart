import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/register/api/api_client/register_api_client.dart';
import 'package:flower_app/features/auth/register/api/datasource/register_data_source_impl.dart';
import 'package:flower_app/features/auth/register/data/models/register_request/register_request.dart';
import 'package:flower_app/features/auth/register/data/models/register_response/register_response.dart';
import 'package:flower_app/features/auth/register/data/models/register_response/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_data_source_impl_test.mocks.dart';

@GenerateMocks([RegisterApiClient])
void main() {
  late MockRegisterApiClient mockApi;
  late RegisterDataSourceImpl dataSource;

  const request = RegisterRequestModel(
    email: 'omar@gmail.com',
    firstName: 'Omar',
    lastName: 'Ahmed',
    password: '123456',
    rePassword: '123456',
    phone: '0123456789',
    gender: 'male',
  );

  final user = User(
    firstName: 'Omar',
    lastName: 'Ahmed',
    email: 'omar@gmail.com',
    gender: 'male',
    phone: '0123456789',
    createdAt: DateTime.now(),
  );

  final responseModel = RegisterResponseModel(
    message: 'success',
    user: user,
    token: 'token',
  );

  setUp(() {
    mockApi = MockRegisterApiClient();
    dataSource = RegisterDataSourceImpl(registerApiClient: mockApi);
  });

  group('Register DataSource Implementation Scenarios', () {
    test('should return success response', () async {
      // Arrange
      when(mockApi.register(request)).thenAnswer((_) async => responseModel);

      // Act
      final result = await dataSource.register(request);

      // Assert
      result.map(
        success: (response) {
          expect(response.data, responseModel);
          expect(response.data.user.email, user.email);
          expect(response.data.token, 'token');
        },
        failure: (_) => fail('Expected success'),
      );

      verify(mockApi.register(request)).called(1);
    });

    test('should return failure when api throws exception', () async {
      // Arrange
      when(
        mockApi.register(request),
      ).thenThrow(Exception('Failed to register'));

      // Act
      final result = await dataSource.register(request);

      // Assert
      result.map(
        success: (_) => fail('Expected failure'),
        failure: (failure) {
          expect(failure.errorHandler.message, isNotEmpty);
        },
      );

      verify(mockApi.register(request)).called(1);
    });
  });
}
