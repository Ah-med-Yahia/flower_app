import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/profile/profile_main/domain/entities/user_data_response.dart';
import 'package:flower_app/features/profile/profile_main/domain/entities/user_entity.dart';
import 'package:flower_app/features/profile/profile_main/domain/use_cases/get_user_data_use_case.dart';
import 'package:flower_app/features/profile/profile_main/domain/use_cases/load_cached_user_data_use_case.dart';
import 'package:flower_app/features/profile/profile_main/domain/use_cases/logout_use_case.dart';
import 'package:flower_app/features/profile/profile_main/domain/use_cases/verify_session_use_case.dart';
import 'package:flower_app/features/profile/profile_main/presentation/view_models/profile_main_cubit.dart';
import 'package:flower_app/features/profile/profile_main/presentation/view_models/profile_main_intents.dart';
import 'package:flower_app/features/profile/profile_main/presentation/view_models/profile_main_side_effects.dart';
import 'package:flower_app/features/profile/profile_main/presentation/view_models/profile_main_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_main_cubit_test.mocks.dart';

@GenerateMocks([
  GetUserDataUseCase,
  LoadCachedUserDataUseCase,
  VerifySessionUseCase,
  LogoutUseCase,
])
void main() {
  late MockGetUserDataUseCase mockGetUserDataUseCase;
  late MockLoadCachedUserDataUseCase mockLoadCachedUserDataUseCase;
  late MockVerifySessionUseCase mockVerifySessionUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late ProfileMainCubit cubit;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockGetUserDataUseCase = MockGetUserDataUseCase();
    mockLoadCachedUserDataUseCase = MockLoadCachedUserDataUseCase();
    mockVerifySessionUseCase = MockVerifySessionUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    cubit = ProfileMainCubit(
      mockGetUserDataUseCase,
      mockVerifySessionUseCase,
      mockLoadCachedUserDataUseCase,
      mockLogoutUseCase,
    );
  });
  tearDown(() => cubit.close());
  group('All Test Cases of ProfileMainCubit', () {
    // Test Case 1
    test(
      '(1) Test Case: Initial State '
      'When cubit is initialized, it should start with default values',
      () async {
        // Arrange
        final profileMainState = cubit.state;
        // Assert
        expect(profileMainState, isA<ProfileMainStates>());
        // UserData State
        final userDataState = profileMainState.userData;
        expect(userDataState.isLoading, false);
        expect(userDataState.errorMessage, null);
        expect(userDataState.data, null);
        // Notifications State
        final notificationsState = profileMainState.isNotificationsEnabled;
        expect(notificationsState, true);
        // Language State
        final languageState = profileMainState.selectedLanguage;
        expect(languageState, AppTextConstants.englishProfileState);
      },
    );

    // Test Case 2
    test('(2) Test Case: Navigate to Edit Profile, '
        'it should emit event to stream', () async {
      // Arrange
      final profileMainState = cubit.state;

      // Listen to the stream before emitting
      expectLater(
        cubit.sideEffects,
        emits(isA<NavigateToEditProfileSideEffect>()),
      );
      // Act
      await cubit.doIntent(EditProfileIntent());

      // Assert state doesn't change
      expect(cubit.state, equals(profileMainState));
    });

    // Test Case 3
    test('(3) Test Case: Select Language, '
        'it should emit event to stream', () async {
      // Arrange
      final profileMainState = cubit.state;

      // Listen to the stream before emitting
      expectLater(
        cubit.sideEffects,
        emits(isA<ShowLanguageBottomSheetSideEffect>()),
      );
      // Act
      await cubit.doIntent(SelectLanguageIntent());

      // Assert
      expect(cubit.state, equals(profileMainState));
    });

    // Test Case 4
    test('(4) Test Case: Update Language to Arabic, '
        'it should update the state with new language', () async {
      // Arrange
      const newLanguage = 'العربية';

      // Act
      await cubit.doIntent(UpdateLanguageIntent(newLanguage));

      // Assert
      expect(cubit.state, isA<ProfileMainStates>());
      expect(cubit.state.selectedLanguage, equals(newLanguage));
    });

    // Test Case 5
    test('(5) Test Case: Toggle Notifications, '
        'it should toggle the notification state', () async {
      // Arrange
      final initialNotificationState = cubit.state.isNotificationsEnabled;

      // Act
      await cubit.doIntent(NotificationToggledIntent());

      // Assert
      expect(
        cubit.state.isNotificationsEnabled,
        equals(!initialNotificationState),
      );
    });

    // Test Case 6
    test('(6) Test Case: Toggle Notifications twice, '
        'it should return to initial state', () async {
      // Arrange
      final initialNotificationState = cubit.state.isNotificationsEnabled;

      // Act
      await cubit.doIntent(NotificationToggledIntent());
      await cubit.doIntent(NotificationToggledIntent());

      // Assert
      expect(
        cubit.state.isNotificationsEnabled,
        equals(initialNotificationState),
      );
    });

    // Test Case 7
    test('(7) Test Case: Get User Data with valid session, '
        'it should fetch and set user data', () async {
      // Arrange
      const testUser = UserEntity(
        id: '1',
        firstName: 'Test User',
        email: 'test@example.com',
        imgAvatarURL: 'https://example.com/avatar.png',
      );
      const testUserDataResponse = UserDataResponse('Success', testUser);

      when(
        mockVerifySessionUseCase.call(),
      ).thenAnswer((_) async => BaseResponse.success(SessionValid()));
      when(mockGetUserDataUseCase.call()).thenAnswer(
        (_) async => const BaseResponse.success(testUserDataResponse),
      );

      // Act
      await cubit.doIntent(GetUserDataIntent());

      // Assert
      expect(cubit.state.userData.isLoading, false);
      expect(cubit.state.userData.errorMessage, null);
      expect(cubit.state.userData.data, testUserDataResponse);
      verify(mockVerifySessionUseCase.call()).called(1);
      verify(mockGetUserDataUseCase.call()).called(1);
    });

    // Test Case 8
    test('(8) Test Case: Get User Data with invalid session (not logged in), '
        'it should emit NavigateToLoginSideEffect', () async {
      // Arrange
      when(mockVerifySessionUseCase.call()).thenAnswer(
        (_) async => BaseResponse.success(
          SessionInvalid(ErrorsConstant.userNotLoggedInError),
        ),
      );

      // Listen to the stream before emitting
      expectLater(cubit.sideEffects, emits(isA<NavigateToLoginSideEffect>()));

      // Act
      await cubit.doIntent(GetUserDataIntent());

      // Assert
      expect(cubit.state.userData.isLoading, false);
      expect(
        cubit.state.userData.errorMessage,
        ErrorsConstant.userNotLoggedInError,
      );
      verifyNever(mockGetUserDataUseCase.call());
    });

    // Test Case 9
    test('(9) Test Case: Get User Data with session expired, '
        'it should emit NavigateToLoginSideEffect', () async {
      // Arrange
      when(mockVerifySessionUseCase.call()).thenAnswer(
        (_) async => BaseResponse.success(
          SessionInvalid(ErrorsConstant.sessionExpiredError),
        ),
      );

      // Listen to the stream before emitting
      expectLater(cubit.sideEffects, emits(isA<NavigateToLoginSideEffect>()));

      // Act
      await cubit.doIntent(GetUserDataIntent());

      // Assert
      expect(cubit.state.userData.isLoading, false);
      expect(
        cubit.state.userData.errorMessage,
        ErrorsConstant.sessionExpiredError,
      );
    });

    // Test Case 10
    test('(10) Test Case: Get User Data with session verification failure, '
        'it should emit ShowErrorSideEffect', () async {
      // Arrange
      final errorHandler = ErrorHandler.handle(Exception('Network error'));

      when(
        mockVerifySessionUseCase.call(),
      ).thenAnswer((_) async => BaseResponse.failure(errorHandler));

      // Listen to the stream before emitting
      expectLater(cubit.sideEffects, emits(isA<ShowErrorSideEffect>()));

      // Act
      await cubit.doIntent(GetUserDataIntent());

      // Assert
      expect(cubit.state.userData.isLoading, false);
      expect(cubit.state.userData.errorMessage, isNotNull);
      verifyNever(mockGetUserDataUseCase.call());
    });

    // Test Case 11
    test('(11) Test Case: Get User Data with valid session but fetch failure, '
        'it should set error message in state', () async {
      // Arrange
      final errorHandler = ErrorHandler.handle(Exception('API error'));

      when(
        mockVerifySessionUseCase.call(),
      ).thenAnswer((_) async => BaseResponse.success(SessionValid()));
      when(
        mockGetUserDataUseCase.call(),
      ).thenAnswer((_) async => BaseResponse.failure(errorHandler));

      // Act
      await cubit.doIntent(GetUserDataIntent());

      // Assert
      expect(cubit.state.userData.isLoading, false);
      expect(cubit.state.userData.errorMessage, errorHandler.message);
      expect(cubit.state.userData.data, null);
    });

    // Test Case 12
    test('(12) Test Case: Load Cached User Data successfully, '
        'it should update loading state', () async {
      // Arrange
      final cachedUserData = <String, dynamic>{
        'id': '1',
        'firstName': 'Cached User',
        'email': 'cached@example.com',
        'imgAvatarURL': 'https://example.com/cached.png',
      };

      when(
        mockLoadCachedUserDataUseCase.call(),
      ).thenAnswer((_) async => BaseResponse.success(cachedUserData));

      // Act
      await cubit.doIntent(LoadCachedDataIntent());

      // Assert
      expect(cubit.state.userData.isLoading, false);
      verify(mockLoadCachedUserDataUseCase.call()).called(1);
    });

    // Test Case 13
    test('(13) Test Case: Load Cached User Data with null data, '
        'it should emit ShowErrorSideEffect', () async {
      // Arrange
      when(
        mockLoadCachedUserDataUseCase.call(),
      ).thenAnswer((_) async => const BaseResponse.success(null));

      // Listen to the stream before emitting
      expectLater(cubit.sideEffects, emits(isA<ShowErrorSideEffect>()));

      // Act
      await cubit.doIntent(LoadCachedDataIntent());

      // Assert
      expect(cubit.state.userData.isLoading, false);
    });

    // Test Case 14
    test('(14) Test Case: Load Cached User Data with failure, '
        'it should emit ShowErrorSideEffect', () async {
      // Arrange
      final errorHandler = ErrorHandler.handle(Exception('Cache read error'));

      when(
        mockLoadCachedUserDataUseCase.call(),
      ).thenAnswer((_) async => BaseResponse.failure(errorHandler));

      // Listen to the stream before emitting
      expectLater(cubit.sideEffects, emits(isA<ShowErrorSideEffect>()));

      // Act
      await cubit.doIntent(LoadCachedDataIntent());

      // Assert
      expect(cubit.state.userData.isLoading, false);
    });

    // Test Case 15
    test('(15) Test Case: Logout successfully, '
        'it should emit NavigateToLoginSideEffect', () async {
      // Arrange
      when(
        mockLogoutUseCase.call(),
      ).thenAnswer((_) async => const BaseResponse.success(null));

      // Listen to the stream before emitting
      expectLater(cubit.sideEffects, emits(isA<NavigateToLoginSideEffect>()));

      // Act
      await cubit.doIntent(LogoutIntent());

      // Assert
      expect(cubit.state.userData.isLoading, false);
      verify(mockLogoutUseCase.call()).called(1);
    });

    // Test Case 16
    test('(16) Test Case: Logout with failure, '
        'it should emit ShowErrorSideEffect', () async {
      // Arrange
      final errorHandler = ErrorHandler.handle(Exception('Logout error'));

      when(
        mockLogoutUseCase.call(),
      ).thenAnswer((_) async => BaseResponse.failure(errorHandler));

      // Listen to the stream before emitting
      expectLater(cubit.sideEffects, emits(isA<ShowErrorSideEffect>()));

      // Act
      await cubit.doIntent(LogoutIntent());

      // Assert
      expect(cubit.state.userData.isLoading, false);
    });
  });
}
