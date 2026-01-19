import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/api_errors_constants.dart';
import 'package:flower_app/features/occasion/api/api_client/occasion_api_client.dart';
import 'package:flower_app/features/occasion/api/datasources_impl/occasion_data_source_impl.dart';
import 'package:flower_app/features/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import 'package:flower_app/features/occasion/data/models/get_all_occassion_models/metadata_model.dart';
import 'package:flower_app/features/occasion/data/models/get_all_occassion_models/occasion_model.dart';
import 'package:flower_app/features/occasion/data/models/get_occasion_products_models/get_occasion_products_response_model.dart';
import 'package:flower_app/features/occasion/data/models/get_occasion_products_models/product_metadata_model.dart';
import 'package:flower_app/features/occasion/data/models/get_occasion_products_models/product_model.dart';
import 'package:test/test.dart';
import 'occasion_data_source_impl_test.mocks.dart';

@GenerateMocks([OccasionApiClient])
void main() {
  late OccasionDataSourceImpl dataSource;
  late MockOccasionApiClient mockApiClient;
  setUpAll(() {
    mockApiClient = MockOccasionApiClient();
    dataSource = OccasionDataSourceImpl(mockApiClient);
  });
  group('occasion data source implementaion test', () {
    _testGetAllOccasionsSuccessCase(dataSource, mockApiClient);
    _testGetAllOccasionsFailureCase(dataSource, mockApiClient);
    _testGetOccasionProductsSuccessCase(dataSource, mockApiClient);
    _testGetOccasionProductsErrorCase(dataSource, mockApiClient);
  });
}

void _testGetAllOccasionsSuccessCase(
  OccasionDataSourceImpl dataSource,
  MockOccasionApiClient mockApiClient,
) {
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
    when(mockApiClient.getallOcassions()).thenAnswer((_) async => mockResponse);
    final result = await dataSource.getAllOccasions();
    final success = result as Success<GetAllOccasionsResponseModel>;
    expect(result, isA<GetAllOccasionsResponseModel>());
    expect(success.data.message, 'Success');
    expect(success.data.metadata, isA<MetadataModel>());
    expect(success.data.occasions, isA<List<OccasionModel>>());
    verify(mockApiClient.getallOcassions()).called(1);
  });
}

void _testGetAllOccasionsFailureCase(
  OccasionDataSourceImpl dataSource,
  MockOccasionApiClient mockApiClient,
) {
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
}

void _testGetOccasionProductsSuccessCase(
  OccasionDataSourceImpl dataSource,
  MockOccasionApiClient mockApiClient,
) {
  test('Test get occasion products Success Case', () async {
    final mockResponse = GetOccasionProductsResponseModel(
      message: 'Success',
      metadata: ProductMetadataModel(
        currentPage: 1,
        totalPages: 1,
        limit: 2,
        totalItems: 50,
      ),
      products: [],
    );
    when(
      mockApiClient.getOccasionProducts(id: any),
    ).thenAnswer((_) async => mockResponse);
    final result = await dataSource.getOccasionProducts('');
    final success = result as Success<GetOccasionProductsResponseModel>;
    expect(result, isA<GetOccasionProductsResponseModel>());
    expect(success.data.message, 'Success');
    expect(success.data.metadata, isA<ProductMetadataModel>());
    expect(success.data.products, isA<List<ProductModel>>());
    verify(mockApiClient.getOccasionProducts(id: any)).called(1);
  });
}

void _testGetOccasionProductsErrorCase(
  OccasionDataSourceImpl dataSource,
  MockOccasionApiClient mockApiClient,
) {
  test('Test get occasion products Error Case', () async {
    final dummyError = ErrorHandler.handle(
      Exception('Failed to fetch occasion products'),
    );
    when(mockApiClient.getOccasionProducts(id: any)).thenThrow(dummyError);
    final result = await dataSource.getOccasionProducts('');
    expect(result, isA<Failure<GetOccasionProductsResponseModel>>());
    final failure = result as Failure<GetOccasionProductsResponseModel>;
    expect(failure.errorhandeler.apiErrorModel.message, ApiErrors.defaultError);
    verify(mockApiClient.getOccasionProducts(id: any)).called(1);
  });
}
