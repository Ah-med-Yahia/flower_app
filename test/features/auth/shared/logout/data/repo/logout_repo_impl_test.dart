import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/auth/shared/logout/data/datasoources/local/logout_local_data_source.dart';
import 'package:flower_app/features/auth/shared/logout/data/repo/logout_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_repo_impl_test.mocks.dart';

@GenerateMocks([LogoutLocalDataSource])
void main() {
  late LogoutRepoImpl repository;
  late MockLogoutLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLogoutLocalDataSource();
    repository = LogoutRepoImpl(mockLocalDataSource);
  });

  group('clearUserTokens', () {
    test('should return success when data source succeeds', () async {
      // Arrange
      when(
        mockLocalDataSource.clearUserTokens(),
      ).thenAnswer((_) async => BaseResponse<void>.success(null));

      // Act
      final result = await repository.clearUserTokens();

      // Assert
      expect(result, isA<BaseResponse<void>>());
      result.when(
        success: (_) {},
        failure: (_) => fail('Expected success but got failure'),
      );

      verify(mockLocalDataSource.clearUserTokens()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return failure when data source fails', () async {
      // Arrange
      final errorHandler = ErrorHandler.handle(
        Exception('Failed to clear tokens'),
      );

      when(
        mockLocalDataSource.clearUserTokens(),
      ).thenAnswer((_) async => BaseResponse<void>.failure(errorHandler));

      // Act
      final result = await repository.clearUserTokens();

      // Assert
      result.when(
        success: (_) {
          fail('Expected failure but got success');
        },
        failure: (error) {
          expect(error, isNotNull);
          expect(error, equals(errorHandler));
        },
      );

      verify(mockLocalDataSource.clearUserTokens()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });
}
