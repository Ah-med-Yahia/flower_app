import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/products/product_details/api/api_clinet/product_details_api_client.dart';
import 'package:flower_app/features/products/product_details/api/data_sources/remote/product_details_data_source_impl.dart';
import 'package:flower_app/features/products/product_details/data/models/product_dto.dart';
import 'package:flower_app/features/products/product_details/data/models/product_response_dto.dart';

import 'product_details_data_source_impl_test.mocks.dart';

@GenerateMocks([ProductDetailsApiClient])
void main() {
  late ProductDetailsDataSourceImpl dataSource;
  late MockProductDetailsApiClient mockApiClient;

  late DateTime testCreatedAt;
  late DateTime testUpdatedAt;

  setUp(() {
    testCreatedAt = DateTime(2024, 1, 1);
    testUpdatedAt = DateTime(2024, 1, 2);

    mockApiClient = MockProductDetailsApiClient();
    dataSource = ProductDetailsDataSourceImpl(mockApiClient);
  });
  group('ProductDetailsDataSourceImpl', () {
    test(
      'should return success BaseResponse when api client returns ProductResponseDto',
      () async {
        // Arrange
        const productId = '123';

        final productResponseDto = ProductResponseDto(
          message: 'Success',
          product: ProductDto(
            id: productId,
            title: 'Test Product',
            slug: 'test-product',
            description: 'Test description',
            imgCover: 'https://example.com/cover.jpg',
            images: ['https://example.com/image.jpg'],
            price: 100.0,
            priceAfterDiscount: 80.0,
            quantity: 10,
            category: 'Electronics',
            occasion: 'Birthday',
            createdAt: testCreatedAt,
            updatedAt: testUpdatedAt,
            sold: 5,
            rateAvg: 4.5,
            rateCount: 20,
            isInWishlist: false,
            favoriteId: null,
            v: 1,
            isSuperAdmin: false,
          ),
        );

        when(
          mockApiClient.getProductDetails(productId),
        ).thenAnswer((_) async => productResponseDto);

        // Act
        final result = await dataSource.getProductDetails(productId);

        // Assert
        expect(result, isA<BaseResponse<ProductResponseDto>>());

        result.when(
          success: (data) {
            expect(data.message, 'Success');
            expect(data.product.id, productId);
            expect(data.product.title, 'Test Product');
          },
          failure: (_) => fail('Expected success but got failure'),
        );

        verify(mockApiClient.getProductDetails(productId)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return failure BaseResponse when api client throws exception',
      () async {
        // Arrange
        const productId = '456';

        when(
          mockApiClient.getProductDetails(productId),
        ).thenThrow(Exception('Network error'));

        // Act
        final result = await dataSource.getProductDetails(productId);

        // Assert
        expect(result, isA<BaseResponse<ProductResponseDto>>());

        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error, isA<ErrorHandler>());
            expect(error.message, ErrorHandler.handle('Network error').message);
            expect(error.code, ErrorHandler.handle('Network error').code);
          },
        );

        verify(mockApiClient.getProductDetails(productId)).called(1);
      },
    );

    test('should call api client with correct product id', () async {
      // Arrange
      const productId = '789';

      final productResponseDto = ProductResponseDto(
        message: 'Success',
        product: ProductDto(
          id: productId,
          title: 'Another Product',
          slug: 'another-product',
          description: 'Another description',
          imgCover: 'img',
          images: [],
          price: 50.0,
          priceAfterDiscount: 40.0,
          quantity: 5,
          category: 'Test',
          occasion: 'Test',
          createdAt: testCreatedAt,
          updatedAt: testUpdatedAt,
          sold: 0,
          rateAvg: 0.0,
          rateCount: 0,
          isInWishlist: false,
          favoriteId: null,
          v: 1,
          isSuperAdmin: false,
        ),
      );

      when(
        mockApiClient.getProductDetails(productId),
      ).thenAnswer((_) async => productResponseDto);

      // Act
      await dataSource.getProductDetails(productId);

      // Assert
      verify(mockApiClient.getProductDetails(productId)).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
