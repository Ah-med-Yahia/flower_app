import 'package:flower_app/features/saved_addresses/data/mappers/saved_addresses_mapper.dart';
import 'package:flower_app/features/saved_addresses/data/models/saved_addresses_response_model.dart';
import 'package:flower_app/features/saved_addresses/domain/models/saved_addresses_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SavedAddresses Mapper Tests', () {
    test('Response Mapping: Model → Entity with valid data', () {
      // Arrange
      final addressModel1 = AddressModel(
        id: '1',
        street: 'Test Street',
        phone: '01234567890',
        city: 'Cairo',
        lat: '30.123',
        long: '31.456',
        username: 'testuser',
      );

      final addressModel2 = AddressModel(
        id: '2',
        street: 'Another Street',
        phone: '09876543210',
        city: 'Giza',
        lat: '29.456',
        long: '32.789',
        username: 'anotheruser',
      );

      final responseModel = SavedAddressesResponseModel(
        message: 'success',
        addresses: [addressModel1, addressModel2],
      );

      // Act
      final responseEntity = responseModel.toEntity();

      // Assert
      expect(responseEntity, isA<SavedAddressesResponseEntity>());
      expect(responseEntity.message, 'success');
      expect(responseEntity.addresses.length, 2);
      expect(responseEntity.addresses[0].id, '1');
      expect(responseEntity.addresses[0].street, 'Test Street');
      expect(responseEntity.addresses[0].phone, '01234567890');
      expect(responseEntity.addresses[0].city, 'Cairo');
      expect(responseEntity.addresses[0].lat, '30.123');
      expect(responseEntity.addresses[0].long, '31.456');
      expect(responseEntity.addresses[0].username, 'testuser');
      expect(responseEntity.addresses[1].id, '2');
      expect(responseEntity.addresses[1].street, 'Another Street');
    });

    test('Response Mapping: Model → Entity with null message', () {
      // Arrange
      final responseModel = SavedAddressesResponseModel(
        message: null,
        addresses: [],
      );

      // Act
      final responseEntity = responseModel.toEntity();

      // Assert
      expect(responseEntity.message, '');
      expect(responseEntity.addresses, isEmpty);
    });

    test('Response Mapping: Model → Entity with null addresses list', () {
      // Arrange
      final responseModel = SavedAddressesResponseModel(
        message: 'success',
        addresses: null,
      );

      // Act
      final responseEntity = responseModel.toEntity();

      // Assert
      expect(responseEntity.message, 'success');
      expect(responseEntity.addresses, isEmpty);
    });

    test('Response Mapping: Model → Entity with empty addresses list', () {
      // Arrange
      final responseModel = SavedAddressesResponseModel(
        message: 'success',
        addresses: [],
      );

      // Act
      final responseEntity = responseModel.toEntity();

      // Assert
      expect(responseEntity.message, 'success');
      expect(responseEntity.addresses, isEmpty);
    });

    test('AddressModel → AddressEntity with null fields', () {
      // Arrange
      final addressModel = AddressModel(
        id: '123',
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
      expect(addressEntity.id, '123');
      expect(addressEntity.street, '');
      expect(addressEntity.phone, '');
      expect(addressEntity.city, '');
      expect(addressEntity.lat, '');
      expect(addressEntity.long, '');
      expect(addressEntity.username, '');
    });

    test('AddressModel → AddressEntity with multiple addresses', () {
      // Arrange
      final addresses = [
        AddressModel(
          id: '1',
          street: 'Street 1',
          phone: '111',
          city: 'City 1',
          lat: '10.0',
          long: '20.0',
          username: 'user1',
        ),
        AddressModel(
          id: '2',
          street: 'Street 2',
          phone: '222',
          city: 'City 2',
          lat: '30.0',
          long: '40.0',
          username: 'user2',
        ),
        AddressModel(
          id: '3',
          street: 'Street 3',
          phone: '333',
          city: 'City 3',
          lat: '50.0',
          long: '60.0',
          username: 'user3',
        ),
      ];

      final responseModel = SavedAddressesResponseModel(
        message: 'success',
        addresses: addresses,
      );

      // Act
      final responseEntity = responseModel.toEntity();

      // Assert
      expect(responseEntity.addresses.length, 3);
      expect(responseEntity.addresses[0].id, '1');
      expect(responseEntity.addresses[1].id, '2');
      expect(responseEntity.addresses[2].id, '3');
      expect(responseEntity.addresses[0].username, 'user1');
      expect(responseEntity.addresses[1].username, 'user2');
      expect(responseEntity.addresses[2].username, 'user3');
    });

    test('Response Mapping: Preserves all address data correctly', () {
      // Arrange
      final addressModel = AddressModel(
        id: 'abc123',
        street: 'Main Street 123',
        phone: '+201234567890',
        city: 'Alexandria',
        lat: '31.200092',
        long: '29.918739',
        username: 'johndoe',
      );

      final responseModel = SavedAddressesResponseModel(
        message: 'Addresses retrieved successfully',
        addresses: [addressModel],
      );

      // Act
      final responseEntity = responseModel.toEntity();
      final addressEntity = responseEntity.addresses.first;

      // Assert
      expect(addressEntity.id, 'abc123');
      expect(addressEntity.street, 'Main Street 123');
      expect(addressEntity.phone, '+201234567890');
      expect(addressEntity.city, 'Alexandria');
      expect(addressEntity.lat, '31.200092');
      expect(addressEntity.long, '29.918739');
      expect(addressEntity.username, 'johndoe');
    });
  });
}
