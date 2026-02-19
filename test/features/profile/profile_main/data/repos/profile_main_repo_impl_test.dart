import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/datasource/local/profile_main_local_data_source.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/datasource/profile_main_remote_data_source.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/terms_and_conditions/bilingual_content.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/terms_and_conditions/bilingual_list.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/terms_and_conditions/section_style.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/terms_and_conditions/term_section.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/terms_and_conditions/terms_and_conditions.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/user_data_response_dto.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/user_dto.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/repos/profile_main_repo_impl.dart';
import 'package:flower_app/features/tabs/profile/profile_main/domain/entities/term_section_entity.dart';
import 'package:flower_app/features/tabs/profile/profile_main/domain/entities/user_data_response.dart';
import 'package:flower_app/features/tabs/profile/profile_main/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_main_repo_impl_test.mocks.dart';

@GenerateMocks([ProfileMainRemoteDataSource, ProfileMainLocalDataSource])
void main() {
  late ProfileMainRepoImpl repository;
  late MockProfileMainRemoteDataSource mockRemoteDataSource;
  late MockProfileMainLocalDataSource mockLocalDataSource;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockRemoteDataSource = MockProfileMainRemoteDataSource();
    mockLocalDataSource = MockProfileMainLocalDataSource();
    repository = ProfileMainRepoImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  group('getLoggedUserData', () {
    _testSuccessfulGetLoggedUserData(
      () => mockRemoteDataSource,
      () => repository,
    );
    _testGetLoggedUserDataThrowsException(
      () => mockRemoteDataSource,
      () => repository,
    );
  });

  group('getTermsData', () {
    _testSuccessfulGetTermsData(() => mockLocalDataSource, () => repository);
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

void _testGetLoggedUserDataThrowsException(
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

      // Act
      final result = await repository.getLoggedUserData();

      // Assert
      expect(result, isA<Failure<UserDataResponse>>());
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (errorHandler) {
          expect(errorHandler, isA<ErrorHandler>());
          expect(errorHandler.message, equals('errors.timeout'));
          expect(errorHandler.code, -1);
        },
      );
      verify(mockRemoteDataSource.getLoggedUserData()).called(1);
    },
  );
}

void _testSuccessfulGetTermsData(
  MockProfileMainLocalDataSource Function() getMockLocalDataSource,
  ProfileMainRepoImpl Function() getRepository,
) {
  test(
    'When call getTermsData, '
    'it should return Success with loaded TermsAndConditions when local data source call succeeds',
    () async {
      final mockLocalDataSource = getMockLocalDataSource();
      final repository = getRepository();

      // Arrange
      final section = TermSection(
        section: 'section 1',
        title: BilingualContent(en: 'en', ar: 'ar'),
        content: BilingualList(en: ['en1', 'en2'], ar: ['ar1', 'ar2']),
        style: SectionStyle(),
      );

      final mockDto = TermsAndConditions(sections: [section]);
      when(mockLocalDataSource.getTermsData()).thenAnswer((_) async => mockDto);

      // Act
      final result = await repository.getTermsData();

      // Assert
      expect(result, isA<Success<List<TermSectionEntity>>>());
      result.when(
        success: (data) {
          expect(data, isA<List<TermSectionEntity>>());
          expect(data[0].content, isA<Map<String, List<String>>>());
          expect(data[0].style, isA<SectionStyleEntity>());
          expect(data[0].style.title, isA<TextStyleEntity?>());
          expect(data[0].style.content, isA<TextStyleEntity?>());
          expect(data[0].style.color, isA<Color?>());
          expect(data[0].style.textAlign, isA<Map<String, TextAlign>?>());
          expect(data[0].section, 'section 1');
          expect(data[0].content['en'], ['en1', 'en2']);
          expect(data[0].content['ar'], ['ar1', 'ar2']);
          expect(data[0].section, 'section 1');
          expect(data[0].title, {'en': 'en', 'ar': 'ar'});
        },
        failure: (_) => fail('Expected success but got failure'),
      );
      verify(mockLocalDataSource.getTermsData()).called(1);
    },
  );
}
