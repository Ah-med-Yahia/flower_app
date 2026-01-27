import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/add_update_adrees/api/api_clinet/add_update_adrees_api_client.dart';
import 'package:flower_app/features/add_update_adrees/api/data_source/remote/add_update_address_remote_data_source_impl.dart';
import 'package:flower_app/features/add_update_adrees/data/data_source/remote/add_update_address_remote_data_source.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_request_model.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_update_address_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AddUpdateAdreesApiClient])
void main() {
  late AddUpdateAddressRemoteDataSource dataSource;
  late MockAddUpdateAdreesApiClient mockAddUpdateAdreesApiClient;
  setUp(() {
    mockAddUpdateAdreesApiClient = MockAddUpdateAdreesApiClient();
    dataSource = AddUpdateAddressRemoteDataSourceImpl(
      mockAddUpdateAdreesApiClient,
    );
  });
  group('add address test', () {
    final addUpdateAddressRequestModel = AddUpdateAddressRequestModel(
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
    test(
      'should return success BaseResponse when api client returns addUpdateAddressResponseModel',
      () async {
        //arrange
        when(
          mockAddUpdateAdreesApiClient.addAddress(addUpdateAddressRequestModel),
        ).thenAnswer((_) async => addUpdateAddressResponseModel);
        //act
        final result = await dataSource.addAddress(
          addUpdateAddressRequestModel,
        );
        //assert
        expect(result, isA<BaseResponse<AddUpdateAddressResponseModel>>());
        result.when(
          success: (data) {
            expect(data.message, addUpdateAddressResponseModel.message);
            expect(data.address, addUpdateAddressResponseModel.address);
            expect(
              data.address?.first.id,
              addUpdateAddressResponseModel.address?.first.id,
            );
            expect(
              data.address?.first.street,
              addUpdateAddressResponseModel.address?.first.street,
            );
            expect(
              data.address?.first.phone,
              addUpdateAddressResponseModel.address?.first.phone,
            );
            expect(
              data.address?.first.city,
              addUpdateAddressResponseModel.address?.first.city,
            );
            expect(
              data.address?.first.lat,
              addUpdateAddressResponseModel.address?.first.lat,
            );
            expect(
              data.address?.first.long,
              addUpdateAddressResponseModel.address?.first.long,
            );
            expect(
              data.address?.first.username,
              addUpdateAddressResponseModel.address?.first.username,
            );
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(
          mockAddUpdateAdreesApiClient.addAddress(addUpdateAddressRequestModel),
        ).called(1);
      },
    );

    test(
      'should return failure BaseResponse when api client returns error',
      () async {
        //arrange
        when(
          mockAddUpdateAdreesApiClient.addAddress(addUpdateAddressRequestModel),
        ).thenAnswer((_) async => throw Exception('Network error'));
        //act
        final result = await dataSource.addAddress(
          addUpdateAddressRequestModel,
        );
        //assert
        expect(result, isA<BaseResponse<AddUpdateAddressResponseModel>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (errorHandler) {
            expect(errorHandler, isA<Exception>());
            expect(
              errorHandler.message,
              ErrorHandler.handle('Network error').message,
            );
            expect(
              errorHandler.code,
              ErrorHandler.handle('Network error').code,
            );
            // expect(error.toString(), 'Exception: error');
          },
        );
      },
    );
    test('should handle response with null address list', () async {
      //arrange
      final responseWithNullAddress = AddUpdateAddressResponseModel(
        message: 'success',
        address: null,
      );

      when(
        mockAddUpdateAdreesApiClient.addAddress(addUpdateAddressRequestModel),
      ).thenAnswer((_) async => responseWithNullAddress);

      //act
      final result = await dataSource.addAddress(addUpdateAddressRequestModel);

      //assert
      result.when(
        success: (data) {
          expect(data.message, 'success');
          expect(data.address, isNull);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test('should handle response with empty address list', () async {
      final responseWithEmptyAddress = AddUpdateAddressResponseModel(
        message: 'success',
        address: [],
      );

      when(
        mockAddUpdateAdreesApiClient.addAddress(addUpdateAddressRequestModel),
      ).thenAnswer((_) async => responseWithEmptyAddress);

      //act
      final result = await dataSource.addAddress(addUpdateAddressRequestModel);

      //assert
      result.when(
        success: (data) {
          expect(data.message, 'success');
          expect(data.address, isEmpty);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });
    test(
      'should return failure BaseResponse when DioException occurs',
      () async {
        when(
          mockAddUpdateAdreesApiClient.addAddress(addUpdateAddressRequestModel),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/address/add'),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        //act
        final result = await dataSource.addAddress(
          addUpdateAddressRequestModel,
        );

        //assert
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (errorHandler) {
            expect(errorHandler.message, isNotEmpty);
          },
        );
      },
    );
  });
  group('update address test', () {
    const String id = 'id';

    final addUpdateAddressRequestModel = AddUpdateAddressRequestModel(
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
    test(
      'should return success BaseResponse when api client returns addUpdateAddressResponseModel',
      () async {
        //arrange
        when(
          mockAddUpdateAdreesApiClient.updateAddress(
            addUpdateAddressRequestModel,
            id,
          ),
        ).thenAnswer((_) async => addUpdateAddressResponseModel);
        //act
        final result = await dataSource.updateAddress(
          addUpdateAddressRequestModel,
          id,
        );
        //assert
        expect(result, isA<BaseResponse<AddUpdateAddressResponseModel>>());
        result.when(
          success: (data) {
            expect(data.message, addUpdateAddressResponseModel.message);
            expect(data.address, addUpdateAddressResponseModel.address);
            expect(
              data.address?.first.id,
              addUpdateAddressResponseModel.address?.first.id,
            );
            expect(
              data.address?.first.street,
              addUpdateAddressResponseModel.address?.first.street,
            );
            expect(
              data.address?.first.phone,
              addUpdateAddressResponseModel.address?.first.phone,
            );
            expect(
              data.address?.first.city,
              addUpdateAddressResponseModel.address?.first.city,
            );
            expect(
              data.address?.first.lat,
              addUpdateAddressResponseModel.address?.first.lat,
            );
            expect(
              data.address?.first.long,
              addUpdateAddressResponseModel.address?.first.long,
            );
            expect(
              data.address?.first.username,
              addUpdateAddressResponseModel.address?.first.username,
            );
          },
          failure: (_) => fail('Expected success but got failure'),
        );
      },
    );
    test(
      'should return failure BaseResponse when api client returns error',
      () async {
        //arrange
        when(
          mockAddUpdateAdreesApiClient.updateAddress(
            addUpdateAddressRequestModel,
            id,
          ),
        ).thenAnswer((_) async => throw Exception('Network error'));
        //act
        final result = await dataSource.updateAddress(
          addUpdateAddressRequestModel,
          id,
        );
        //assert
        expect(result, isA<BaseResponse<AddUpdateAddressResponseModel>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (errorHandler) {
            expect(errorHandler, isA<Exception>());
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
      },
    );
    test('should handle response with null address list', () async {
      //arrange
      final responseWithNullAddress = AddUpdateAddressResponseModel(
        message: 'success',
        address: null,
      );

      when(
        mockAddUpdateAdreesApiClient.updateAddress(
          addUpdateAddressRequestModel,
          id,
        ),
      ).thenAnswer((_) async => responseWithNullAddress);

      //act
      final result = await dataSource.updateAddress(
        addUpdateAddressRequestModel,
        id,
      );

      //assert
      result.when(
        success: (data) {
          expect(data.message, 'success');
          expect(data.address, isNull);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test('should handle response with empty address list', () async {
      final responseWithEmptyAddress = AddUpdateAddressResponseModel(
        message: 'success',
        address: [],
      );

      when(
        mockAddUpdateAdreesApiClient.updateAddress(
          addUpdateAddressRequestModel,
          id,
        ),
      ).thenAnswer((_) async => responseWithEmptyAddress);

      //act
      final result = await dataSource.updateAddress(
        addUpdateAddressRequestModel,
        id,
      );

      //assert
      result.when(
        success: (data) {
          expect(data.message, 'success');
          expect(data.address, isEmpty);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });
    test(
      'should return failure BaseResponse when DioException occurs',
      () async {
        when(
          mockAddUpdateAdreesApiClient.updateAddress(
            addUpdateAddressRequestModel,
            id,
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/address/add'),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        //act
        final result = await dataSource.updateAddress(
          addUpdateAddressRequestModel,
          id,
        );

        //assert
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (errorHandler) {
            expect(errorHandler.message, isNotEmpty);
          },
        );
      },
    );
  });
}
