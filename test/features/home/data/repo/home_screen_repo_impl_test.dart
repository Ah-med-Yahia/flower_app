import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/shared/data/models/get_products_models/product_model.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';
import 'package:flower_app/features/home/data/data_sources/remote/home_screen_data_source.dart';
import 'package:flower_app/features/home/data/models/category_dto.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flower_app/features/home/data/models/occasion_dto.dart';
import 'package:flower_app/features/home/data/repo/home_screen_repo_impl.dart';
import 'package:flower_app/features/home/domain/entities/category_entity.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/entities/occasion_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_screen_repo_impl_test.mocks.dart';

@GenerateMocks([HomeScreenDataSource])
void main() {
  late HomeScreenRepoImpl repoImpl;
  late MockHomeScreenDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockHomeScreenDataSource();
    repoImpl = HomeScreenRepoImpl(mockDataSource);
  });

  group('getHomeScreenData', () {
    final homeResponseDto = HomeResponseDto(
      message: 'success',
      categories: [
        CategoryDto(
          id: '1',
          name: 'Roses',
          slug: 'roses',
          image: 'https://test.com/roses.png',
          createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          isSuperAdmin: false,
        ),
        CategoryDto(
          id: '2',
          name: 'Tulips',
          slug: 'tulips',
          image: 'https://test.com/tulips.png',
          createdAt: DateTime.parse('2024-01-02T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-02T00:00:00.000Z'),
          isSuperAdmin: false,
        ),
        CategoryDto(
          id: '3',
          name: 'Orchids',
          slug: 'orchids',
          image: 'https://test.com/orchids.png',
          createdAt: DateTime.parse('2024-01-03T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-03T00:00:00.000Z'),
          isSuperAdmin: false,
        ),
      ],
      bestSeller: [
        ProductModel(
          id: '101',
          title: 'Red Rose Bouquet',
          slug: 'red-rose-bouquet',
          description: 'Beautiful red roses perfect for any occasion',
          imgCover: 'https://example.com/red-roses.jpg',
          images: [
            'https://example.com/red-roses-1.jpg',
            'https://example.com/red-roses-2.jpg',
          ],
          price: 49.99,
          priceAfterDiscount: 39.99,
          quantity: 50,
          category: '1',
          occasion: '201',
          createdAt: DateTime.parse('2024-01-05T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-05T00:00:00.000Z'),
          v: 0,
          isSuperAdmin: false,
          sold: 100,
          rateAvg: 4.5,
          rateCount: 25,
        ),
        ProductModel(
          id: '102',
          title: 'White Lily Arrangement',
          slug: 'white-lily-arrangement',
          description: 'Elegant white lilies for special moments',
          imgCover: 'https://example.com/white-lilies.jpg',
          images: ['https://example.com/white-lilies-1.jpg'],
          price: 59.99,
          priceAfterDiscount: 54.99,
          quantity: 30,
          category: '2',
          occasion: '202',
          createdAt: DateTime.parse('2024-01-06T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-06T00:00:00.000Z'),
          v: 0,
          isSuperAdmin: false,
          sold: 75,
          rateAvg: 4.8,
          rateCount: 40,
        ),
        ProductModel(
          id: '103',
          title: 'Sunflower Delight',
          slug: 'sunflower-delight',
          description: 'Bright and cheerful sunflowers to brighten any day',
          imgCover: 'https://example.com/sunflowers.jpg',
          images: [
            'https://example.com/sunflowers-1.jpg',
            'https://example.com/sunflowers-2.jpg',
            'https://example.com/sunflowers-3.jpg',
          ],
          price: 35.99,
          priceAfterDiscount: 29.99,
          quantity: 75,
          category: '3',
          occasion: '203',
          createdAt: DateTime.parse('2024-01-07T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-07T00:00:00.000Z'),
          v: 0,
          isSuperAdmin: false,
          sold: 150,
          rateAvg: 4.7,
          rateCount: 60,
        ),
      ],
      occasions: [
        OccasionDto(
          id: '201',
          name: 'Birthday',
          slug: 'birthday',
          image: 'https://example.com/birthday.jpg',
          createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          isSuperAdmin: false,
        ),
        OccasionDto(
          id: '202',
          name: 'Anniversary',
          slug: 'anniversary',
          image: 'https://example.com/anniversary.jpg',
          createdAt: DateTime.parse('2024-01-02T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-02T00:00:00.000Z'),
          isSuperAdmin: false,
        ),
        OccasionDto(
          id: '203',
          name: 'Wedding',
          slug: 'wedding',
          image: 'https://example.com/wedding.jpg',
          createdAt: DateTime.parse('2024-01-03T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-03T00:00:00.000Z'),
          isSuperAdmin: false,
        ),
      ],
    );

    final homeResponseEntity = HomeResponseEntity(
      message: 'success',
      categories: [
        CategoryEntity(
          id: '1',
          name: 'Roses',
          slug: 'roses',
          image: 'https://test.com/roses.png',
          createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          isSuperAdmin: false,
        ),
        CategoryEntity(
          id: '2',
          name: 'Tulips',
          slug: 'tulips',
          image: 'https://test.com/tulips.png',
          createdAt: DateTime.parse('2024-01-02T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-02T00:00:00.000Z'),
          isSuperAdmin: false,
        ),
        CategoryEntity(
          id: '3',
          name: 'Orchids',
          slug: 'orchids',
          image: 'https://test.com/orchids.png',
          createdAt: DateTime.parse('2024-01-03T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-03T00:00:00.000Z'),
          isSuperAdmin: false,
        ),
      ],
      bestSeller: [
        ProductEntity(
          id: '101',
          title: 'Red Rose Bouquet',
          description: 'Beautiful red roses perfect for any occasion',
          imageCover: 'https://example.com/red-roses.jpg',
          images: [
            'https://example.com/red-roses-1.jpg',
            'https://example.com/red-roses-2.jpg',
          ],
          price: 49.99,
          priceAfterDiscount: 39.99,
          discount: 20,
          quantity: 50,
          categoryId: '1',
          occasionId: '201',
        ),
        ProductEntity(
          id: '102',
          title: 'White Lily Arrangement',
          description: 'Elegant white lilies for special moments',
          imageCover: 'https://example.com/white-lilies.jpg',
          images: ['https://example.com/white-lilies-1.jpg'],
          price: 59.99,
          priceAfterDiscount: 54.99,
          discount: 10,
          quantity: 30,
          categoryId: '2',
          occasionId: '202',
        ),
        ProductEntity(
          id: '103',
          title: 'Sunflower Delight',
          description: 'Bright and cheerful sunflowers to brighten any day',
          imageCover: 'https://example.com/sunflowers.jpg',
          images: [
            'https://example.com/sunflowers-1.jpg',
            'https://example.com/sunflowers-2.jpg',
            'https://example.com/sunflowers-3.jpg',
          ],
          price: 35.99,
          priceAfterDiscount: 29.99,
          discount: 15,
          quantity: 75,
          categoryId: '3',
          occasionId: '203',
        ),
      ],
      occasions: [
        OccasionEntity(
          id: '201',
          name: 'Birthday',
          slug: 'birthday',
          image: 'https://example.com/birthday.jpg',
          createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          isSuperAdmin: false,
        ),
        OccasionEntity(
          id: '202',
          name: 'Anniversary',
          slug: 'anniversary',
          image: 'https://example.com/anniversary.jpg',
          createdAt: DateTime.parse('2024-01-02T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-02T00:00:00.000Z'),
          isSuperAdmin: false,
        ),
        OccasionEntity(
          id: '203',
          name: 'Wedding',
          slug: 'wedding',
          image: 'https://example.com/wedding.jpg',
          createdAt: DateTime.parse('2024-01-03T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-03T00:00:00.000Z'),
          isSuperAdmin: false,
        ),
      ],
    );
    test('should return home screen entity when success', () async {
      // Arrange
      when(
        mockDataSource.getHomeScreenData(),
      ).thenAnswer((_) async => BaseResponse.success(homeResponseDto));

      // Act
      final result = await repoImpl.getHomeScreenData();

      // Assert
      expect(result, isA<BaseResponse<HomeResponseEntity>>());
      result.when(
        success: (data) {
          expect(data.message, 'success');
          expect(data.bestSeller.length, homeResponseEntity.bestSeller.length);
          expect(data.categories.length, homeResponseEntity.categories.length);
          expect(data.occasions.length, homeResponseEntity.occasions.length);
        },
        failure: (_) => fail('Expected success but got failure'),
      );

      verify(mockDataSource.getHomeScreenData()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
    test('should return failure when data source throws exception', () async {
      // Arrange
      when(mockDataSource.getHomeScreenData()).thenAnswer(
        (_) async => BaseResponse.failure(ErrorHandler.handle('Network error')),
      );

      // Act
      final result = await repoImpl.getHomeScreenData();

      // Assert
      expect(result, isA<BaseResponse<HomeResponseEntity>>());
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ErrorHandler>());
          expect(error.message, ErrorHandler.handle('Network error').message);
          expect(error.code, ErrorHandler.handle('Network error').code);
        },
      );

      verify(mockDataSource.getHomeScreenData()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
  });
}
