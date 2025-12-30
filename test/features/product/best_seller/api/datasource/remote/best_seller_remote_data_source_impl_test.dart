import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/features/product/best_seller/api/api_client/best_seller_api_client.dart';
import 'package:online_exam_app/features/product/best_seller/api/datasource/remote/best_seller_remote_data_source_impl.dart';
import 'package:online_exam_app/features/product/best_seller/data/models/best_seller_response_dto.dart';

import 'best_seller_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([BestSellerApiClient])
void main() {
  late BestSellerRemoteDataSourceImpl dataSource;
  late MockBestSellerApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockBestSellerApiClient();
    dataSource = BestSellerRemoteDataSourceImpl(mockApiClient);
  });

  group('getBestSeller', () {
    _testSuccessfulGetBestSeller(() => mockApiClient, () => dataSource);
    _testGetBestSellerThrowsException(() => mockApiClient, () => dataSource);
  });
}

void _testSuccessfulGetBestSeller(
  MockBestSellerApiClient Function() getMockApiClient,
  BestSellerRemoteDataSourceImpl Function() getDataSource,
) {
  test(
    'When call getBestSeller, it should return BestSellerResponseDto when API call is successful',
    () async {
      final mockApiClient = getMockApiClient();
      final dataSource = getDataSource();

      // Arrange
      final mockResponse = BestSellerResponseDto(
        message: 'success',
        bestSellerDto: [],
      );
      when(mockApiClient.getBestSeller()).thenAnswer((_) async => mockResponse);

      // Act
      final result = await dataSource.getBestSeller();

      // Assert
      expect(result, mockResponse);
      verify(mockApiClient.getBestSeller()).called(1);
      verifyNoMoreInteractions(mockApiClient);
    },
  );
}

void _testGetBestSellerThrowsException(
  MockBestSellerApiClient Function() getMockApiClient,
  BestSellerRemoteDataSourceImpl Function() getDataSource,
) {
  test(
    'When call getBestSeller, it should throw an exception when API call fails',
    () async {
      final mockApiClient = getMockApiClient();
      final dataSource = getDataSource();

      // Arrange
      final exception = Exception('API call failed');
      when(mockApiClient.getBestSeller()).thenThrow(exception);

      // Act
      final result = dataSource.getBestSeller();

      // Assert
      await expectLater(result, throwsException);
      verify(mockApiClient.getBestSeller()).called(1);
    },
  );
}
