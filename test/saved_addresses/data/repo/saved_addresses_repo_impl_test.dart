import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/data/data_sources/remote/saved_addresses_remote_datasource.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/data/mappers/saved_addresses_mapper.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/data/models/saved_addresses_response_model.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/data/repo/saved_addresses_repo_impl.dart';
import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'saved_addresses_repo_impl_test.mocks.dart';

@GenerateMocks([SavedAddressesRemoteDatasource])
void main() {
  late SavedAddressesRepoImpl repoImpl;
  late MockSavedAddressesRemoteDatasource mockDataSource;

  setUp(() {
    mockDataSource = MockSavedAddressesRemoteDatasource();
    repoImpl = SavedAddressesRepoImpl(mockDataSource);
  });

  group('getSavedAddresses', () {
    final savedAddressesResponseModel = SavedAddressesResponseModel(
      message: 'success',
      addresses: [
        AddressModel(
          id: '1',
          street: 'Main Street 123',
          phone: '01234567890',
          city: 'Cairo',
          lat: '30.0444',
          long: '31.2357',
          username: 'john_doe',
        ),
        AddressModel(
          id: '2',
          street: 'Second Avenue 456',
          phone: '09876543210',
          city: 'Giza',
          lat: '30.0131',
          long: '31.2089',
          username: 'jane_smith',
        ),
        AddressModel(
          id: '3',
          street: 'Third Boulevard 789',
          phone: '01122334455',
          city: 'Alexandria',
          lat: '31.2001',
          long: '29.9187',
          username: 'bob_johnson',
        ),
      ],
    );

    final savedAddressesResponseEntity = savedAddressesResponseModel.toEntity();

    test('should return saved addresses entity when success', () async {
      // Arrange
      when(mockDataSource.getSavedAddresses()).thenAnswer(
        (_) async => BaseResponse.success(savedAddressesResponseModel),
      );

      // Act
      final result = await repoImpl.getSavedAddresses();

      // Assert
      expect(result, isA<BaseResponse<SavedAddressesResponseEntity>>());
      result.when(
        success: (data) {
          expect(data.message, savedAddressesResponseEntity.message);
          expect(
            data.addresses.length,
            savedAddressesResponseEntity.addresses.length,
          );
          expect(data.addresses.length, 3);
          expect(
            data.addresses[0].id,
            savedAddressesResponseEntity.addresses[0].id,
          );
          expect(
            data.addresses[0].street,
            savedAddressesResponseEntity.addresses[0].street,
          );
          expect(
            data.addresses[1].id,
            savedAddressesResponseEntity.addresses[1].id,
          );
          expect(
            data.addresses[2].id,
            savedAddressesResponseEntity.addresses[2].id,
          );
        },
        failure: (_) => fail('Expected success but got failure'),
      );

      verify(mockDataSource.getSavedAddresses()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should return failure when data source throws exception', () async {
      // Arrange
      when(mockDataSource.getSavedAddresses()).thenAnswer(
        (_) async => BaseResponse.failure(ErrorHandler.handle('Network error')),
      );

      // Act
      final result = await repoImpl.getSavedAddresses();

      // Assert
      expect(result, isA<BaseResponse<SavedAddressesResponseEntity>>());
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ErrorHandler>());
          expect(error.message, ErrorHandler.handle('Network error').message);
          expect(error.code, ErrorHandler.handle('Network error').code);
        },
      );

      verify(mockDataSource.getSavedAddresses()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test(
      'should return empty addresses list when data source returns empty',
      () async {
        // Arrange
        final emptyResponse = SavedAddressesResponseModel(
          message: 'success',
          addresses: [],
        );

        when(
          mockDataSource.getSavedAddresses(),
        ).thenAnswer((_) async => BaseResponse.success(emptyResponse));

        // Act
        final result = await repoImpl.getSavedAddresses();

        // Assert
        result.when(
          success: (data) {
            expect(data.message, 'success');
            expect(data.addresses, isEmpty);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
      },
    );
  });

  group('deleteAddress', () {
    const addressId = 'test-id-123';

    final deleteResponseModel = SavedAddressesResponseModel(
      message: 'Success',
      addresses: [
        AddressModel(
          id: '2',
          street: 'Second Avenue 456',
          phone: '09876543210',
          city: 'Giza',
          lat: '30.0131',
          long: '31.2089',
          username: 'jane_smith',
        ),
        AddressModel(
          id: '3',
          street: 'Third Boulevard 789',
          phone: '01122334455',
          city: 'Alexandria',
          lat: '31.2001',
          long: '29.9187',
          username: 'bob_johnson',
        ),
      ],
    );

    final deleteResponseEntity = deleteResponseModel.toEntity();

    test(
      'should return updated addresses entity after successful deletion',
      () async {
        // Arrange
        when(
          mockDataSource.deleteAddress(addressId),
        ).thenAnswer((_) async => BaseResponse.success(deleteResponseModel));

        // Act
        final result = await repoImpl.deleteAddress(addressId);

        // Assert
        expect(result, isA<BaseResponse<SavedAddressesResponseEntity>>());
        result.when(
          success: (data) {
            expect(data.message, deleteResponseEntity.message);
            expect(
              data.addresses.length,
              deleteResponseEntity.addresses.length,
            );
            expect(data.addresses[0].id, deleteResponseEntity.addresses[0].id);
            expect(data.addresses[1].id, deleteResponseEntity.addresses[1].id);
          },
          failure: (_) => fail('Expected success but got failure'),
        );

        verify(mockDataSource.deleteAddress(addressId)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test('should return failure when delete operation fails', () async {
      // Arrange
      when(mockDataSource.deleteAddress(addressId)).thenAnswer(
        (_) async => BaseResponse.failure(ErrorHandler.handle('Delete failed')),
      );

      // Act
      final result = await repoImpl.deleteAddress(addressId);

      // Assert
      expect(result, isA<BaseResponse<SavedAddressesResponseEntity>>());
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ErrorHandler>());
          expect(error.message, ErrorHandler.handle('Delete failed').message);
          expect(error.code, ErrorHandler.handle('Delete failed').code);
        },
      );

      verify(mockDataSource.deleteAddress(addressId)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test(
      'should return empty addresses list after deleting last address',
      () async {
        // Arrange
        final emptyResponse = SavedAddressesResponseModel(
          message: 'Address deleted successfully',
          addresses: [],
        );

        when(
          mockDataSource.deleteAddress(addressId),
        ).thenAnswer((_) async => BaseResponse.success(emptyResponse));

        // Act
        final result = await repoImpl.deleteAddress(addressId);

        // Assert
        result.when(
          success: (data) {
            expect(data.message, 'Address deleted successfully');
            expect(data.addresses, isEmpty);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
      },
    );

    test('should handle 404 error when address not found', () async {
      // Arrange
      when(mockDataSource.deleteAddress(addressId)).thenAnswer(
        (_) async =>
            BaseResponse.failure(ErrorHandler.handle('Address not found')),
      );

      // Act
      final result = await repoImpl.deleteAddress(addressId);

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(
            error.message,
            ErrorHandler.handle('Address not found').message,
          );
        },
      );
    });
  });
}
