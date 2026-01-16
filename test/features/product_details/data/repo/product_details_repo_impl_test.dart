import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/product_details/api/data_sources/remote/product_details_data_source_impl.dart';
import 'package:flower_app/features/product_details/data/models/product_dto.dart';
import 'package:flower_app/features/product_details/data/models/product_response_dto.dart';
import 'package:flower_app/features/product_details/data/repo/product_details_repo_impl.dart';
import 'package:flower_app/features/product_details/domain/models/product_response_model.dart';

import 'product_details_repo_impl_test.mocks.dart';

@GenerateMocks([ProductDetailsDataSourceImpl, ProductResponseModel])
void main() {
  late ProductDetailsRepoImpl productDetailsRepoImpl;
  late MockProductDetailsDataSourceImpl mockProductDetailsDataSourceImpl;
  late MockProductResponseModel mockProductResponseModel;
  late DateTime testCreatedAt;
  late DateTime testUpdatedAt;
  setUpAll(() {
    testCreatedAt = DateTime(2024, 1, 1, 12, 0, 0);
    testUpdatedAt = DateTime(2024, 1, 2, 12, 0, 0);
    mockProductDetailsDataSourceImpl = MockProductDetailsDataSourceImpl();
    productDetailsRepoImpl = ProductDetailsRepoImpl(
      mockProductDetailsDataSourceImpl,
    );
    mockProductResponseModel = MockProductResponseModel();

    provideDummy<BaseResponse<ProductResponseModel>>(
      BaseResponse.success(mockProductResponseModel),
    );
  });

  group('get product details function Test cases', () {
    test('test success state with ProductResponseModel returned', () async {
      //Arrange
      final productResponseDto = ProductResponseDto(
        message: 'Success',
        product: ProductDto(
          id: '1',
          title: 'Test Product',
          slug: 'test-product',
          description: 'A test product description',
          imgCover: 'https://example.com/cover.jpg',
          images: [
            'https://example.com/image1.jpg',
            'https://example.com/image2.jpg',
          ],
          price: 100.0,
          priceAfterDiscount: 80.0,
          quantity: 50,
          category: 'Electronics',
          occasion: 'Birthday',
          createdAt: testCreatedAt,
          updatedAt: testUpdatedAt,
          sold: 10,
          rateAvg: 4.5,
          rateCount: 100,
          isInWishlist: false,
          favoriteId: null,
          v: 1,
          isSuperAdmin: false,
        ),
      );
      when(
        mockProductDetailsDataSourceImpl.getProductDetails('1'),
      ).thenAnswer((_) async => BaseResponse.success(productResponseDto));
      // Act
      final result = await productDetailsRepoImpl.getProductDetails('1');

      // Assert
      expect(result, isA<BaseResponse<ProductResponseModel>>());

      result.when(
        success: (model) {
          expect(model, isA<ProductResponseModel>());
          expect(model.message, 'Success');
          expect(model.product.id, '1');
          expect(model.product.title, 'Test Product');
          expect(model.product.slug, 'test-product');
          expect(model.product.description, 'A test product description');
          expect(model.product.imgCover, 'https://example.com/cover.jpg');
          expect(model.product.images.length, 2);
          expect(model.product.price, 100.0);
          expect(model.product.priceAfterDiscount, 80.0);
          expect(model.product.quantity, 50);
          expect(model.product.category, 'Electronics');
          expect(model.product.occasion, 'Birthday');
          expect(model.product.createdAt, testCreatedAt);
          expect(model.product.updatedAt, testUpdatedAt);
          expect(model.product.sold, 10);
          expect(model.product.rateAvg, 4.5);
          expect(model.product.rateCount, 100);
          expect(model.product.isInWishlist, false);
          expect(model.product.favoriteId, null);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
      verify(mockProductDetailsDataSourceImpl.getProductDetails('1')).called(1);
    });

    test('test failure state with error returned', () async {
      //Arrange

      when(mockProductDetailsDataSourceImpl.getProductDetails('2')).thenAnswer(
        (_) async => BaseResponse.failure(ErrorHandler.handle('Network error')),
      );

      // Act
      final result = await productDetailsRepoImpl.getProductDetails('2');

      // Assert
      expect(result, isA<BaseResponse<ProductResponseModel>>());

      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error.message, ErrorHandler.handle('Network error').message);
          expect(error.code, ErrorHandler.handle('Network error').code);
          expect(
            error.toString(),
            ErrorHandler.handle('Network error').toString(),
          );
          expect(error.code, ErrorHandler.handle('Network error').code);
          expect(
            error.errorModel.toString(),
            ErrorHandler.handle('Network error').errorModel.toString(),
          );
        },
      );
      verify(mockProductDetailsDataSourceImpl.getProductDetails('2')).called(1);
    });
    test('should call data source with correct product ID', () async {
      // Arrange
      const productId = '456';
      final productResponseDto = ProductResponseDto(
        message: 'Success',
        product: ProductDto(
          id: '456',
          title: 'Test Product',
          slug: 'test-product',
          description: 'Description',
          imgCover: 'https://example.com/cover.jpg',
          images: [],
          price: 100.0,
          priceAfterDiscount: 80.0,
          quantity: 50,
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
        mockProductDetailsDataSourceImpl.getProductDetails(productId),
      ).thenAnswer((_) async => BaseResponse.success(productResponseDto));

      // Act
      await productDetailsRepoImpl.getProductDetails(productId);

      // Assert
      verify(
        mockProductDetailsDataSourceImpl.getProductDetails('456'),
      ).called(1);
      verifyNoMoreInteractions(mockProductDetailsDataSourceImpl);
    });
    test('should handle multiple consecutive calls correctly', () async {
      // Arrange
      const productId1 = '001';
      const productId2 = '002';

      final productResponseDto1 = ProductResponseDto(
        message: 'Success',
        product: ProductDto(
          id: '001',
          title: 'Product 1',
          slug: 'product-1',
          description: 'Description 1',
          imgCover: 'https://example.com/cover.jpg',
          images: [],
          price: 100.0,
          priceAfterDiscount: 80.0,
          quantity: 50,
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

      final productResponseDto2 = ProductResponseDto(
        message: 'Success',
        product: ProductDto(
          id: '002',
          title: 'Product 2',
          slug: 'product-2',
          description: 'Description 2',
          imgCover: 'https://example.com/cover.jpg',
          images: [],
          price: 200.0,
          priceAfterDiscount: 150.0,
          quantity: 30,
          category: 'Test',
          occasion: 'Test',
          createdAt: testCreatedAt,
          updatedAt: testUpdatedAt,
          sold: 5,
          rateAvg: 4.0,
          rateCount: 10,
          isInWishlist: false,
          favoriteId: null,
          v: 1,
          isSuperAdmin: false,
        ),
      );

      when(
        mockProductDetailsDataSourceImpl.getProductDetails(productId1),
      ).thenAnswer((_) async => BaseResponse.success(productResponseDto1));
      when(
        mockProductDetailsDataSourceImpl.getProductDetails(productId2),
      ).thenAnswer((_) async => BaseResponse.success(productResponseDto2));

      // Act
      final result1 = await productDetailsRepoImpl.getProductDetails(
        productId1,
      );
      final result2 = await productDetailsRepoImpl.getProductDetails(
        productId2,
      );

      // Assert
      result1.when(
        success: (model) {
          expect(model.product.id, '001');
          expect(model.product.title, 'Product 1');
        },
        failure: (_) => fail('Expected success but got failure'),
      );

      result2.when(
        success: (model) {
          expect(model.product.id, '002');
          expect(model.product.title, 'Product 2');
        },
        failure: (_) => fail('Expected success but got failure'),
      );

      verify(
        mockProductDetailsDataSourceImpl.getProductDetails(productId1),
      ).called(1);
      verify(
        mockProductDetailsDataSourceImpl.getProductDetails(productId2),
      ).called(1);
    });
    test(
      'should transform DTO to domain model correctly with all fields',
      () async {
        // Arrange
        const productId = '789';
        final productResponseDto = ProductResponseDto(
          message: 'Product retrieved successfully',
          product: ProductDto(
            id: '789',
            title: 'Complex Product',
            slug: 'complex-product',
            description: 'Complex description with émojis 🎉',
            imgCover: 'https://example.com/cover.jpg',
            images: [
              'https://example.com/img1.jpg',
              'https://example.com/img2.jpg',
              'https://example.com/img3.jpg',
            ],
            price: 999.99,
            priceAfterDiscount: 799.99,
            quantity: 100,
            category: 'Electronics',
            occasion: 'Birthday',
            createdAt: testCreatedAt,
            updatedAt: testUpdatedAt,
            sold: 25,
            rateAvg: 4.8,
            rateCount: 200,
            isInWishlist: false,
            favoriteId: null,
            v: 1,
            isSuperAdmin: false,
          ),
        );

        when(
          mockProductDetailsDataSourceImpl.getProductDetails(productId),
        ).thenAnswer((_) async => BaseResponse.success(productResponseDto));

        // Act
        final result = await productDetailsRepoImpl.getProductDetails(
          productId,
        );

        // Assert
        expect(result, isA<BaseResponse<ProductResponseModel>>());
        result.when(
          success: (model) {
            expect(model.message, 'Product retrieved successfully');
            expect(model.product.id, '789');
            expect(model.product.title, 'Complex Product');
            expect(model.product.description, contains('émojis'));
            expect(model.product.images.length, 3);
            expect(model.product.price, 999.99);
            expect(model.product.priceAfterDiscount, 799.99);
            expect(model.product.quantity, 100);
            expect(model.product.sold, 25);
            expect(model.product.rateAvg, 4.8);
            expect(model.product.rateCount, 200);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(
          mockProductDetailsDataSourceImpl.getProductDetails(productId),
        ).called(1);
      },
    );
  });
}
