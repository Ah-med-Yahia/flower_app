import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/features/product_details/data/mappers/product_response_dto_mapper.dart';
import 'package:online_exam_app/features/product_details/data/models/product_dto.dart';
import 'package:online_exam_app/features/product_details/data/models/product_response_dto.dart';
import 'package:online_exam_app/features/product_details/domain/models/product_model.dart';

import 'product_response_dto_mapper_test.mocks.dart';

@GenerateMocks([ProductResponseDto, ProductDto])
void main() {
  group('ProductResponseDtoMapper', () {
    late MockProductResponseDto mockProductResponseDto;
    late MockProductDto mockProductDto;
    late DateTime testCreatedAt;
    late DateTime testUpdatedAt;

    setUp(() {
      mockProductResponseDto = MockProductResponseDto();
      mockProductDto = MockProductDto();
      testCreatedAt = DateTime(2024, 1, 1, 12, 0, 0);
      testUpdatedAt = DateTime(2024, 1, 2, 12, 0, 0);
    });

    test('should map ProductResponseDto to ProductResponseModel correctly', () {
      // Arrange
      when(mockProductResponseDto.message).thenReturn('Success');
      when(mockProductResponseDto.product).thenReturn(mockProductDto);

      when(mockProductDto.id).thenReturn('1');
      when(mockProductDto.title).thenReturn('Test Product');
      when(mockProductDto.slug).thenReturn('test-product');
      when(mockProductDto.description).thenReturn('A test product description');
      when(mockProductDto.imgCover).thenReturn('https://example.com/cover.jpg');
      when(mockProductDto.images).thenReturn([
        'https://example.com/image1.jpg',
        'https://example.com/image2.jpg',
      ]);
      when(mockProductDto.price).thenReturn(100.0);
      when(mockProductDto.priceAfterDiscount).thenReturn(80.0);
      when(mockProductDto.quantity).thenReturn(50);
      when(mockProductDto.category).thenReturn('Electronics');
      when(mockProductDto.occasion).thenReturn('Birthday');
      when(mockProductDto.createdAt).thenReturn(testCreatedAt);
      when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductDto.sold).thenReturn(10);
      when(mockProductDto.rateAvg).thenReturn(4.5);
      when(mockProductDto.rateCount).thenReturn(100);
      when(mockProductDto.isInWishlist).thenReturn(false);
      when(mockProductDto.favoriteId).thenReturn(null);

      // Act
      final result = mockProductResponseDto.toDomain();

      // Assert
      expect(result.message, 'Success');
      expect(result.product, isA<ProductModel>());
      expect(result.product.id, '1');
      expect(result.product.title, 'Test Product');
      expect(result.product.slug, 'test-product');
      expect(result.product.description, 'A test product description');
      expect(result.product.imgCover, 'https://example.com/cover.jpg');
      expect(result.product.images.length, 2);
      expect(result.product.price, 100.0);
      expect(result.product.priceAfterDiscount, 80.0);
      expect(result.product.quantity, 50);
      expect(result.product.category, 'Electronics');
      expect(result.product.occasion, 'Birthday');
      expect(result.product.createdAt, testCreatedAt);
      expect(result.product.updatedAt, testUpdatedAt);
      expect(result.product.sold, 10);
      expect(result.product.rateAvg, 4.5);
      expect(result.product.rateCount, 100);
      expect(result.product.isInWishlist, false);
      expect(result.product.favoriteId, null);
    });

    test('should map ProductResponseDto with empty message', () {
      // Arrange
      when(mockProductResponseDto.message).thenReturn('');
      when(mockProductResponseDto.product).thenReturn(mockProductDto);

      when(mockProductDto.id).thenReturn('2');
      when(mockProductDto.title).thenReturn('Test Product');
      when(mockProductDto.slug).thenReturn('test-product');
      when(mockProductDto.description).thenReturn('Description');
      when(mockProductDto.imgCover).thenReturn('https://example.com/cover.jpg');
      when(mockProductDto.images).thenReturn([]);
      when(mockProductDto.price).thenReturn(100.0);
      when(mockProductDto.priceAfterDiscount).thenReturn(80.0);
      when(mockProductDto.quantity).thenReturn(50);
      when(mockProductDto.category).thenReturn('Test');
      when(mockProductDto.occasion).thenReturn('Test');
      when(mockProductDto.createdAt).thenReturn(testCreatedAt);
      when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductDto.sold).thenReturn(0);
      when(mockProductDto.rateAvg).thenReturn(0.0);
      when(mockProductDto.rateCount).thenReturn(0);
      when(mockProductDto.isInWishlist).thenReturn(false);
      when(mockProductDto.favoriteId).thenReturn(null);

      // Act
      final result = mockProductResponseDto.toDomain();

      // Assert
      expect(result.message, '');
      expect(result.message.isEmpty, true);
      expect(result.product, isA<ProductModel>());
    });

    test('should map ProductResponseDto with long message', () {
      // Arrange
      final longMessage = 'A' * 1000;
      when(mockProductResponseDto.message).thenReturn(longMessage);
      when(mockProductResponseDto.product).thenReturn(mockProductDto);

      when(mockProductDto.id).thenReturn('3');
      when(mockProductDto.title).thenReturn('Test Product');
      when(mockProductDto.slug).thenReturn('test-product');
      when(mockProductDto.description).thenReturn('Description');
      when(mockProductDto.imgCover).thenReturn('https://example.com/cover.jpg');
      when(mockProductDto.images).thenReturn([]);
      when(mockProductDto.price).thenReturn(100.0);
      when(mockProductDto.priceAfterDiscount).thenReturn(80.0);
      when(mockProductDto.quantity).thenReturn(50);
      when(mockProductDto.category).thenReturn('Test');
      when(mockProductDto.occasion).thenReturn('Test');
      when(mockProductDto.createdAt).thenReturn(testCreatedAt);
      when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductDto.sold).thenReturn(0);
      when(mockProductDto.rateAvg).thenReturn(0.0);
      when(mockProductDto.rateCount).thenReturn(0);
      when(mockProductDto.isInWishlist).thenReturn(false);
      when(mockProductDto.favoriteId).thenReturn(null);

      // Act
      final result = mockProductResponseDto.toDomain();

      // Assert
      expect(result.message.length, 1000);
      expect(result.product, isA<ProductModel>());
    });

    test(
      'should map ProductResponseDto with special characters in message',
      () {
        // Arrange
        when(
          mockProductResponseDto.message,
        ).thenReturn('Success! 🎉 Retrieved with émojis & spëcial çhars @#\$%');
        when(mockProductResponseDto.product).thenReturn(mockProductDto);

        when(mockProductDto.id).thenReturn('4');
        when(mockProductDto.title).thenReturn('Test Product');
        when(mockProductDto.slug).thenReturn('test-product');
        when(mockProductDto.description).thenReturn('Description');
        when(
          mockProductDto.imgCover,
        ).thenReturn('https://example.com/cover.jpg');
        when(mockProductDto.images).thenReturn([]);
        when(mockProductDto.price).thenReturn(100.0);
        when(mockProductDto.priceAfterDiscount).thenReturn(80.0);
        when(mockProductDto.quantity).thenReturn(50);
        when(mockProductDto.category).thenReturn('Test');
        when(mockProductDto.occasion).thenReturn('Test');
        when(mockProductDto.createdAt).thenReturn(testCreatedAt);
        when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
        when(mockProductDto.sold).thenReturn(0);
        when(mockProductDto.rateAvg).thenReturn(0.0);
        when(mockProductDto.rateCount).thenReturn(0);
        when(mockProductDto.isInWishlist).thenReturn(false);
        when(mockProductDto.favoriteId).thenReturn(null);

        // Act
        final result = mockProductResponseDto.toDomain();

        // Assert
        expect(result.message, contains('🎉'));
        expect(result.message, contains('émojis'));
        expect(result.message, contains('@#\$%'));
        expect(result.product, isA<ProductModel>());
      },
    );

    test(
      'should map ProductResponseDto with product containing favoriteId',
      () {
        // Arrange
        when(
          mockProductResponseDto.message,
        ).thenReturn('Product with favorite retrieved');
        when(mockProductResponseDto.product).thenReturn(mockProductDto);

        when(mockProductDto.id).thenReturn('5');
        when(mockProductDto.title).thenReturn('Favorite Product');
        when(mockProductDto.slug).thenReturn('favorite-product');
        when(mockProductDto.description).thenReturn('A favorite product');
        when(
          mockProductDto.imgCover,
        ).thenReturn('https://example.com/cover.jpg');
        when(
          mockProductDto.images,
        ).thenReturn(['https://example.com/image1.jpg']);
        when(mockProductDto.price).thenReturn(150.0);
        when(mockProductDto.priceAfterDiscount).thenReturn(120.0);
        when(mockProductDto.quantity).thenReturn(30);
        when(mockProductDto.category).thenReturn('Fashion');
        when(mockProductDto.occasion).thenReturn('Wedding');
        when(mockProductDto.createdAt).thenReturn(testCreatedAt);
        when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
        when(mockProductDto.sold).thenReturn(5);
        when(mockProductDto.rateAvg).thenReturn(5.0);
        when(mockProductDto.rateCount).thenReturn(50);
        when(mockProductDto.isInWishlist).thenReturn(true);
        when(mockProductDto.favoriteId).thenReturn('fav123');

        // Act
        final result = mockProductResponseDto.toDomain();

        // Assert
        expect(result.message, 'Product with favorite retrieved');
        expect(result.product.isInWishlist, true);
        expect(result.product.favoriteId, 'fav123');
      },
    );

    test(
      'should map ProductResponseDto with product containing zero values',
      () {
        // Arrange
        when(
          mockProductResponseDto.message,
        ).thenReturn('Product with zero values retrieved');
        when(mockProductResponseDto.product).thenReturn(mockProductDto);

        when(mockProductDto.id).thenReturn('6');
        when(mockProductDto.title).thenReturn('Zero Values Product');
        when(mockProductDto.slug).thenReturn('zero-values-product');
        when(
          mockProductDto.description,
        ).thenReturn('A product with zero values');
        when(
          mockProductDto.imgCover,
        ).thenReturn('https://example.com/cover.jpg');
        when(mockProductDto.images).thenReturn([]);
        when(mockProductDto.price).thenReturn(0.0);
        when(mockProductDto.priceAfterDiscount).thenReturn(0.0);
        when(mockProductDto.quantity).thenReturn(0);
        when(mockProductDto.category).thenReturn('Test');
        when(mockProductDto.occasion).thenReturn('Test');
        when(mockProductDto.createdAt).thenReturn(testCreatedAt);
        when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
        when(mockProductDto.sold).thenReturn(0);
        when(mockProductDto.rateAvg).thenReturn(0.0);
        when(mockProductDto.rateCount).thenReturn(0);
        when(mockProductDto.isInWishlist).thenReturn(false);
        when(mockProductDto.favoriteId).thenReturn(null);

        // Act
        final result = mockProductResponseDto.toDomain();

        // Assert
        expect(result.message, 'Product with zero values retrieved');
        expect(result.product.price, 0.0);
        expect(result.product.quantity, 0);
        expect(result.product.sold, 0);
        expect(result.product.rateAvg, 0.0);
      },
    );

    test(
      'should map ProductResponseDto with product containing empty images',
      () {
        // Arrange
        when(
          mockProductResponseDto.message,
        ).thenReturn('Product without images');
        when(mockProductResponseDto.product).thenReturn(mockProductDto);

        when(mockProductDto.id).thenReturn('7');
        when(mockProductDto.title).thenReturn('No Images Product');
        when(mockProductDto.slug).thenReturn('no-images-product');
        when(mockProductDto.description).thenReturn('A product without images');
        when(
          mockProductDto.imgCover,
        ).thenReturn('https://example.com/cover.jpg');
        when(mockProductDto.images).thenReturn([]);
        when(mockProductDto.price).thenReturn(50.0);
        when(mockProductDto.priceAfterDiscount).thenReturn(40.0);
        when(mockProductDto.quantity).thenReturn(20);
        when(mockProductDto.category).thenReturn('Books');
        when(mockProductDto.occasion).thenReturn('General');
        when(mockProductDto.createdAt).thenReturn(testCreatedAt);
        when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
        when(mockProductDto.sold).thenReturn(0);
        when(mockProductDto.rateAvg).thenReturn(0.0);
        when(mockProductDto.rateCount).thenReturn(0);
        when(mockProductDto.isInWishlist).thenReturn(false);
        when(mockProductDto.favoriteId).thenReturn(null);

        // Act
        final result = mockProductResponseDto.toDomain();

        // Assert
        expect(result.message, 'Product without images');
        expect(result.product.images, isEmpty);
        expect(result.product.images.length, 0);
      },
    );

    test('should map ProductResponseDto with multilingual message', () {
      // Arrange
      when(
        mockProductResponseDto.message,
      ).thenReturn('تم استرجاع المنتج بنجاح');
      when(mockProductResponseDto.product).thenReturn(mockProductDto);

      when(mockProductDto.id).thenReturn('8');
      when(mockProductDto.title).thenReturn('Test Product');
      when(mockProductDto.slug).thenReturn('test-product');
      when(mockProductDto.description).thenReturn('Description');
      when(mockProductDto.imgCover).thenReturn('https://example.com/cover.jpg');
      when(mockProductDto.images).thenReturn([]);
      when(mockProductDto.price).thenReturn(100.0);
      when(mockProductDto.priceAfterDiscount).thenReturn(80.0);
      when(mockProductDto.quantity).thenReturn(50);
      when(mockProductDto.category).thenReturn('Test');
      when(mockProductDto.occasion).thenReturn('Test');
      when(mockProductDto.createdAt).thenReturn(testCreatedAt);
      when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductDto.sold).thenReturn(0);
      when(mockProductDto.rateAvg).thenReturn(0.0);
      when(mockProductDto.rateCount).thenReturn(0);
      when(mockProductDto.isInWishlist).thenReturn(false);
      when(mockProductDto.favoriteId).thenReturn(null);

      // Act
      final result = mockProductResponseDto.toDomain();

      // Assert
      expect(result.message, 'تم استرجاع المنتج بنجاح');
      expect(result.product, isA<ProductModel>());
    });

    test('should properly call toDomain on nested ProductDto', () {
      // Arrange
      when(mockProductResponseDto.message).thenReturn('Success');
      when(mockProductResponseDto.product).thenReturn(mockProductDto);

      when(mockProductDto.id).thenReturn('9');
      when(mockProductDto.title).thenReturn('Test Product');
      when(mockProductDto.slug).thenReturn('test-product');
      when(mockProductDto.description).thenReturn('Description');
      when(mockProductDto.imgCover).thenReturn('https://example.com/cover.jpg');
      when(mockProductDto.images).thenReturn([]);
      when(mockProductDto.price).thenReturn(100.0);
      when(mockProductDto.priceAfterDiscount).thenReturn(80.0);
      when(mockProductDto.quantity).thenReturn(50);
      when(mockProductDto.category).thenReturn('Test');
      when(mockProductDto.occasion).thenReturn('Test');
      when(mockProductDto.createdAt).thenReturn(testCreatedAt);
      when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductDto.sold).thenReturn(0);
      when(mockProductDto.rateAvg).thenReturn(0.0);
      when(mockProductDto.rateCount).thenReturn(0);
      when(mockProductDto.isInWishlist).thenReturn(false);
      when(mockProductDto.favoriteId).thenReturn(null);

      // Act
      final result = mockProductResponseDto.toDomain();

      // Assert
      verify(mockProductResponseDto.product).called(1);
      expect(result.product, isA<ProductModel>());
    });

    test('should preserve data types during mapping', () {
      // Arrange
      when(mockProductResponseDto.message).thenReturn('Type Test');
      when(mockProductResponseDto.product).thenReturn(mockProductDto);

      when(mockProductDto.id).thenReturn('10');
      when(mockProductDto.title).thenReturn('Type Test Product');
      when(mockProductDto.slug).thenReturn('type-test-product');
      when(mockProductDto.description).thenReturn('Testing data types');
      when(mockProductDto.imgCover).thenReturn('https://example.com/cover.jpg');
      when(
        mockProductDto.images,
      ).thenReturn(['https://example.com/image1.jpg']);
      when(mockProductDto.price).thenReturn(99.99);
      when(mockProductDto.priceAfterDiscount).thenReturn(79.99);
      when(mockProductDto.quantity).thenReturn(25);
      when(mockProductDto.category).thenReturn('Electronics');
      when(mockProductDto.occasion).thenReturn('General');
      when(mockProductDto.createdAt).thenReturn(testCreatedAt);
      when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductDto.sold).thenReturn(15);
      when(mockProductDto.rateAvg).thenReturn(4.7);
      when(mockProductDto.rateCount).thenReturn(85);
      when(mockProductDto.isInWishlist).thenReturn(true);
      when(mockProductDto.favoriteId).thenReturn('fav456');

      // Act
      final result = mockProductResponseDto.toDomain();

      // Assert
      expect(result.message, isA<String>());
      expect(result.product, isA<ProductModel>());
      expect(result.product.price, isA<double>());
      expect(result.product.quantity, isA<int>());
      expect(result.product.isInWishlist, isA<bool>());
    });
  });
}
