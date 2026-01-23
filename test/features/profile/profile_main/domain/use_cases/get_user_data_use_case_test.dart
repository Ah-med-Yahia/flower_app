import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/profile/profile_main/domain/entities/user_data_response.dart';
import 'package:flower_app/features/profile/profile_main/domain/entities/user_entity.dart';
import 'package:flower_app/features/profile/profile_main/domain/repos/profile_main_repo.dart';
import 'package:flower_app/features/profile/profile_main/domain/use_cases/get_user_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_data_use_case_test.mocks.dart';

@GenerateMocks([ProfileMainRepo])
void main() {
  late GetUserDataUseCase useCase;
  late ProfileMainRepo mockProfileMainRepo;

  setUp(() {
    mockProfileMainRepo = MockProfileMainRepo();
    useCase = GetUserDataUseCase(mockProfileMainRepo);
  });

  group('All Test Cases Scenarios of GetUserDataUseCase', () {
    _testSuccessfulCallWithData(() => mockProfileMainRepo, () => useCase);
    _testFailureWhenRepositoryReturnsFailure(
      () => mockProfileMainRepo,
      () => useCase,
    );
  });
}

void _testSuccessfulCallWithData(
  ProfileMainRepo Function() getMockRepo,
  GetUserDataUseCase Function() getUseCase,
) {
  test(
    'When call use case, '
    'it should return Success with UserDataResponse when repository call succeeds',
    () async {
      final mockProfileMainRepo = getMockRepo();
      final useCase = getUseCase();

      // Arrange
      final mockResponse = UserDataResponse(
        'success',
        UserEntity(
          id: '1',
          firstName: 'ahmed',
          email: 'user_email@example.com',
          imgAvatarURL: 'img1.jpg',
        ),
      );

      when(
        mockProfileMainRepo.getLoggedUserData(),
      ).thenAnswer((_) async => BaseResponse.success(mockResponse));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<Success<UserDataResponse>>());
      result.when(
        success: (data) {
          expect(data, isA<UserDataResponse>());
          expect(data.message, 'success');
          expect(data.user.id, '1');
          expect(data.user.firstName, 'ahmed');
          expect(data.user.email, 'user_email@example.com');
          expect(data.user.imgAvatarURL, 'img1.jpg');
        },
        failure: (_) => fail('Expected success but got failure'),
      );
      verify(mockProfileMainRepo.getLoggedUserData()).called(1);
    },
  );
}

void _testFailureWhenRepositoryReturnsFailure(
  ProfileMainRepo Function() getMockRepo,
  GetUserDataUseCase Function() getUseCase,
) {
  test('When call use case, '
      'it should return Failure when repository returns Failure', () async {
    final mockProfileMainRepo = getMockRepo();
    final useCase = getUseCase();

    // Arrange
    final mockErrorHandler = ErrorHandler.handle(Exception('Network error'));

    when(
      mockProfileMainRepo.getLoggedUserData(),
    ).thenAnswer((_) async => BaseResponse.failure(mockErrorHandler));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, isA<Failure<UserDataResponse>>());
    result.when(
      success: (_) {
        fail('Expected failure but got success');
      },
      failure: (errorHandler) {
        expect(errorHandler, isA<ErrorHandler>());
      },
    );
    verify(mockProfileMainRepo.getLoggedUserData()).called(1);
  });
}
