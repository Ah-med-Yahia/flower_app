import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/products/occasion/api/datasources_impl/remote_occasion_data_source_impl.dart';
import 'package:flower_app/features/products/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import 'package:flower_app/features/products/occasion/data/models/get_all_occassion_models/metadata_model.dart';
import 'package:flower_app/features/products/occasion/data/repos/occasion_repo_impl.dart';
import 'package:flower_app/features/products/occasion/domain/entities/get_all_occasions_list_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'remote_occasion_repo_impl_test.mocks.dart';

@GenerateMocks([RemoteOccasionDataSourceImpl])
void main() {
  late OccasionRepoImpl occasionRepoImpl;
  late MockRemoteOccasionDataSourceImpl mockDataSource;

  setUp(() {
    mockDataSource = MockRemoteOccasionDataSourceImpl();
    occasionRepoImpl = OccasionRepoImpl(mockDataSource);
  });

  group('getAllOccasions', () {
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

    test('should return Success entity when datasource succeeds', () async {
      when(
        mockDataSource.getAllOccasions(),
      ).thenAnswer((_) async => BaseResponse.success(mockResponse));

      final result = await occasionRepoImpl.getAllOccasions();

      expect(result, isA<Success<GetOccasionListEntity>>());
      verify(mockDataSource.getAllOccasions()).called(1);
    });

    test(
      'should return Failure entity when datasource returns failure',
      () async {
        final fakeError = ErrorHandler.handle(Exception('API Failed'));
        when(
          mockDataSource.getAllOccasions(),
        ).thenAnswer((_) async => BaseResponse.failure(fakeError));

        final result = await occasionRepoImpl.getAllOccasions();

        expect(result, isA<Failure<GetOccasionListEntity>>());
        final failure = result as Failure;
        expect(
          failure.errorHandler.errorModel.message,
          fakeError.errorModel.message,
        );
      },
    );

    test('should handle DioException correctly', () async {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/occasions'),
        type: DioExceptionType.connectionError,
      );
      final handledError = ErrorHandler.handle(dioError);

      when(
        mockDataSource.getAllOccasions(),
      ).thenAnswer((_) async => BaseResponse.failure(handledError));

      final result = await occasionRepoImpl.getAllOccasions();

      expect(result, isA<Failure<GetOccasionListEntity>>());
      expect((result as Failure).errorHandler, same(handledError));
    });
  });
}
