import 'package:flower_app/features/add_update_adrees/data/mappers/location_mapper.dart';
import 'package:flower_app/features/add_update_adrees/data/models/city_model.dart';
import 'package:flower_app/features/add_update_adrees/data/models/state_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocationMapper', () {
    group('StateModelToEntityMapper', () {
      test('should map StateModel to StateEntity correctly', () {
        // Arrange
        const stateModel = StateModel(
          id: '1',
          governorateNameAr: 'القاهرة',
          governorateNameEn: 'Cairo',
        );

        // Act
        final stateEntity = stateModel.toEntity();

        // Assert
        expect(stateEntity.id, stateModel.id);
        expect(stateEntity.governorateNameAr, stateModel.governorateNameAr);
        expect(stateEntity.governorateNameEn, stateModel.governorateNameEn);
      });

      test('should map multiple StateModels correctly', () {
        // Arrange
        const stateModels = [
          StateModel(
            id: '1',
            governorateNameAr: 'القاهرة',
            governorateNameEn: 'Cairo',
          ),
          StateModel(
            id: '2',
            governorateNameAr: 'الإسكندرية',
            governorateNameEn: 'Alexandria',
          ),
        ];

        // Act
        final stateEntities = stateModels
            .map((model) => model.toEntity())
            .toList();

        // Assert
        expect(stateEntities.length, 2);
        expect(stateEntities[0].id, '1');
        expect(stateEntities[0].governorateNameEn, 'Cairo');
        expect(stateEntities[1].id, '2');
        expect(stateEntities[1].governorateNameEn, 'Alexandria');
      });
    });

    group('CityModelToEntityMapper', () {
      test('should map CityModel to CityEntity correctly', () {
        // Arrange
        const cityModel = CityModel(
          id: '1',
          governorateId: '1',
          cityNameAr: 'مدينة نصر',
          cityNameEn: 'Nasr City',
        );

        // Act
        final cityEntity = cityModel.toEntity();

        // Assert
        expect(cityEntity.id, cityModel.id);
        expect(cityEntity.governorateId, cityModel.governorateId);
        expect(cityEntity.cityNameAr, cityModel.cityNameAr);
        expect(cityEntity.cityNameEn, cityModel.cityNameEn);
      });

      test('should map multiple CityModels correctly', () {
        // Arrange
        const cityModels = [
          CityModel(
            id: '1',
            governorateId: '1',
            cityNameAr: 'مدينة نصر',
            cityNameEn: 'Nasr City',
          ),
          CityModel(
            id: '2',
            governorateId: '1',
            cityNameAr: 'المعادي',
            cityNameEn: 'Maadi',
          ),
        ];

        // Act
        final cityEntities = cityModels
            .map((model) => model.toEntity())
            .toList();

        // Assert
        expect(cityEntities.length, 2);
        expect(cityEntities[0].id, '1');
        expect(cityEntities[0].cityNameEn, 'Nasr City');
        expect(cityEntities[0].governorateId, '1');
        expect(cityEntities[1].id, '2');
        expect(cityEntities[1].cityNameEn, 'Maadi');
      });

      test('should preserve governorate relationship in mapping', () {
        // Arrange
        const cityModel = CityModel(
          id: '5',
          governorateId: '3',
          cityNameAr: 'الغردقة',
          cityNameEn: 'Hurghada',
        );

        // Act
        final cityEntity = cityModel.toEntity();

        // Assert
        expect(cityEntity.governorateId, '3');
        expect(cityEntity.id, '5');
      });
    });
  });
}
