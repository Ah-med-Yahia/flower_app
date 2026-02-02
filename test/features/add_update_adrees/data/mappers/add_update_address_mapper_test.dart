import 'package:flower_app/features/add_update_adrees/data/mappers/add_update_address_mapper.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_request_model.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_response_model.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddUpdateAddress Mapper Tests', () {
    test('Request Mapping: Entity → Model', () {
      // Arrange
      final requestEntity = AddUpdateAddressRequestEntity(
        street: 'Home',
        phone: '01010700700',
        city: 'Giza',
        lat: '30.123',
        long: '31.456',
        username: 'ahmedmuti',
      );

      // Act
      final requestModel = requestEntity.toModel();

      // Assert
      expect(requestModel, isA<AddUpdateAddressRequestModel>());
      expect(requestModel.street, 'Home');
      expect(requestModel.phone, '01010700700');
      expect(requestModel.city, 'Giza');
      expect(requestModel.lat, '30.123');
      expect(requestModel.long, '31.456');
      expect(requestModel.username, 'ahmedmuti');
    });

    test('Response Mapping: Model → Entity with valid data', () {
      // Arrange
      final addressModel = AddressModel(
        id: '6977eca5e364ef61404b20dc',
        street: 'Home',
        phone: '01010700700',
        city: 'Giza',
        lat: '30.123',
        long: '31.456',
        username: 'ahmedmuti',
      );

      final responseModel = AddUpdateAddressResponseModel(
        message: 'success',
        address: [addressModel],
      );

      // Act
      final responseEntity = responseModel.toEntity();

      // Assert
      expect(responseEntity, isA<AddUpdateAddressResponseEntity>());
      expect(responseEntity.message, 'success');
      expect(responseEntity.address.length, 1);
      expect(responseEntity.address.first.id, '6977eca5e364ef61404b20dc');
      expect(responseEntity.address.first.street, 'Home');
      expect(responseEntity.address.first.phone, '01010700700');
      expect(responseEntity.address.first.city, 'Giza');
      expect(responseEntity.address.first.lat, '30.123');
      expect(responseEntity.address.first.long, '31.456');
      expect(responseEntity.address.first.username, 'ahmedmuti');
    });

    test('Response Mapping: Model → Entity with null message', () {
      // Arrange
      final responseModel = AddUpdateAddressResponseModel(
        message: null,
        address: [],
      );

      // Act
      final responseEntity = responseModel.toEntity();

      // Assert
      expect(responseEntity.message, '');
      expect(responseEntity.address, isEmpty);
    });

    test('Response Mapping: Model → Entity with null address list', () {
      // Arrange
      final responseModel = AddUpdateAddressResponseModel(
        message: 'success',
        address: null,
      );

      // Act
      final responseEntity = responseModel.toEntity();

      // Assert
      expect(responseEntity.message, 'success');
      expect(responseEntity.address, isEmpty);
    });

    test('AddressModel → AddressEntity with null fields', () {
      // Arrange
      final addressModel = AddressModel(
        id: null,
        street: null,
        phone: null,
        city: null,
        lat: null,
        long: null,
        username: null,
      );

      // Act
      final addressEntity = addressModel.toEntity();

      // Assert
      expect(addressEntity.id, '');
      expect(addressEntity.street, '');
      expect(addressEntity.phone, '');
      expect(addressEntity.city, '');
      expect(addressEntity.lat, '');
      expect(addressEntity.long, '');
      expect(addressEntity.username, '');
    });

    test('Response Mapping: Model → Entity with multiple addresses', () {
      // Arrange
      final addressModel1 = AddressModel(
        id: '1',
        street: 'Street 1',
        phone: '111',
        city: 'City 1',
        lat: '10.0',
        long: '20.0',
        username: 'user1',
      );

      final addressModel2 = AddressModel(
        id: '2',
        street: 'Street 2',
        phone: '222',
        city: 'City 2',
        lat: '30.0',
        long: '40.0',
        username: 'user2',
      );

      final responseModel = AddUpdateAddressResponseModel(
        message: 'success',
        address: [addressModel1, addressModel2],
      );

      // Act
      final responseEntity = responseModel.toEntity();

      // Assert
      expect(responseEntity.address.length, 2);
      expect(responseEntity.address[0].id, '1');
      expect(responseEntity.address[0].street, 'Street 1');
      expect(responseEntity.address[1].id, '2');
      expect(responseEntity.address[1].street, 'Street 2');
    });
  });
}
