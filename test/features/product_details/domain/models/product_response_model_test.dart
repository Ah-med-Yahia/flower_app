import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/features/products/product_details/domain/models/product_model.dart';
import 'package:flower_app/features/products/product_details/domain/models/product_response_model.dart';

import 'product_response_model_test.mocks.dart';

@GenerateMocks([ProductModel])
void main() {
  group('ProductResponseModel', () {
    late MockProductModel mockProduct;

    setUp(() {
      mockProduct = MockProductModel();
    });

    test(
      'should create a valid ProductResponseModel with message and product',
      () {
        // Arrange
        when(mockProduct.id).thenReturn('1');
        when(mockProduct.title).thenReturn('Test Product');

        // Act
        final result = ProductResponseModel(
          message: 'Success',
          product: mockProduct,
        );

        // Assert
        expect(result.message, 'Success');
        expect(result.product, mockProduct);
        expect(result.product.id, '1');
        expect(result.product.title, 'Test Product');
      },
    );

    test('should handle empty message string', () {
      // Arrange & Act
      final result = ProductResponseModel(message: '', product: mockProduct);

      // Assert
      expect(result.message, '');
      expect(result.message.isEmpty, true);
      expect(result.product, mockProduct);
    });

    test('should handle long message string', () {
      // Arrange
      final longMessage = 'A' * 1000;

      // Act
      final result = ProductResponseModel(
        message: longMessage,
        product: mockProduct,
      );

      // Assert
      expect(result.message.length, 1000);
      expect(result.product, mockProduct);
    });

    test('should handle message with special characters', () {
      // Arrange & Act
      final result = ProductResponseModel(
        message:
            'Success! 🎉 Product retrieved with émojis & spëcial çhars @#\$%',
        product: mockProduct,
      );

      // Assert
      expect(result.message, contains('🎉'));
      expect(result.message, contains('émojis'));
      expect(result.message, contains('@#\$%'));
      expect(result.product, mockProduct);
    });

    test('should handle different success messages', () {
      // Arrange & Act
      final result1 = ProductResponseModel(
        message: 'Product fetched successfully',
        product: mockProduct,
      );

      final result2 = ProductResponseModel(
        message: 'Data retrieved',
        product: mockProduct,
      );

      final result3 = ProductResponseModel(message: 'OK', product: mockProduct);

      // Assert
      expect(result1.message, 'Product fetched successfully');
      expect(result2.message, 'Data retrieved');
      expect(result3.message, 'OK');
      expect(result1.product, mockProduct);
      expect(result2.product, mockProduct);
      expect(result3.product, mockProduct);
    });

    test('should maintain product data integrity within response', () {
      // Arrange
      when(mockProduct.id).thenReturn('1');
      when(mockProduct.title).thenReturn('Test Product');
      when(mockProduct.price).thenReturn(100.0);
      when(mockProduct.priceAfterDiscount).thenReturn(80.0);
      when(mockProduct.quantity).thenReturn(50);
      when(mockProduct.isInWishlist).thenReturn(false);
      when(mockProduct.favoriteId).thenReturn(null);

      // Act
      final result = ProductResponseModel(
        message: 'Success',
        product: mockProduct,
      );

      // Assert
      expect(result.product.id, '1');
      expect(result.product.title, 'Test Product');
      expect(result.product.price, 100.0);
      expect(result.product.priceAfterDiscount, 80.0);
      expect(result.product.quantity, 50);
      expect(result.product.isInWishlist, false);
      expect(result.product.favoriteId, null);
    });

    test('should handle product with favoriteId in response', () {
      // Arrange
      when(mockProduct.isInWishlist).thenReturn(true);
      when(mockProduct.favoriteId).thenReturn('fav123');

      // Act
      final result = ProductResponseModel(
        message: 'Product with favorite retrieved',
        product: mockProduct,
      );

      // Assert
      expect(result.message, 'Product with favorite retrieved');
      expect(result.product.isInWishlist, true);
      expect(result.product.favoriteId, 'fav123');
    });

    test('should handle product with zero values in response', () {
      // Arrange
      when(mockProduct.price).thenReturn(0.0);
      when(mockProduct.quantity).thenReturn(0);
      when(mockProduct.sold).thenReturn(0);
      when(mockProduct.rateAvg).thenReturn(0.0);

      // Act
      final result = ProductResponseModel(
        message: 'Product with zero values retrieved',
        product: mockProduct,
      );

      // Assert
      expect(result.message, 'Product with zero values retrieved');
      expect(result.product.price, 0.0);
      expect(result.product.quantity, 0);
      expect(result.product.sold, 0);
      expect(result.product.rateAvg, 0.0);
    });

    test('should handle product with empty images list in response', () {
      // Arrange
      when(mockProduct.images).thenReturn([]);

      // Act
      final result = ProductResponseModel(
        message: 'Product without images retrieved',
        product: mockProduct,
      );

      // Assert
      expect(result.message, 'Product without images retrieved');
      expect(result.product.images, isEmpty);
      expect(result.product.images.length, 0);
    });

    test('should handle multilingual messages', () {
      // Arrange & Act
      final result1 = ProductResponseModel(
        message: 'تم استرجاع المنتج بنجاح',
        product: mockProduct,
      );

      final result2 = ProductResponseModel(
        message: 'Produit récupéré avec succès',
        product: mockProduct,
      );

      final result3 = ProductResponseModel(
        message: '製品が正常に取得されました',
        product: mockProduct,
      );

      // Assert
      expect(result1.message, 'تم استرجاع المنتج بنجاح');
      expect(result2.message, 'Produit récupéré avec succès');
      expect(result3.message, '製品が正常に取得されました');
      expect(result1.product, mockProduct);
      expect(result2.product, mockProduct);
      expect(result3.product, mockProduct);
    });

    test('should handle product with multiple images', () {
      // Arrange
      final imageList = [
        'https://example.com/image1.jpg',
        'https://example.com/image2.jpg',
        'https://example.com/image3.jpg',
      ];
      when(mockProduct.images).thenReturn(imageList);

      // Act
      final result = ProductResponseModel(
        message: 'Success',
        product: mockProduct,
      );

      // Assert
      expect(result.product.images.length, 3);
      expect(result.product.images, imageList);
    });
  });
}
