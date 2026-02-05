import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/saved_addresses/api/api_client/saved_addresses_api_client.dart';
import 'package:flower_app/features/saved_addresses/api/data_sources/remote/saved_addresses_remote_datasource_impl.dart';
import 'package:flower_app/features/saved_addresses/data/models/saved_addresses_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'saved_addresses_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([SavedAddressesApiClient])
void main() {
  late SavedAddressesRemoteDatasourceImpl dataSource;
  late MockSavedAddressesApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockSavedAddressesApiClient();
    dataSource = SavedAddressesRemoteDatasourceImpl(mockApiClient);
  });

  group('SavedAddressesRemoteDatasourceImpl', () {
    final savedAddressesResponseModel = SavedAddressesResponseModel(
      message: 'success',
      addresses: [
        AddressModel(
          id: '1',
          street: 'Test Street',
          phone: '01234567890',
          city: 'Test City',
          lat: '30.123',
          long: '31.456',
          username: 'testuser',
        ),
        AddressModel(
          id: '2',
          street: 'Another Street',
          phone: '09876543210',
          city: 'Another City',
          lat: '29.456',
          long: '32.789',
          username: 'anotheruser',
        ),
      ],
    );

    group('getSavedAddresses', () {
      test(
        'should return success BaseResponse when api client returns SavedAddressesResponseModel',
        () async {
          // Arrange
          when(
            mockApiClient.getSavedAddresses(),
          ).thenAnswer((_) async => savedAddressesResponseModel);

          // Act
          final result = await dataSource.getSavedAddresses();

          // Assert
          expect(result, isA<BaseResponse<SavedAddressesResponseModel>>());
          result.when(
            success: (data) {
              expect(data.message, 'success');
              expect(data.addresses, savedAddressesResponseModel.addresses);
              expect(data.addresses?.length, 2);
              expect(data.addresses?.first.id, '1');
              expect(data.addresses?.first.street, 'Test Street');
            },
            failure: (_) => fail('Expected success but got failure'),
          );

          verify(mockApiClient.getSavedAddresses()).called(1);
          verifyNoMoreInteractions(mockApiClient);
        },
      );

      test(
        'should return failure BaseResponse when api client throws exception',
        () async {
          // Arrange
          when(
            mockApiClient.getSavedAddresses(),
          ).thenThrow(Exception('Network error'));

          // Act
          final result = await dataSource.getSavedAddresses();

          // Assert
          expect(result, isA<BaseResponse<SavedAddressesResponseModel>>());
          result.when(
            success: (_) => fail('Expected failure but got success'),
            failure: (errorHandler) {
              expect(
                errorHandler.message,
                ErrorHandler.handle('Network error').message,
              );
              expect(
                errorHandler.code,
                ErrorHandler.handle('Network error').code,
              );
            },
          );

          verify(mockApiClient.getSavedAddresses()).called(1);
          verifyNoMoreInteractions(mockApiClient);
        },
      );

      test('should return success with empty addresses list', () async {
        // Arrange
        final emptyResponse = SavedAddressesResponseModel(
          message: 'success',
          addresses: [],
        );

        when(
          mockApiClient.getSavedAddresses(),
        ).thenAnswer((_) async => emptyResponse);

        // Act
        final result = await dataSource.getSavedAddresses();

        // Assert
        result.when(
          success: (data) {
            expect(data.message, 'success');
            expect(data.addresses, isEmpty);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
      });
    });

    group('deleteAddress', () {
      const addressId = 'test-id-123';

      test(
        'should return success BaseResponse when address is deleted successfully',
        () async {
          // Arrange
          final deleteResponse = SavedAddressesResponseModel(
            message: 'Address deleted successfully',
            addresses: [
              AddressModel(
                id: '2',
                street: 'Another Street',
                phone: '09876543210',
                city: 'Another City',
                lat: '29.456',
                long: '32.789',
                username: 'anotheruser',
              ),
            ],
          );

          when(
            mockApiClient.deleteAddress(addressId),
          ).thenAnswer((_) async => deleteResponse);

          // Act
          final result = await dataSource.deleteAddress(addressId);

          // Assert
          expect(result, isA<BaseResponse<SavedAddressesResponseModel>>());
          result.when(
            success: (data) {
              expect(data.message, 'Address deleted successfully');
              expect(data.addresses?.length, 1);
              expect(data.addresses?.first.id, '2');
            },
            failure: (_) => fail('Expected success but got failure'),
          );

          verify(mockApiClient.deleteAddress(addressId)).called(1);
          verifyNoMoreInteractions(mockApiClient);
        },
      );

      test('should return failure BaseResponse when delete fails', () async {
        // Arrange
        when(
          mockApiClient.deleteAddress(addressId),
        ).thenThrow(Exception('Delete failed'));

        // Act
        final result = await dataSource.deleteAddress(addressId);

        // Assert
        expect(result, isA<BaseResponse<SavedAddressesResponseModel>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (errorHandler) {
            expect(
              errorHandler.message,
              ErrorHandler.handle('Delete failed').message,
            );
            expect(
              errorHandler.code,
              ErrorHandler.handle('Delete failed').code,
            );
          },
        );

        verify(mockApiClient.deleteAddress(addressId)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      });

      test('should handle deletion of last address', () async {
        // Arrange
        final emptyResponse = SavedAddressesResponseModel(
          message: 'Address deleted successfully',
          addresses: [],
        );

        when(
          mockApiClient.deleteAddress(addressId),
        ).thenAnswer((_) async => emptyResponse);

        // Act
        final result = await dataSource.deleteAddress(addressId);

        // Assert
        result.when(
          success: (data) {
            expect(data.message, 'Address deleted successfully');
            expect(data.addresses, isEmpty);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
      });
    });
  });
}
