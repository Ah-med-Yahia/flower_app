import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/occasion/api/api_client/occasion_api_client.dart';
import 'package:flower_app/features/occasion/api/datasources_impl/remote_occasion_data_source_impl.dart';
import 'package:flower_app/features/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import 'package:flower_app/features/occasion/data/models/get_all_occassion_models/metadata_model.dart';
import 'package:flower_app/features/occasion/data/models/get_all_occassion_models/occasion_model.dart';
import 'package:flower_app/features/occasion/data/models/get_occasion_products_models/get_occasion_products_response_model.dart';
import 'package:flower_app/features/occasion/data/models/get_occasion_products_models/product_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'remote_occasion_data_source_impl_test.mocks.dart';

@GenerateMocks([OccasionApiClient])
void main() {
  late RemoteOccasionDataSourceImpl dataSource;
  late MockOccasionApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockOccasionApiClient();
    dataSource = RemoteOccasionDataSourceImpl(mockApiClient);
  });

  group('occasion data source implementation test', () {
    test('Test get all occasions Success Case', () async {
      final mockResponse = GetAllOccasionsResponseModel(
        message: 'Success',
        metadata: MetadataModel(
          currentPage: 1,
          totalPages: 1,
          limit: 2,
          totalItems: 50,
        ),
        occasions: [],
      );
      when(
        mockApiClient.getallOcassions(),
      ).thenAnswer((_) async => mockResponse);
      final result = await dataSource.getAllOccasions();
      final success = result as Success<GetAllOccasionsResponseModel>;
      expect(result, isA<Success<GetAllOccasionsResponseModel>>());
      expect(success.data.message, 'Success');
      expect(success.data.metadata, isA<MetadataModel>());
      expect(success.data.occasions, isA<List<OccasionModel>>());
      verify(mockApiClient.getallOcassions()).called(1);
    });

    test('Test get all occasions Error Case', () async {
      final dummyError = ErrorHandler.handle(
        Exception('Failed to fetch occasions'),
      );

      when(mockApiClient.getallOcassions()).thenThrow(dummyError);

      final result = await dataSource.getAllOccasions();

      expect(result, isA<Failure<GetAllOccasionsResponseModel>>());

      final failure = result as Failure<GetAllOccasionsResponseModel>;

      expect(
        failure.errorHandler.errorModel.message,
        ErrorsConstant.defaultError,
      );

      verify(mockApiClient.getallOcassions()).called(1);
    });

    test('Test get occasion products Success Case', () async {
      const mockResponse = GetOccasionProductsResponseModel(
        message: 'Success',
        product: ProductModel(
          id: '1',
          name: 'Rose Bouquet',
          image: 'https://example.com/rose_bouquet.jpg',
          slug: 'Rose-Bouquet',
          createdAt: 'fake_date',
          updatedAt: 'fake_date',
          isSuperAdmin: false,
        ),
      );
      when(
        mockApiClient.getOccasionProducts(id: anyNamed('id')),
      ).thenAnswer((_) async => mockResponse);
      final result = await dataSource.getOccasionProducts('');
      final success = result as Success<GetOccasionProductsResponseModel>;
      expect(result, isA<Success<GetOccasionProductsResponseModel>>());
      expect(success.data.message, 'Success');
      expect(success.data.product, isA<ProductModel>());
      expect(success.data.product?.id, '1');
      expect(success.data.product?.name, 'Rose Bouquet');
      expect(
        success.data.product?.image,
        'https://example.com/rose_bouquet.jpg',
      );
      verify(mockApiClient.getOccasionProducts(id: anyNamed('id'))).called(1);
    });

    test('Test get occasion products Error Case', () async {
      final dummyError = ErrorHandler.handle(
        Exception('Failed to fetch occasion products'),
      );
      when(
        mockApiClient.getOccasionProducts(id: anyNamed('id')),
      ).thenThrow(dummyError);
      final result = await dataSource.getOccasionProducts('');
      expect(result, isA<Failure<GetOccasionProductsResponseModel>>());
      final failure = result as Failure<GetOccasionProductsResponseModel>;
      expect(
        failure.errorHandler.errorModel.message,
        ErrorsConstant.defaultError,
      );
      verify(mockApiClient.getOccasionProducts(id: anyNamed('id'))).called(1);
    });
  });
}
