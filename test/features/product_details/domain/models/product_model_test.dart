import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/features/product_details/domain/models/product_model.dart';

void main() {
  group('ProductModel', () {
    late ProductModel testProduct;
    late DateTime testCreatedAt;
    late DateTime testUpdatedAt;

    setUp(() {
      testCreatedAt = DateTime(2024, 1, 1, 12, 0, 0);
      testUpdatedAt = DateTime(2024, 1, 2, 12, 0, 0);

      testProduct = ProductModel(
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
      );
    });

    test('should create a valid ProductModel with all required fields', () {
      // Arrange
      final result = testProduct;

      // Act

      // Assert
      expect(result.id, '1');
      expect(result.title, 'Test Product');
      expect(result.slug, 'test-product');
      expect(result.description, 'A test product description');
      expect(result.imgCover, 'https://example.com/cover.jpg');
      expect(result.images.length, 2);
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

    test('should create ProductModel with favoriteId when provided', () {
      // Arrange & Act
      final result = ProductModel(
        id: '2',
        title: 'Favorite Product',
        slug: 'favorite-product',
        description: 'A favorite product',
        imgCover: 'https://example.com/cover.jpg',
        images: ['https://example.com/image1.jpg'],
        price: 150.0,
        priceAfterDiscount: 120.0,
        quantity: 30,
        category: 'Fashion',
        occasion: 'Wedding',
        createdAt: testCreatedAt,
        updatedAt: testUpdatedAt,
        sold: 5,
        rateAvg: 5.0,
        rateCount: 50,
        isInWishlist: true,
        favoriteId: 'fav123',
      );

      // Assert
      expect(result.favoriteId, 'fav123');
      expect(result.isInWishlist, true);
    });

    test('should handle empty images list', () {
      // Arrange & Act
      final result = ProductModel(
        id: '3',
        title: 'No Images Product',
        slug: 'no-images-product',
        description: 'A product without images',
        imgCover: 'https://example.com/cover.jpg',
        images: [],
        price: 50.0,
        priceAfterDiscount: 40.0,
        quantity: 20,
        category: 'Books',
        occasion: 'General',
        createdAt: testCreatedAt,
        updatedAt: testUpdatedAt,
        sold: 0,
        rateAvg: 0.0,
        rateCount: 0,
        isInWishlist: false,
      );

      // Assert
      expect(result.images, isEmpty);
      expect(result.images.length, 0);
    });

    test('should handle zero values correctly', () {
      // Arrange & Act
      final result = ProductModel(
        id: '4',
        title: 'Zero Values Product',
        slug: 'zero-values-product',
        description: 'A product with zero values',
        imgCover: 'https://example.com/cover.jpg',
        images: [],
        price: 0.0,
        priceAfterDiscount: 0.0,
        quantity: 0,
        category: 'Test',
        occasion: 'Test',
        createdAt: testCreatedAt,
        updatedAt: testUpdatedAt,
        sold: 0,
        rateAvg: 0.0,
        rateCount: 0,
        isInWishlist: false,
      );

      // Assert
      expect(result.price, 0.0);
      expect(result.priceAfterDiscount, 0.0);
      expect(result.quantity, 0);
      expect(result.sold, 0);
      expect(result.rateAvg, 0.0);
      expect(result.rateCount, 0);
    });

    test('should handle negative sold value', () {
      // Arrange & Act
      final result = ProductModel(
        id: '5',
        title: 'Negative Sold Product',
        slug: 'negative-sold-product',
        description: 'A product with negative sold',
        imgCover: 'https://example.com/cover.jpg',
        images: [],
        price: 100.0,
        priceAfterDiscount: 80.0,
        quantity: 50,
        category: 'Test',
        occasion: 'Test',
        createdAt: testCreatedAt,
        updatedAt: testUpdatedAt,
        sold: -5,
        rateAvg: 4.0,
        rateCount: 10,
        isInWishlist: false,
      );

      // Assert
      expect(result.sold, -5);
    });

    test('should handle maximum rating values', () {
      // Arrange & Act
      final result = ProductModel(
        id: '6',
        title: 'Max Rating Product',
        slug: 'max-rating-product',
        description: 'A product with max rating',
        imgCover: 'https://example.com/cover.jpg',
        images: [],
        price: 100.0,
        priceAfterDiscount: 80.0,
        quantity: 50,
        category: 'Test',
        occasion: 'Test',
        createdAt: testCreatedAt,
        updatedAt: testUpdatedAt,
        sold: 100,
        rateAvg: 5.0,
        rateCount: 1000,
        isInWishlist: true,
        favoriteId: 'fav999',
      );

      // Assert
      expect(result.rateAvg, 5.0);
      expect(result.rateCount, 1000);
    });

    test('should handle discount greater than price', () {
      // Arrange & Act
      final result = ProductModel(
        id: '7',
        title: 'High Discount Product',
        slug: 'high-discount-product',
        description: 'A product with high discount',
        imgCover: 'https://example.com/cover.jpg',
        images: [],
        price: 100.0,
        priceAfterDiscount: 20.0,
        quantity: 50,
        category: 'Test',
        occasion: 'Test',
        createdAt: testCreatedAt,
        updatedAt: testUpdatedAt,
        sold: 10,
        rateAvg: 4.0,
        rateCount: 10,
        isInWishlist: false,
      );

      // Assert
      expect(result.priceAfterDiscount, 20.0);
      expect(result.priceAfterDiscount < result.price, true);
    });

    test('should handle long text fields', () {
      // Arrange
      final longDescription = 'A' * 1000;
      final longTitle = 'B' * 500;

      // Act
      final result = ProductModel(
        id: '8',
        title: longTitle,
        slug: 'long-text-product',
        description: longDescription,
        imgCover: 'https://example.com/cover.jpg',
        images: [],
        price: 100.0,
        priceAfterDiscount: 80.0,
        quantity: 50,
        category: 'Test',
        occasion: 'Test',
        createdAt: testCreatedAt,
        updatedAt: testUpdatedAt,
        sold: 10,
        rateAvg: 4.0,
        rateCount: 10,
        isInWishlist: false,
      );

      // Assert
      expect(result.title.length, 500);
      expect(result.description.length, 1000);
    });

    test('should handle special characters in text fields', () {
      // Arrange & Act
      final result = ProductModel(
        id: '9',
        title: 'Product with émojis 🎉 & spëcial çhars',
        slug: 'special-chars-product',
        description: 'Description with <html> tags & special chars: @#\$%',
        imgCover: 'https://example.com/cover.jpg',
        images: [],
        price: 100.0,
        priceAfterDiscount: 80.0,
        quantity: 50,
        category: 'Test & More',
        occasion: 'Birthday 🎂',
        createdAt: testCreatedAt,
        updatedAt: testUpdatedAt,
        sold: 10,
        rateAvg: 4.0,
        rateCount: 10,
        isInWishlist: false,
      );

      // Assert
      expect(result.title, contains('émojis'));
      expect(result.description, contains('<html>'));
      expect(result.occasion, contains('🎂'));
    });

    test('should handle multiple images correctly', () {
      // Arrange
      final manyImages = List.generate(
        10,
        (index) => 'https://example.com/image$index.jpg',
      );

      // Act
      final result = ProductModel(
        id: '10',
        title: 'Many Images Product',
        slug: 'many-images-product',
        description: 'A product with many images',
        imgCover: 'https://example.com/cover.jpg',
        images: manyImages,
        price: 100.0,
        priceAfterDiscount: 80.0,
        quantity: 50,
        category: 'Test',
        occasion: 'Test',
        createdAt: testCreatedAt,
        updatedAt: testUpdatedAt,
        sold: 10,
        rateAvg: 4.0,
        rateCount: 10,
        isInWishlist: false,
      );

      // Assert
      expect(result.images.length, 10);
      expect(result.images.first, 'https://example.com/image0.jpg');
      expect(result.images.last, 'https://example.com/image9.jpg');
    });
  });
}
