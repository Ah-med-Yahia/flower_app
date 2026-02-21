import 'package:flower_app/core/shared/data/models/get_products_models/product_model.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/features/products/product_details/data/mappers/product_response_dto_mapper.dart';
import 'package:flower_app/features/products/product_details/data/models/product_response_dto.dart';

import 'product_response_dto_mapper_test.mocks.dart';

@GenerateMocks([ProductResponseDto, ProductModel])
void main() {
  group('ProductResponseModelMapper', () {
    late MockProductResponseDto mockProductResponseModel;
    late MockProductModel mockProductModel;
    late DateTime testCreatedAt;
    late DateTime testUpdatedAt;

    setUp(() {
      mockProductResponseModel = MockProductResponseDto();
      mockProductModel = MockProductModel();
      testCreatedAt = DateTime(2024, 1, 1, 12, 0, 0);
      testUpdatedAt = DateTime(2024, 1, 2, 12, 0, 0);
    });

    test(
      'should map ProductResponseModel to ProductResponseEntity correctly',
      () {
        // Arrange
        when(mockProductResponseModel.message).thenReturn('Success');
        when(mockProductResponseModel.product).thenReturn(mockProductModel);

        when(mockProductModel.id).thenReturn('1');
        when(mockProductModel.title).thenReturn('Test Product');
        when(mockProductModel.slug).thenReturn('test-product');
        when(
          mockProductModel.description,
        ).thenReturn('A test product description');
        when(
          mockProductModel.imgCover,
        ).thenReturn('https://example.com/cover.jpg');
        when(mockProductModel.images).thenReturn([
          'https://example.com/image1.jpg',
          'https://example.com/image2.jpg',
        ]);
        when(mockProductModel.price).thenReturn(100.0);
        when(mockProductModel.priceAfterDiscount).thenReturn(80.0);
        when(mockProductModel.quantity).thenReturn(50);
        when(mockProductModel.category).thenReturn('Electronics');
        when(mockProductModel.occasion).thenReturn('Birthday');
        when(mockProductModel.createdAt).thenReturn(testCreatedAt);
        when(mockProductModel.updatedAt).thenReturn(testUpdatedAt);
        when(mockProductModel.sold).thenReturn(10);
        when(mockProductModel.rateAvg).thenReturn(4.5);
        when(mockProductModel.rateCount).thenReturn(100);
        when(mockProductModel.isInWishlist).thenReturn(false);
        when(mockProductModel.favoriteId).thenReturn(null);
        when(mockProductModel.discount).thenReturn(20);

        // Act
        final result = mockProductResponseModel.toDomain();

        // Assert
        expect(result.message, 'Success');
        expect(result.product, isA<ProductEntity>());
        expect(result.product.id, '1');
        expect(result.product.title, 'Test Product');
        expect(result.product.description, 'A test product description');
        expect(result.product.imageCover, 'https://example.com/cover.jpg');
        expect(result.product.images?.length, 2);
        expect(result.product.price, 100.0);
        expect(result.product.priceAfterDiscount, 80.0);
        expect(result.product.quantity, 50);
        expect(result.product.categoryId, 'Electronics');
        expect(result.product.occasionId, 'Birthday');
      },
    );

    test('should map ProductResponseModel with empty message', () {
      // Arrange
      when(mockProductResponseModel.message).thenReturn('');
      when(mockProductResponseModel.product).thenReturn(mockProductModel);

      when(mockProductModel.id).thenReturn('2');
      when(mockProductModel.title).thenReturn('Test Product');
      when(mockProductModel.slug).thenReturn('test-product');
      when(mockProductModel.description).thenReturn('Description');
      when(
        mockProductModel.imgCover,
      ).thenReturn('https://example.com/cover.jpg');
      when(mockProductModel.images).thenReturn([]);
      when(mockProductModel.price).thenReturn(100.0);
      when(mockProductModel.priceAfterDiscount).thenReturn(80.0);
      when(mockProductModel.discount).thenReturn(20);
      when(mockProductModel.quantity).thenReturn(50);
      when(mockProductModel.category).thenReturn('Test');
      when(mockProductModel.occasion).thenReturn('Test');
      when(mockProductModel.createdAt).thenReturn(testCreatedAt);
      when(mockProductModel.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductModel.sold).thenReturn(0);
      when(mockProductModel.rateAvg).thenReturn(0.0);
      when(mockProductModel.rateCount).thenReturn(0);
      when(mockProductModel.isInWishlist).thenReturn(false);
      when(mockProductModel.favoriteId).thenReturn(null);

      // Act
      final result = mockProductResponseModel.toDomain();

      // Assert
      expect(result.message, '');
      expect(result.message.isEmpty, true);
      expect(result.product, isA<ProductEntity>());
    });

    test('should map ProductResponseModel with long message', () {
      // Arrange
      final longMessage = 'A' * 1000;
      when(mockProductResponseModel.message).thenReturn(longMessage);
      when(mockProductResponseModel.product).thenReturn(mockProductModel);

      when(mockProductModel.id).thenReturn('3');
      when(mockProductModel.title).thenReturn('Test Product');
      when(mockProductModel.slug).thenReturn('test-product');
      when(mockProductModel.description).thenReturn('Description');
      when(
        mockProductModel.imgCover,
      ).thenReturn('https://example.com/cover.jpg');
      when(mockProductModel.images).thenReturn([]);
      when(mockProductModel.price).thenReturn(100.0);
      when(mockProductModel.priceAfterDiscount).thenReturn(80.0);
      when(mockProductModel.discount).thenReturn(20);
      when(mockProductModel.quantity).thenReturn(50);
      when(mockProductModel.category).thenReturn('Test');
      when(mockProductModel.occasion).thenReturn('Test');
      when(mockProductModel.createdAt).thenReturn(testCreatedAt);
      when(mockProductModel.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductModel.sold).thenReturn(0);
      when(mockProductModel.rateAvg).thenReturn(0.0);
      when(mockProductModel.rateCount).thenReturn(0);
      when(mockProductModel.isInWishlist).thenReturn(false);
      when(mockProductModel.favoriteId).thenReturn(null);

      // Act
      final result = mockProductResponseModel.toDomain();

      // Assert
      expect(result.message.length, 1000);
      expect(result.product, isA<ProductEntity>());
    });

    test(
      'should map ProductResponseModel with special characters in message',
      () {
        // Arrange
        when(
          mockProductResponseModel.message,
        ).thenReturn('Success! 🎉 Retrieved with émojis & spëcial çhars @#\$%');
        when(mockProductResponseModel.product).thenReturn(mockProductModel);

        when(mockProductModel.id).thenReturn('4');
        when(mockProductModel.title).thenReturn('Test Product');
        when(mockProductModel.slug).thenReturn('test-product');
        when(mockProductModel.description).thenReturn('Description');
        when(
          mockProductModel.imgCover,
        ).thenReturn('https://example.com/cover.jpg');
        when(mockProductModel.images).thenReturn([]);
        when(mockProductModel.price).thenReturn(100.0);
        when(mockProductModel.priceAfterDiscount).thenReturn(80.0);
        when(mockProductModel.discount).thenReturn(20);
        when(mockProductModel.quantity).thenReturn(50);
        when(mockProductModel.category).thenReturn('Test');
        when(mockProductModel.occasion).thenReturn('Test');
        when(mockProductModel.createdAt).thenReturn(testCreatedAt);
        when(mockProductModel.updatedAt).thenReturn(testUpdatedAt);
        when(mockProductModel.sold).thenReturn(0);
        when(mockProductModel.rateAvg).thenReturn(0.0);
        when(mockProductModel.rateCount).thenReturn(0);
        when(mockProductModel.isInWishlist).thenReturn(false);
        when(mockProductModel.favoriteId).thenReturn(null);

        // Act
        final result = mockProductResponseModel.toDomain();

        // Assert
        expect(result.message, contains('🎉'));
        expect(result.message, contains('émojis'));
        expect(result.message, contains('@#\$%'));
        expect(result.product, isA<ProductEntity>());
      },
    );
    test(
      'should map ProductResponseModel with product containing zero values',
      () {
        // Arrange
        when(
          mockProductResponseModel.message,
        ).thenReturn('Product with zero values retrieved');
        when(mockProductResponseModel.product).thenReturn(mockProductModel);

        when(mockProductModel.id).thenReturn('6');
        when(mockProductModel.title).thenReturn('Zero Values Product');
        when(mockProductModel.slug).thenReturn('zero-values-product');
        when(
          mockProductModel.description,
        ).thenReturn('A product with zero values');
        when(
          mockProductModel.imgCover,
        ).thenReturn('https://example.com/cover.jpg');
        when(mockProductModel.images).thenReturn([]);
        when(mockProductModel.price).thenReturn(0.0);
        when(mockProductModel.priceAfterDiscount).thenReturn(0.0);
        when(mockProductModel.discount).thenReturn(0);
        when(mockProductModel.quantity).thenReturn(0);
        when(mockProductModel.category).thenReturn('Test');
        when(mockProductModel.occasion).thenReturn('Test');
        when(mockProductModel.createdAt).thenReturn(testCreatedAt);
        when(mockProductModel.updatedAt).thenReturn(testUpdatedAt);
        when(mockProductModel.sold).thenReturn(0);
        when(mockProductModel.rateAvg).thenReturn(0.0);
        when(mockProductModel.rateCount).thenReturn(0);
        when(mockProductModel.isInWishlist).thenReturn(false);
        when(mockProductModel.favoriteId).thenReturn(null);

        // Act
        final result = mockProductResponseModel.toDomain();

        // Assert
        expect(result.message, 'Product with zero values retrieved');
        expect(result.product.price, 0.0);
        expect(result.product.quantity, 0);
      },
    );

    test(
      'should map ProductResponseModel with product containing empty images',
      () {
        // Arrange
        when(
          mockProductResponseModel.message,
        ).thenReturn('Product without images');
        when(mockProductResponseModel.product).thenReturn(mockProductModel);

        when(mockProductModel.id).thenReturn('7');
        when(mockProductModel.title).thenReturn('No Images Product');
        when(mockProductModel.slug).thenReturn('no-images-product');
        when(
          mockProductModel.description,
        ).thenReturn('A product without images');
        when(
          mockProductModel.imgCover,
        ).thenReturn('https://example.com/cover.jpg');
        when(mockProductModel.images).thenReturn([]);
        when(mockProductModel.price).thenReturn(50.0);
        when(mockProductModel.priceAfterDiscount).thenReturn(40.0);
        when(mockProductModel.discount).thenReturn(20);
        when(mockProductModel.quantity).thenReturn(20);
        when(mockProductModel.category).thenReturn('Books');
        when(mockProductModel.occasion).thenReturn('General');
        when(mockProductModel.createdAt).thenReturn(testCreatedAt);
        when(mockProductModel.updatedAt).thenReturn(testUpdatedAt);
        when(mockProductModel.sold).thenReturn(0);
        when(mockProductModel.rateAvg).thenReturn(0.0);
        when(mockProductModel.rateCount).thenReturn(0);
        when(mockProductModel.isInWishlist).thenReturn(false);
        when(mockProductModel.favoriteId).thenReturn(null);

        // Act
        final result = mockProductResponseModel.toDomain();

        // Assert
        expect(result.message, 'Product without images');
        expect(result.product.images, isEmpty);
        expect(result.product.images?.length, 0);
      },
    );

    test('should map ProductResponseModel with multilingual message', () {
      // Arrange
      when(
        mockProductResponseModel.message,
      ).thenReturn('تم استرجاع المنتج بنجاح');
      when(mockProductResponseModel.product).thenReturn(mockProductModel);

      when(mockProductModel.id).thenReturn('8');
      when(mockProductModel.title).thenReturn('Test Product');
      when(mockProductModel.slug).thenReturn('test-product');
      when(mockProductModel.description).thenReturn('Description');
      when(
        mockProductModel.imgCover,
      ).thenReturn('https://example.com/cover.jpg');
      when(mockProductModel.images).thenReturn([]);
      when(mockProductModel.price).thenReturn(100.0);
      when(mockProductModel.priceAfterDiscount).thenReturn(80.0);
      when(mockProductModel.discount).thenReturn(20);
      when(mockProductModel.quantity).thenReturn(50);
      when(mockProductModel.category).thenReturn('Test');
      when(mockProductModel.occasion).thenReturn('Test');
      when(mockProductModel.createdAt).thenReturn(testCreatedAt);
      when(mockProductModel.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductModel.sold).thenReturn(0);
      when(mockProductModel.rateAvg).thenReturn(0.0);
      when(mockProductModel.rateCount).thenReturn(0);
      when(mockProductModel.isInWishlist).thenReturn(false);
      when(mockProductModel.favoriteId).thenReturn(null);

      // Act
      final result = mockProductResponseModel.toDomain();

      // Assert
      expect(result.message, 'تم استرجاع المنتج بنجاح');
      expect(result.product, isA<ProductEntity>());
    });

    test('should properly call toDomain on nested ProductModel', () {
      // Arrange
      when(mockProductResponseModel.message).thenReturn('Success');
      when(mockProductResponseModel.product).thenReturn(mockProductModel);

      when(mockProductModel.id).thenReturn('9');
      when(mockProductModel.title).thenReturn('Test Product');
      when(mockProductModel.slug).thenReturn('test-product');
      when(mockProductModel.description).thenReturn('Description');
      when(
        mockProductModel.imgCover,
      ).thenReturn('https://example.com/cover.jpg');
      when(mockProductModel.images).thenReturn([]);
      when(mockProductModel.price).thenReturn(100.0);
      when(mockProductModel.priceAfterDiscount).thenReturn(80.0);
      when(mockProductModel.discount).thenReturn(20);
      when(mockProductModel.quantity).thenReturn(50);
      when(mockProductModel.category).thenReturn('Test');
      when(mockProductModel.occasion).thenReturn('Test');
      when(mockProductModel.createdAt).thenReturn(testCreatedAt);
      when(mockProductModel.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductModel.sold).thenReturn(0);
      when(mockProductModel.rateAvg).thenReturn(0.0);
      when(mockProductModel.rateCount).thenReturn(0);
      when(mockProductModel.isInWishlist).thenReturn(false);
      when(mockProductModel.favoriteId).thenReturn(null);

      // Act
      final result = mockProductResponseModel.toDomain();

      // Assert
      verify(mockProductResponseModel.product).called(1);
      expect(result.product, isA<ProductEntity>());
    });

    test('should preserve data types during mapping', () {
      // Arrange
      when(mockProductResponseModel.message).thenReturn('Type Test');
      when(mockProductResponseModel.product).thenReturn(mockProductModel);

      when(mockProductModel.id).thenReturn('10');
      when(mockProductModel.title).thenReturn('Type Test Product');
      when(mockProductModel.slug).thenReturn('type-test-product');
      when(mockProductModel.description).thenReturn('Testing data types');
      when(
        mockProductModel.imgCover,
      ).thenReturn('https://example.com/cover.jpg');
      when(
        mockProductModel.images,
      ).thenReturn(['https://example.com/image1.jpg']);
      when(mockProductModel.price).thenReturn(99.99);
      when(mockProductModel.priceAfterDiscount).thenReturn(79.99);
      when(mockProductModel.discount).thenReturn(20);
      when(mockProductModel.quantity).thenReturn(25);
      when(mockProductModel.category).thenReturn('Electronics');
      when(mockProductModel.occasion).thenReturn('General');
      when(mockProductModel.createdAt).thenReturn(testCreatedAt);
      when(mockProductModel.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductModel.sold).thenReturn(15);
      when(mockProductModel.rateAvg).thenReturn(4.7);
      when(mockProductModel.rateCount).thenReturn(85);
      when(mockProductModel.isInWishlist).thenReturn(true);
      when(mockProductModel.favoriteId).thenReturn('fav456');

      // Act
      final result = mockProductResponseModel.toDomain();

      // Assert
      expect(result.message, isA<String>());
      expect(result.product, isA<ProductEntity>());
      expect(result.product.price, isA<double>());
      expect(result.product.quantity, isA<int>());
    });
  });
}
