import 'package:flower_app/features/home/data/mappers/product_dto_mapper.dart';
import 'package:flower_app/features/home/data/models/home_screen_product_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductDtoMapper', () {
    test('should map HomeScreenProductDto to ProductEntity', () {
      // Arrange
      final productDto = HomeScreenProductDto(
        id: '1',
        title: 'title',
        slug: 'slug',
        description: 'description',
        imgCover: 'imgCover',
        images: [],
        price: 1,
        priceAfterDiscount: 1,
        quantity: 1,
        category: 'category',
        occasion: 'occasion',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        v: 1,
        isSuperAdmin: false,
        rateAvg: 1,
        rateCount: 1,
      );

      // Act
      final productEntity = productDto.toEntity();

      // Assert
      expect(productEntity.id, productDto.id);
      expect(productEntity.title, productDto.title);
      expect(productEntity.imgCover, productDto.imgCover);
    });
  });
}
