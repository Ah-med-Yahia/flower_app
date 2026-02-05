import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/add_update_adrees/api/api_clinet/add_update_adrees_api_client.dart';
import 'package:flower_app/features/add_update_adrees/api/data_source/remote/add_update_address_remote_data_source_impl.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_request_model.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_update_address_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AddUpdateAdreesApiClient])
void main() {
  late AddUpdateAddressRemoteDataSourceImpl dataSource;
  late MockAddUpdateAdreesApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockAddUpdateAdreesApiClient();
    dataSource = AddUpdateAddressRemoteDataSourceImpl(mockApiClient);
  });

  group('AddUpdateAddressRemoteDataSourceImpl', () {
    const requestModel = AddUpdateAddressRequestModel(
      street: 'Test Street',
      phone: '01234567890',
      city: 'Cairo',
      lat: '30.0444',
      long: '31.2357',
      username: 'Test User',
    );

    final responseModel = AddUpdateAddressResponseModel(
      message: 'Address added successfully',
      address: [
        AddressModel(
          id: '123',
          street: 'Test Street',
          phone: '01234567890',
          city: 'Cairo',
          lat: '30.0444',
          long: '31.2357',
          username: 'Test User',
        ),
      ],
    );

    group('addAddress', () {
      test(
        'should return success BaseResponse when api client returns AddUpdateAddressResponseModel',
        () async {
          // Arrange
          when(
            mockApiClient.addAddress(requestModel),
          ).thenAnswer((_) async => responseModel);

          // Act
          final result = await dataSource.addAddress(requestModel);

          // Assert
          expect(result, isA<BaseResponse<AddUpdateAddressResponseModel>>());
          result.when(
            success: (data) {
              expect(data.message, 'Address added successfully');
              expect(data.address, responseModel.address);
              expect(data.address?.length, 1);
              expect(data.address?.first.id, '123');
              expect(data.address?.first.street, 'Test Street');
            },
            failure: (_) => fail('Expected success but got failure'),
          );

          verify(mockApiClient.addAddress(requestModel)).called(1);
          verifyNoMoreInteractions(mockApiClient);
        },
      );

      test(
        'should return failure BaseResponse when api client throws exception',
        () async {
          // Arrange
          when(
            mockApiClient.addAddress(requestModel),
          ).thenThrow(Exception('Network error'));

          // Act
          final result = await dataSource.addAddress(requestModel);

          // Assert
          expect(result, isA<BaseResponse<AddUpdateAddressResponseModel>>());
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

          verify(mockApiClient.addAddress(requestModel)).called(1);
          verifyNoMoreInteractions(mockApiClient);
        },
      );
    });

    group('updateAddress', () {
      const addressId = 'test-address-id-123';

      final updateResponseModel = AddUpdateAddressResponseModel(
        message: 'Address updated successfully',
        address: [
          AddressModel(
            id: addressId,
            street: 'Updated Street',
            phone: '01234567890',
            city: 'Alexandria',
            lat: '31.2001',
            long: '29.9187',
            username: 'Updated User',
          ),
        ],
      );

      test(
        'should return success BaseResponse when api client returns updated AddUpdateAddressResponseModel',
        () async {
          // Arrange
          when(
            mockApiClient.updateAddress(requestModel, addressId),
          ).thenAnswer((_) async => updateResponseModel);

          // Act
          final result = await dataSource.updateAddress(
            requestModel,
            addressId,
          );

          // Assert
          expect(result, isA<BaseResponse<AddUpdateAddressResponseModel>>());
          result.when(
            success: (data) {
              expect(data.message, 'Address updated successfully');
              expect(data.address, updateResponseModel.address);
              expect(data.address?.length, 1);
              expect(data.address?.first.id, addressId);
            },
            failure: (_) => fail('Expected success but got failure'),
          );

          verify(
            mockApiClient.updateAddress(requestModel, addressId),
          ).called(1);
          verifyNoMoreInteractions(mockApiClient);
        },
      );

      test(
        'should return failure BaseResponse when api client throws exception',
        () async {
          // Arrange
          when(
            mockApiClient.updateAddress(requestModel, addressId),
          ).thenThrow(Exception('Update failed'));

          // Act
          final result = await dataSource.updateAddress(
            requestModel,
            addressId,
          );

          // Assert
          expect(result, isA<BaseResponse<AddUpdateAddressResponseModel>>());
          result.when(
            success: (_) => fail('Expected failure but got success'),
            failure: (errorHandler) {
              expect(
                errorHandler.message,
                ErrorHandler.handle('Update failed').message,
              );
              expect(
                errorHandler.code,
                ErrorHandler.handle('Update failed').code,
              );
            },
          );

          verify(
            mockApiClient.updateAddress(requestModel, addressId),
          ).called(1);
          verifyNoMoreInteractions(mockApiClient);
        },
      );
    });
  });
}
