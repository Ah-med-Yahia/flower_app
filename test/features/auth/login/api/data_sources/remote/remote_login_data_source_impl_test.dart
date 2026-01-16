import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/auth/login/api/api_client/login_api_client.dart';
import 'package:flower_app/features/auth/login/api/data_sources/remote/remote_login_data_source_impl.dart';
import 'package:flower_app/features/auth/login/data/models/login_request_model/login_request_model.dart';
import 'package:flower_app/features/auth/login/data/models/login_response_model/login_response_model.dart';
import 'package:flower_app/features/auth/login/data/models/login_response_model/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'remote_login_data_source_impl_test.mocks.dart';

@GenerateMocks([LoginApiClient])
void main() {
  late RemoteLoginDataSourceImpl dataSource;
  late MockLoginApiClient mockLoginApiClient;
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
  final loginRequestTest = LoginRequestModel(
    email: 'ahmed@gmail.com',
    password: 'Ahmed22',
  );
  final loginResponseTest = LoginResponseModel(
    message: '',
    token: '',
    user: testUser,
  );
  setUpAll(() {
    mockLoginApiClient = MockLoginApiClient();
    dataSource = RemoteLoginDataSourceImpl(mockLoginApiClient);
  });

  group('Test Cases for Remote DS', () {
    test('should return success when api call succeeds', () async {
      when(
        mockLoginApiClient.login(loginRequestTest),
      ).thenAnswer((_) async => loginResponseTest);

      final result = await dataSource.login(loginRequestTest);

      expect(result, isA<Success<LoginResponseModel>>());

      verify(mockLoginApiClient.login(loginRequestTest)).called(1);
    });

    test('should return failure when api call throws exception', () async {
      when(mockLoginApiClient.login(loginRequestTest)).thenThrow(
        DioException(
          type: DioExceptionType.badCertificate,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await dataSource.login(loginRequestTest);

      expect(result, isA<Failure<LoginResponseModel>>());
      final error = result as Failure;
      expect(error.errorhandeler.apiErrorModel.code, ResponseCode.badCertificate);
    });
  });
}
