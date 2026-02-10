import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/splash/data/data_sources/splash_local_data_source.dart';
import 'package:flower_app/features/splash/data/repo/splash_repo_impl.dart';
import 'package:flower_app/features/splash/domain/repo/splash_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_repo_impl_test.mocks.dart';

@GenerateMocks([SplashLocalDataSource])
void main() {
  late MockSplashLocalDataSource mockSplashLocalDataSource;
  late SplashRepo splashRepositoryImpl;

  setUpAll(() {
    mockSplashLocalDataSource = MockSplashLocalDataSource();
    splashRepositoryImpl = SplashRepoImpl(mockSplashLocalDataSource);
  });

  group('isLogged', () {
    test('should return true if user is logged in', () async {
      when(
        mockSplashLocalDataSource.isLogged(),
      ).thenAnswer((_) async => const BaseResponse<bool>.success(true));
      final response = await splashRepositoryImpl.isLogged();
      expect(response, isA<Success<bool>>());
      final responseValue = response as Success<bool>;
      expect(responseValue.data, true);
    });

    test('should return false if user is not logged in', () async {
      when(
        mockSplashLocalDataSource.isLogged(),
      ).thenAnswer((_) async => const BaseResponse<bool>.success(false));
      final response = await splashRepositoryImpl.isLogged();
      expect(response, isA<Success<bool>>());
      final responseValue = response as Success<bool>;
      expect(responseValue.data, false);
    });
  });
}
