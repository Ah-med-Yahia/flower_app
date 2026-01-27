import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/add_update_adrees/data/data_source/remote/add_update_address_remote_data_source.dart';
import 'package:flower_app/features/add_update_adrees/data/mappers/add_update_address_mapper.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_response_model.dart';
import 'package:flower_app/features/add_update_adrees/data/repo/add_update_address_repo_impl.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_update_address_repo_impl_test.mocks.dart';

@GenerateMocks([AddUpdateAddressRemoteDataSource])
void main() {
  late AddUpdateAddressRepoImpl repo;

  late AddUpdateAddressRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAddUpdateAddressRemoteDataSource();
    repo = AddUpdateAddressRepoImpl(mockRemoteDataSource);
  });

  group('addAddress', () async {
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
    final addUpdateAddressResponseEntity = AddUpdateAddressResponseEntity(
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

    final addUpdateAddressResponseEntity = AddUpdateAddressResponseEntity(
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
}
