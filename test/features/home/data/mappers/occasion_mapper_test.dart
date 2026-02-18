import 'package:flower_app/features/tabs/home/data/mappers/occasion_mapper.dart';
import 'package:flower_app/features/tabs/home/data/models/occasion_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OccasionMapper', () {
    test('should map OccasionDto to OccasionEntity', () {
      // Arrange
      final occasionDto = OccasionDto(
        id: '1',
        name: 'Occasion 1',
        image: 'image.jpg',
        slug: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSuperAdmin: null,
      );

      // Act
      final occasionEntity = occasionDto.toEntity();

      // Assert
      expect(occasionEntity.id, occasionDto.id);
      expect(occasionEntity.name, occasionDto.name);
      expect(occasionEntity.image, occasionDto.image);
    });
  });
}
