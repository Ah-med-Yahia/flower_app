import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/core/constants/api_errors_constants.dart';
import 'package:online_exam_app/features/occasion/api/api_client/occasion_api_client.dart';
import 'package:online_exam_app/features/occasion/api/datasources_impl/occasion_data_source_impl.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/metadata_model.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/occasion_model.dart';
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
  group(
    'occasion data source implementaion test (get all occasions function)',
    () {
      _testGetAllOccasionsSuccessCase(dataSource, mockApiClient);
      _testGetAllOccasionsFailureCase(dataSource, mockApiClient);
    },
  );
}

void _testGetAllOccasionsSuccessCase(
  OccasionDataSourceImpl dataSource,
  MockOccasionApiClient mockApiClient,
) {
  test('Test Success Case', () async {
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
  test('Test Error Case', () async {
    final dummyError = ErrorHandler.handle(
      Exception('Failed to fetch occasions'),
    );

    when(mockApiClient.getallOcassions()).thenThrow(dummyError);

    final result = await dataSource.getAllOccasions();

    expect(result, isA<Failure<GetAllOccasionsResponseModel>>());

    final failure = result as Failure<GetAllOccasionsResponseModel>;

    expect(failure.errorhandeler.apiErrorModel.message, ApiErrors.defaultError);

    verify(mockApiClient.getallOcassions()).called(1);
  });
}
