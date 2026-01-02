import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/features/product_details/data/mappers/product_dto_mapper.dart';
import 'package:online_exam_app/features/product_details/data/models/product_dto.dart';

import 'product_dto_mapper_test.mocks.dart';

@GenerateMocks([ProductDto])
void main() {
  group('ProductDtoMapper', () {
    late MockProductDto mockProductDto;
    late DateTime testCreatedAt;
    late DateTime testUpdatedAt;

    setUp(() {
      mockProductDto = MockProductDto();
      testCreatedAt = DateTime(2024, 1, 1, 12, 0, 0);
      testUpdatedAt = DateTime(2024, 1, 2, 12, 0, 0);
    });

    test('should map ProductDto to ProductModel with all fields correctly', () {
      // Arrange
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
      final result = mockProductDto.toDomain();

      // Assert
      expect(result.id, '1');
      expect(result.title, 'Test Product');
      expect(result.slug, 'test-product');
      expect(result.description, 'A test product description');
      expect(result.imgCover, 'https://example.com/cover.jpg');
      expect(result.images.length, 2);
      expect(result.images[0], 'https://example.com/image1.jpg');
      expect(result.images[1], 'https://example.com/image2.jpg');
      expect(result.price, 100.0);
      expect(result.priceAfterDiscount, 80.0);
      expect(result.quantity, 50);
      expect(result.category, 'Electronics');
      expect(result.occasion, 'Birthday');
      expect(result.createdAt, testCreatedAt);
      expect(result.updatedAt, testUpdatedAt);
      expect(result.sold, 10);
      expect(result.rateAvg, 4.5);
      expect(result.rateCount, 100);
      expect(result.isInWishlist, false);
      expect(result.favoriteId, null);
    });

    test('should map ProductDto with favoriteId to ProductModel', () {
      // Arrange
      when(mockProductDto.id).thenReturn('2');
      when(mockProductDto.title).thenReturn('Favorite Product');
      when(mockProductDto.slug).thenReturn('favorite-product');
      when(mockProductDto.description).thenReturn('A favorite product');
      when(mockProductDto.imgCover).thenReturn('https://example.com/cover.jpg');
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
      final result = mockProductDto.toDomain();

      // Assert
      expect(result.favoriteId, 'fav123');
      expect(result.isInWishlist, true);
      expect(result.id, '2');
      expect(result.title, 'Favorite Product');
    });

    test('should map ProductDto with empty images list to ProductModel', () {
      // Arrange
      when(mockProductDto.id).thenReturn('3');
      when(mockProductDto.title).thenReturn('No Images Product');
      when(mockProductDto.slug).thenReturn('no-images-product');
      when(mockProductDto.description).thenReturn('A product without images');
      when(mockProductDto.imgCover).thenReturn('https://example.com/cover.jpg');
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
      final result = mockProductDto.toDomain();

      // Assert
      expect(result.images, isEmpty);
      expect(result.images.length, 0);
    });

    test('should map ProductDto with zero values to ProductModel', () {
      // Arrange
      when(mockProductDto.id).thenReturn('4');
      when(mockProductDto.title).thenReturn('Zero Values Product');
      when(mockProductDto.slug).thenReturn('zero-values-product');
      when(mockProductDto.description).thenReturn('A product with zero values');
      when(mockProductDto.imgCover).thenReturn('https://example.com/cover.jpg');
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
      final result = mockProductDto.toDomain();

      // Assert
      expect(result.price, 0.0);
      expect(result.priceAfterDiscount, 0.0);
      expect(result.quantity, 0);
      expect(result.sold, 0);
      expect(result.rateAvg, 0.0);
      expect(result.rateCount, 0);
    });

    test('should map ProductDto with negative sold value to ProductModel', () {
      // Arrange
      when(mockProductDto.id).thenReturn('5');
      when(mockProductDto.title).thenReturn('Negative Sold Product');
      when(mockProductDto.slug).thenReturn('negative-sold-product');
      when(
        mockProductDto.description,
      ).thenReturn('A product with negative sold');
      when(mockProductDto.imgCover).thenReturn('https://example.com/cover.jpg');
      when(mockProductDto.images).thenReturn([]);
      when(mockProductDto.price).thenReturn(100.0);
      when(mockProductDto.priceAfterDiscount).thenReturn(80.0);
      when(mockProductDto.quantity).thenReturn(50);
      when(mockProductDto.category).thenReturn('Test');
      when(mockProductDto.occasion).thenReturn('Test');
      when(mockProductDto.createdAt).thenReturn(testCreatedAt);
      when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductDto.sold).thenReturn(-5);
      when(mockProductDto.rateAvg).thenReturn(4.0);
      when(mockProductDto.rateCount).thenReturn(10);
      when(mockProductDto.isInWishlist).thenReturn(false);
      when(mockProductDto.favoriteId).thenReturn(null);

      // Act
      final result = mockProductDto.toDomain();

      // Assert
      expect(result.sold, -5);
    });

    test(
      'should map ProductDto with maximum rating values to ProductModel',
      () {
        // Arrange
        when(mockProductDto.id).thenReturn('6');
        when(mockProductDto.title).thenReturn('Max Rating Product');
        when(mockProductDto.slug).thenReturn('max-rating-product');
        when(
          mockProductDto.description,
        ).thenReturn('A product with max rating');
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
        when(mockProductDto.sold).thenReturn(100);
        when(mockProductDto.rateAvg).thenReturn(5.0);
        when(mockProductDto.rateCount).thenReturn(1000);
        when(mockProductDto.isInWishlist).thenReturn(true);
        when(mockProductDto.favoriteId).thenReturn('fav999');

        // Act
        final result = mockProductDto.toDomain();

        // Assert
        expect(result.rateAvg, 5.0);
        expect(result.rateCount, 1000);
      },
    );

    test('should map ProductDto with special characters to ProductModel', () {
      // Arrange
      when(mockProductDto.id).thenReturn('7');
      when(
        mockProductDto.title,
      ).thenReturn('Product with émojis 🎉 & spëcial çhars');
      when(mockProductDto.slug).thenReturn('special-chars-product');
      when(
        mockProductDto.description,
      ).thenReturn('Description with <html> tags & special chars: @#\$%');
      when(mockProductDto.imgCover).thenReturn('https://example.com/cover.jpg');
      when(mockProductDto.images).thenReturn([]);
      when(mockProductDto.price).thenReturn(100.0);
      when(mockProductDto.priceAfterDiscount).thenReturn(80.0);
      when(mockProductDto.quantity).thenReturn(50);
      when(mockProductDto.category).thenReturn('Test & More');
      when(mockProductDto.occasion).thenReturn('Birthday 🎂');
      when(mockProductDto.createdAt).thenReturn(testCreatedAt);
      when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductDto.sold).thenReturn(10);
      when(mockProductDto.rateAvg).thenReturn(4.0);
      when(mockProductDto.rateCount).thenReturn(10);
      when(mockProductDto.isInWishlist).thenReturn(false);
      when(mockProductDto.favoriteId).thenReturn(null);

      // Act
      final result = mockProductDto.toDomain();

      // Assert
      expect(result.title, contains('émojis'));
      expect(result.description, contains('<html>'));
      expect(result.occasion, contains('🎂'));
    });

    test('should map ProductDto with multiple images to ProductModel', () {
      // Arrange
      final manyImages = List.generate(
        10,
        (index) => 'https://example.com/image$index.jpg',
      );
      when(mockProductDto.id).thenReturn('8');
      when(mockProductDto.title).thenReturn('Many Images Product');
      when(mockProductDto.slug).thenReturn('many-images-product');
      when(mockProductDto.description).thenReturn('A product with many images');
      when(mockProductDto.imgCover).thenReturn('https://example.com/cover.jpg');
      when(mockProductDto.images).thenReturn(manyImages);
      when(mockProductDto.price).thenReturn(100.0);
      when(mockProductDto.priceAfterDiscount).thenReturn(80.0);
      when(mockProductDto.quantity).thenReturn(50);
      when(mockProductDto.category).thenReturn('Test');
      when(mockProductDto.occasion).thenReturn('Test');
      when(mockProductDto.createdAt).thenReturn(testCreatedAt);
      when(mockProductDto.updatedAt).thenReturn(testUpdatedAt);
      when(mockProductDto.sold).thenReturn(10);
      when(mockProductDto.rateAvg).thenReturn(4.0);
      when(mockProductDto.rateCount).thenReturn(10);
      when(mockProductDto.isInWishlist).thenReturn(false);
      when(mockProductDto.favoriteId).thenReturn(null);

      // Act
      final result = mockProductDto.toDomain();

      // Assert
      expect(result.images.length, 10);
      expect(result.images.first, 'https://example.com/image0.jpg');
      expect(result.images.last, 'https://example.com/image9.jpg');
    });

    test('should preserve data types during mapping', () {
      // Arrange
      when(mockProductDto.id).thenReturn('9');
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
      final result = mockProductDto.toDomain();

      // Assert
      expect(result.id, isA<String>());
      expect(result.title, isA<String>());
      expect(result.price, isA<double>());
      expect(result.quantity, isA<int>());
      expect(result.createdAt, isA<DateTime>());
      expect(result.images, isA<List<String>>());
      expect(result.isInWishlist, isA<bool>());
    });
  });
}
