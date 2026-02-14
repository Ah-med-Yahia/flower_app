import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/city_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/repo/add_update_address_repo.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/get_cities_by_state_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_cities_by_state_use_case_test.mocks.dart';

@GenerateMocks([AddUpdateAddressRepo])
void main() {
  late GetCitiesByStateUseCase useCase;
  late MockAddUpdateAddressRepo mockRepo;

  setUp(() {
    mockRepo = MockAddUpdateAddressRepo();
    useCase = GetCitiesByStateUseCase(mockRepo);
  });

  group('GetCitiesByStateUseCase', () {
    const governorateId = '1';

    final allCities = [
      const CityEntity(
        id: '1',
        governorateId: '1',
        cityNameAr: 'مدينة نصر',
        cityNameEn: 'Nasr City',
      ),
      const CityEntity(
        id: '2',
        governorateId: '1',
        cityNameAr: 'المعادي',
        cityNameEn: 'Maadi',
      ),
      const CityEntity(
        id: '3',
        governorateId: '2',
        cityNameAr: 'المنتزه',
        cityNameEn: 'Al Montazah',
      ),
    ];

    test('should return filtered cities for given governorate ID', () async {
      // Arrange
      when(
        mockRepo.getCities(),
      ).thenAnswer((_) async => BaseResponse.success(allCities));

      // Act
      final result = await useCase.call(governorateId);

      // Assert
      expect(result, isA<BaseResponse<List<CityEntity>>>());
      result.when(
        success: (cities) {
          expect(cities.length, 2);
          expect(cities[0].governorateId, governorateId);
          expect(cities[0].cityNameEn, 'Nasr City');
          expect(cities[1].governorateId, governorateId);
          expect(cities[1].cityNameEn, 'Maadi');
        },
        failure: (_) => fail('Expected success but got failure'),
      );

      verify(mockRepo.getCities()).called(1);
    });

    test(
      'should return empty list when no cities match governorate ID',
      () async {
        // Arrange
        when(
          mockRepo.getCities(),
        ).thenAnswer((_) async => BaseResponse.success(allCities));

        // Act
        final result = await useCase.call('999'); // Non-existent governorate

        // Assert
        expect(result, isA<BaseResponse<List<CityEntity>>>());
        result.when(
          success: (cities) {
            expect(cities.isEmpty, true);
          },
          failure: (_) => fail('Expected success but got failure'),
        );

        verify(mockRepo.getCities()).called(1);
      },
    );

    test('should return failure when repository fails', () async {
      // Arrange
      when(mockRepo.getCities()).thenAnswer(
        (_) async =>
            BaseResponse.failure(ErrorHandler.handle('Failed to load cities')),
      );

      // Act
      final result = await useCase.call(governorateId);

      // Assert
      expect(result, isA<BaseResponse<List<CityEntity>>>());
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ErrorHandler>());
        },
      );

      verify(mockRepo.getCities()).called(1);
    });

    test('should handle multiple cities for same governorate', () async {
      // Arrange
      final manyCities = [
        const CityEntity(
          id: '1',
          governorateId: '1',
          cityNameAr: 'مدينة نصر',
          cityNameEn: 'Nasr City',
        ),
        const CityEntity(
          id: '2',
          governorateId: '1',
          cityNameAr: 'المعادي',
          cityNameEn: 'Maadi',
        ),
        const CityEntity(
          id: '3',
          governorateId: '1',
          cityNameAr: 'الزمالك',
          cityNameEn: 'Zamalek',
        ),
        const CityEntity(
          id: '4',
          governorateId: '1',
          cityNameAr: 'مصر الجديدة',
          cityNameEn: 'Heliopolis',
        ),
      ];

      when(
        mockRepo.getCities(),
      ).thenAnswer((_) async => BaseResponse.success(manyCities));

      // Act
      final result = await useCase.call(governorateId);

      // Assert
      result.when(
        success: (cities) {
          expect(cities.length, 4);
          expect(
            cities.every((city) => city.governorateId == governorateId),
            true,
          );
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });
  });
}
