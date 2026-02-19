import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/shared/data/models/get_products_models/product_model.dart';
import 'package:flower_app/features/home/api/data_sources/remote/home_screen_data_source_impl.dart';
import 'package:flower_app/features/home/data/models/category_dto.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flower_app/features/home/data/models/occasion_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/home/api/api_clinet/home_screen_api_client.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_screen_data_source_impl_test.mocks.dart';

@GenerateMocks([HomeScreenApiClient])
void main() {
  late HomeScreenDataSourceImpl dataSource;
  late MockHomeScreenApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockHomeScreenApiClient();
    dataSource = HomeScreenDataSourceImpl(mockApiClient);
  });

  group('HomeScreenDataSourceImpl', () {
    final homeResponseDto = HomeResponseDto(
      message: 'success',
      categories: [
        CategoryDto(
          id: '1',
          name: 'Test Category',
          slug: 'test-category',
          image: 'https://test.com/image.png',
          createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          isSuperAdmin: true,
        ),
      ],
      bestSeller: [
        ProductModel(
          id: '1',
          title: 'Test Product',
          slug: 'test-product',
          description: 'Test Description',
          imgCover: 'https://test.com/cover.png',
          images: ['https://test.com/image1.png'],
          price: 100.0,
          priceAfterDiscount: 80.0,
          quantity: 10,
          category: 'cat1',
          occasion: 'occ1',
          createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          v: 0,
          isSuperAdmin: true,
          sold: 5,
          rateAvg: 4.5,
          rateCount: 10,
        ),
      ],
      occasions: [
        OccasionDto(
          id: '1',
          name: 'Test Occasion',
          slug: 'test-occasion',
          image: 'https://test.com/occasion.png',
          createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          isSuperAdmin: true,
        ),
      ],
    );

    test(
      'should return success BaseResponse when api client returns HomeResponseDto',
      () async {
        when(
          mockApiClient.getHomeScreenData(),
        ).thenAnswer((_) async => homeResponseDto);

        // Act
        final result = await dataSource.getHomeScreenData();

        // Assert
        expect(result, isA<BaseResponse<HomeResponseDto>>());
        result.when(
          success: (data) {
            expect(data.message, 'success');
            expect(data.bestSeller, homeResponseDto.bestSeller);
            expect(data.categories, homeResponseDto.categories);
            expect(data.occasions, homeResponseDto.occasions);
          },
          failure: (_) => fail('Expected success but got failure'),
        );

        verify(mockApiClient.getHomeScreenData()).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return failure BaseResponse when api client throws exception',
      () async {
        // Arrange
        when(
          mockApiClient.getHomeScreenData(),
        ).thenThrow(Exception('Network error'));

        // Act
        final result = await dataSource.getHomeScreenData();

        // Assert
        expect(result, isA<BaseResponse<HomeResponseDto>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (errorHandler) {
            expect(
              errorHandler.message,
              ErrorHandler.handle('Network error').message,
            );
            expect(
              errorHandler.code,
              ErrorHandler.handle('Network error').code,
            );
          },
        );

        verify(mockApiClient.getHomeScreenData()).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );
  });
}
