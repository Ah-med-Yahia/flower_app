import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/auth/login/data/datasources/local/local_login_data_source.dart';
import 'package:flower_app/features/auth/login/data/datasources/remote/remote_login_data_source.dart';
import 'package:flower_app/features/auth/login/data/models/login_response_model/login_response_model.dart';
import 'package:flower_app/features/auth/login/data/models/login_response_model/user_model.dart';
import 'package:flower_app/features/auth/login/data/repositories/login_repository_impl.dart';
import 'package:flower_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteLoginDataSource, LocalLoginDataSource])
void main() {
  late MockRemoteLoginDataSource mockRemote;
  late MockLocalLoginDataSource mockLocal;
  late LoginRepositoryImpl repository;
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
  final loginRequestTest = LoginRequestEntity(
    email: 'ahmed&gmail.com',
    password: 'Ahmed22',
  );
  final loginResponseTest = LoginResponseModel(
    message: '',
    token: '',
    user: testUser,
  );

  setUpAll(() {
    mockLocal = MockLocalLoginDataSource();
    mockRemote = MockRemoteLoginDataSource();
    repository = LoginRepositoryImpl(mockRemote, mockLocal);
  });

  group('Test cases for Repo', () {
    group('Success', () {
      test(
        'returns success when remote succeeds and remembered is false',
        () async {
          when(mockRemote.login(any)).thenAnswer(
            (_) async =>
                BaseResponse<LoginResponseModel>.success(loginResponseTest),
          );

          final result = await repository.login(loginRequestTest, false);

          expect(result, isA<Success<void>>());
          verify(mockRemote.login(any)).called(1);
          verifyZeroInteractions(mockLocal);
        },
      );

      test(
        'returns success when remote and local succeed and remembered is true',
        () async {
          when(mockRemote.login(any)).thenAnswer(
            (_) async =>
                BaseResponse<LoginResponseModel>.success(loginResponseTest),
          );

          when(
            mockLocal.saveLoggedUserData(
              token: anyNamed('token'),
              user: anyNamed('user'),
            ),
          ).thenAnswer((_) async => BaseResponse<void>.success(null));

          final result = await repository.login(loginRequestTest, true);

          expect(result, isA<Success<void>>());

          verify(mockRemote.login(any)).called(1);
          verify(
            mockLocal.saveLoggedUserData(
              token: anyNamed('token'),
              user: anyNamed('user'),
            ),
          ).called(1);
        },
      );
    });

    group('Failure', () {
      test('returns failure when local storage fails', () async {
        when(mockRemote.login(any)).thenAnswer(
          (_) async =>
              BaseResponse<LoginResponseModel>.success(loginResponseTest),
        );

        when(
          mockLocal.saveLoggedUserData(
            token: anyNamed('token'),
            user: anyNamed('user'),
          ),
        ).thenAnswer(
          (_) async =>
              BaseResponse<void>.failure(ErrorHandler.handle('local error')),
        );

        final result = await repository.login(loginRequestTest, true);

        expect(result, isA<Failure<void>>());
      });

      test('returns failure when remote fails', () async {
        when(mockRemote.login(any)).thenAnswer(
          (_) async => BaseResponse<LoginResponseModel>.failure(
            ErrorHandler.handle('api error'),
          ),
        );

        final result = await repository.login(loginRequestTest, true);

        expect(result, isA<Failure<void>>());

        verify(mockRemote.login(any)).called(1);
        verifyZeroInteractions(mockLocal);
      });
    });
  });
}
