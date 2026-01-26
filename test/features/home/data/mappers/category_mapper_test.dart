import 'package:flower_app/features/home/data/mappers/category_mapper.dart';
import 'package:flower_app/features/home/data/models/category_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryMapper', () {
    test('should map Categorydto to CategoryEntity', () {
      // Arrange
      final categoryDto = CategoryDto(
        id: '1',
        name: 'Category 1',
        image: 'image.jpg',
        slug: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSuperAdmin: null,
      );

      // Act
      final categoryEntity = categoryDto.toEntity();

      // Assert
      expect(categoryEntity.id, categoryDto.id);
      expect(categoryEntity.name, categoryDto.name);
      expect(categoryEntity.image, categoryDto.image);
    });
  });
}
