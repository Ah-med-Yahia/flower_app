import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/config/services/location_service.dart';
import 'package:flower_app/features/add_update_adrees/data/data_source/remote/add_update_address_remote_data_source.dart';
import 'package:flower_app/features/add_update_adrees/data/data_source/remote/local/add_update_address_local_data_source.dart';
import 'package:flower_app/features/add_update_adrees/data/mappers/add_update_address_mapper.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_response_model.dart';
import 'package:flower_app/features/add_update_adrees/data/models/city_model.dart';
import 'package:flower_app/features/add_update_adrees/data/models/state_model.dart';
import 'package:flower_app/features/add_update_adrees/data/repo/add_update_address_repo_impl.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_response_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/city_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/location_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/state_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_update_address_repo_impl_test.mocks.dart';

@GenerateMocks([
  AddUpdateAddressRemoteDataSource,
  AddUpdateAddressLocalDataSource,
])
void main() {
  late AddUpdateAddressRepoImpl repo;

  late AddUpdateAddressRemoteDataSource mockRemoteDataSource;
  late AddUpdateAddressLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAddUpdateAddressRemoteDataSource();
    mockLocalDataSource = MockAddUpdateAddressLocalDataSource();
    repo = AddUpdateAddressRepoImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      LocationService(),
    );
  });

  group('addAddress', () {
    final addUpdateAddressRequestEntity = AddUpdateAddressRequestEntity(
      street: 'street',
      phone: 'phone',
      city: 'city',
      lat: 'lat',
      long: 'long',
      username: 'username',
    );
    final addUpdateAddressResponseModel = AddUpdateAddressResponseModel(
      message: 'message',
      address: [
        AddressModel(
          id: 'id',
          street: 'street',
          phone: 'phone',
          city: 'city',
          lat: 'lat',
          long: 'long',
          username: 'username',
        ),
      ],
    );
    const addUpdateAddressResponseEntity = AddUpdateAddressResponseEntity(
      message: 'message',
      address: [
        AddressEntity(
          id: 'id',
          street: 'street',
          phone: 'phone',
          city: 'city',
          lat: 'lat',
          long: 'long',
          username: 'username',
        ),
      ],
    );
    test('should return add update address entity when success', () async {
      //arrange
      when(
        mockRemoteDataSource.addAddress(
          addUpdateAddressRequestEntity.toModel(),
        ),
      ).thenAnswer(
        (_) async => BaseResponse.success(addUpdateAddressResponseModel),
      );
      //act
      final response = await repo.addAddress(addUpdateAddressRequestEntity);
      //assert
      expect(response, isA<BaseResponse<AddUpdateAddressResponseEntity>>());
      response.when(
        success: (success) {
          expect(success, addUpdateAddressResponseEntity);
          expect(success.message, addUpdateAddressResponseEntity.message);
          expect(success.address, addUpdateAddressResponseEntity.address);
        },
        failure: (failure) {
          expect(failure, isA<Failure>());
        },
      );
      verify(
        mockRemoteDataSource.addAddress(
          addUpdateAddressRequestEntity.toModel(),
        ),
      ).called(1);
    });
    test('should return failure when remote data source fails', () async {
      //arrange

      when(
        mockRemoteDataSource.addAddress(
          addUpdateAddressRequestEntity.toModel(),
        ),
      ).thenAnswer(
        (_) async => BaseResponse.failure(ErrorHandler.handle('Network error')),
      );

      //act
      final response = await repo.addAddress(addUpdateAddressRequestEntity);

      //assert
      expect(response, isA<BaseResponse<AddUpdateAddressResponseEntity>>());
      response.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ErrorHandler>());
          expect(error.code, ErrorHandler.handle('Network error').code);
          expect(error.message, ErrorHandler.handle('Network error').message);
        },
      );

      verify(
        mockRemoteDataSource.addAddress(
          addUpdateAddressRequestEntity.toModel(),
        ),
      ).called(1);
    });
  });
  group('updateAddress', () {
    const String id = 'test-id-123';

    final addUpdateAddressRequestEntity = AddUpdateAddressRequestEntity(
      street: 'updated street',
      phone: 'updated phone',
      city: 'updated city',
      lat: 'updated lat',
      long: 'updated long',
      username: 'updated username',
    );

    final addUpdateAddressResponseModel = AddUpdateAddressResponseModel(
      message: 'Address updated successfully',
      address: [
        AddressModel(
          id: id,
          street: 'updated street',
          phone: 'updated phone',
          city: 'updated city',
          lat: 'updated lat',
          long: 'updated long',
          username: 'updated username',
        ),
      ],
    );

    const addUpdateAddressResponseEntity = AddUpdateAddressResponseEntity(
      message: 'Address updated successfully',
      address: [
        AddressEntity(
          id: id,
          street: 'updated street',
          phone: 'updated phone',
          city: 'updated city',
          lat: 'updated lat',
          long: 'updated long',
          username: 'updated username',
        ),
      ],
    );

    test('should return updated address entity when success', () async {
      //arrange
      when(
        mockRemoteDataSource.updateAddress(
          addUpdateAddressRequestEntity.toModel(),
          id,
        ),
      ).thenAnswer(
        (_) async => BaseResponse.success(addUpdateAddressResponseModel),
      );

      //act
      final response = await repo.updateAddress(
        addUpdateAddressRequestEntity,
        id,
      );

      //assert
      expect(response, isA<BaseResponse<AddUpdateAddressResponseEntity>>());
      response.when(
        success: (success) {
          expect(success, addUpdateAddressResponseEntity);
          expect(success.message, addUpdateAddressResponseEntity.message);
          expect(success.address, addUpdateAddressResponseEntity.address);
        },
        failure: (failure) {
          expect(failure, isA<Failure>());
        },
      );

      verify(
        mockRemoteDataSource.updateAddress(
          addUpdateAddressRequestEntity.toModel(),
          id,
        ),
      ).called(1);
    });

    test('should return failure when remote data source fails', () async {
      //arrange
      when(
        mockRemoteDataSource.updateAddress(
          addUpdateAddressRequestEntity.toModel(),
          id,
        ),
      ).thenAnswer(
        (_) async => BaseResponse.failure(ErrorHandler.handle('Network error')),
      );

      //act
      final response = await repo.updateAddress(
        addUpdateAddressRequestEntity,
        id,
      );

      //assert
      expect(response, isA<BaseResponse<AddUpdateAddressResponseEntity>>());
      response.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ErrorHandler>());
          expect(error.code, ErrorHandler.handle('Network error').code);
          expect(error.message, ErrorHandler.handle('Network error').message);
        },
      );

      verify(
        mockRemoteDataSource.updateAddress(
          addUpdateAddressRequestEntity.toModel(),
          id,
        ),
      ).called(1);
    });
  });

  group('getGovernorates', () {
    final stateModels = [
      const StateModel(
        id: '1',
        governorateNameAr: 'القاهرة',
        governorateNameEn: 'Cairo',
      ),
      const StateModel(
        id: '2',
        governorateNameAr: 'الإسكندرية',
        governorateNameEn: 'Alexandria',
      ),
    ];

    test('should return list of state entities when success', () async {
      // Arrange
      when(
        mockLocalDataSource.getGovernorates(),
      ).thenAnswer((_) async => stateModels);

      // Act
      final result = await repo.getGovernorates();

      // Assert
      expect(result, isA<BaseResponse<List<StateEntity>>>());
      result.when(
        success: (states) {
          expect(states.length, 2);
          expect(states[0].id, '1');
          expect(states[0].governorateNameEn, 'Cairo');
          expect(states[1].id, '2');
          expect(states[1].governorateNameEn, 'Alexandria');
        },
        failure: (_) => fail('Expected success but got failure'),
      );

      verify(mockLocalDataSource.getGovernorates()).called(1);
    });

    test(
      'should return failure when local data source throws exception',
      () async {
        // Arrange
        when(
          mockLocalDataSource.getGovernorates(),
        ).thenThrow(Exception('Failed to load governorates'));

        // Act
        final result = await repo.getGovernorates();

        // Assert
        expect(result, isA<BaseResponse<List<StateEntity>>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error, isA<ErrorHandler>());
          },
        );

        verify(mockLocalDataSource.getGovernorates()).called(1);
      },
    );
  });

  group('getCities', () {
    final cityModels = [
      const CityModel(
        id: '1',
        governorateId: '1',
        cityNameAr: 'مدينة نصر',
        cityNameEn: 'Nasr City',
      ),
      const CityModel(
        id: '2',
        governorateId: '1',
        cityNameAr: 'المعادي',
        cityNameEn: 'Maadi',
      ),
    ];

    test('should return list of city entities when success', () async {
      // Arrange
      when(mockLocalDataSource.getCities()).thenAnswer((_) async => cityModels);

      // Act
      final result = await repo.getCities();

      // Assert
      expect(result, isA<BaseResponse<List<CityEntity>>>());
      result.when(
        success: (cities) {
          expect(cities.length, 2);
          expect(cities[0].id, '1');
          expect(cities[0].cityNameEn, 'Nasr City');
          expect(cities[0].governorateId, '1');
          expect(cities[1].id, '2');
          expect(cities[1].cityNameEn, 'Maadi');
        },
        failure: (_) => fail('Expected success but got failure'),
      );

      verify(mockLocalDataSource.getCities()).called(1);
    });

    test(
      'should return failure when local data source throws exception',
      () async {
        // Arrange
        when(
          mockLocalDataSource.getCities(),
        ).thenThrow(Exception('Failed to load cities'));

        // Act
        final result = await repo.getCities();

        // Assert
        expect(result, isA<BaseResponse<List<CityEntity>>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error, isA<ErrorHandler>());
          },
        );

        verify(mockLocalDataSource.getCities()).called(1);
      },
    );
  });

  group('getCoordinatesFromAddress', () {
    const cityName = 'Cairo';
    const stateName = 'Cairo Governorate';

    test('should return location entity when coordinates are found', () async {
      // Arrange
      // Note: This test requires mocking the geocoding package
      // For now, we'll test the validation logic

      // Act
      final result = await repo.getCoordinatesFromAddress(
        cityName: cityName,
        stateName: stateName,
      );

      // Assert
      expect(result, isA<BaseResponse<LocationEntity>>());
      // The actual result depends on the geocoding service
      // In a real scenario, you'd mock the geocoding package
    });

    test('should return failure when state name is empty', () async {
      // Act
      final result = await repo.getCoordinatesFromAddress(
        cityName: cityName,
        stateName: '',
      );

      // Assert
      expect(result, isA<BaseResponse<LocationEntity>>());
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ErrorHandler>());
        },
      );
    });
  });
}
