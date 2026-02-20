import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/products/occasion/api/api_client/occasion_api_client.dart';
import 'package:flower_app/features/products/occasion/api/datasources_impl/remote_occasion_data_source_impl.dart';
import 'package:flower_app/features/products/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import 'package:flower_app/features/products/occasion/data/models/get_all_occassion_models/metadata_model.dart';
import 'package:flower_app/features/products/occasion/data/models/get_all_occassion_models/occasion_model.dart';
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
  });
}
