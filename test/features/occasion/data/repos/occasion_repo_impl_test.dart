import 'package:dio/dio.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/occasion/api/datasources_impl/remote_occasion_data_source_impl.dart';
import 'package:flower_app/features/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import 'package:flower_app/features/occasion/data/models/get_all_occassion_models/metadata_model.dart';
import 'package:flower_app/features/occasion/data/models/get_all_occassion_models/occasion_model.dart';
import 'package:flower_app/features/occasion/data/repos/occasion_repo_impl.dart';
import 'package:flower_app/features/occasion/domain/entities/get_all_occasion_entity.dart';
import 'package:test/test.dart';

import 'occasion_repo_impl_test.mocks.dart';

@GenerateMocks([RemoteOccasionDataSourceImpl])
void main() {
  late OccasionRepoImpl occasionRepoImpl;
  late MockRemoteOccasionDataSourceImpl mockDataSource;

  setUpAll(() {
    mockDataSource = MockRemoteOccasionDataSourceImpl();
    occasionRepoImpl = OccasionRepoImpl(mockDataSource);
  });
  group('Occasion Repo Implementation Test(get all occasions function)', () {
    _testGetAllOccasionsSuccessCase(occasionRepoImpl, mockDataSource);
    _testGetAllOccasionsFailureCase(occasionRepoImpl, mockDataSource);
    _testGetAllOccasionsDioFiluresCase(occasionRepoImpl, mockDataSource);
  });
}

void _testGetAllOccasionsSuccessCase(
  OccasionRepoImpl occasionRepoImpl,
  MockRemoteOccasionDataSourceImpl mockDataSource,
) {
  test('Test success case', () async {
    final mockOccasionsResponse = GetAllOccasionsResponseModel(
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
      mockDataSource.getAllOccasions(),
    ).thenAnswer((_) async => BaseResponse.success(mockOccasionsResponse));
    final result = await occasionRepoImpl.getAllOccasions();
    final success = result as Success<GetAllOccasionEntity>;
    expect(result, isA<GetAllOccasionEntity>());
    expect(success.data.occasions, isA<List<OccasionModel>>());
    expect(success.data.occasions!.length, 0);
    verify(mockDataSource.getAllOccasions()).called(1);
  });
}

void _testGetAllOccasionsFailureCase(
  OccasionRepoImpl occasionRepoImpl,
  MockRemoteOccasionDataSourceImpl mockDataSource,
) {
  test("should return BaseResponse.failure when datasource fails", () async {
    final fakeError = ErrorHandler.handle(Exception("API Failed"));

    when(
      mockDataSource.getAllOccasions(),
    ).thenAnswer((_) async => BaseResponse.failure(fakeError));

    final result = await occasionRepoImpl.getAllOccasions();

    expect(result, isA<Failure<GetAllOccasionEntity>>());

    final failureResult = result as Failure<GetAllOccasionEntity>;

    expect(
      failureResult.errorHandler.errorModel.message,
      ErrorsConstant.defaultError,
    );

    expect(
      failureResult.errorHandler.errorModel.message,
      fakeError.errorModel.message,
    );

    expect(failureResult.errorHandler, isA<ErrorHandler>());

    verify(mockDataSource.getAllOccasions()).called(1);
  });
}

void _testGetAllOccasionsDioFiluresCase(
  OccasionRepoImpl occasionRepoImpl,
  MockRemoteOccasionDataSourceImpl mockDataSource,
) {
  test(
    "should return BaseResponse.failure with correct error from error handler when datasource fails",
    () async {
      final dioError = DioException(
        requestOptions: RequestOptions(path: "/occasions"),
        type: DioExceptionType.connectionError,
      );

      final handledError = ErrorHandler.handle(dioError);

      when(
        mockDataSource.getAllOccasions(),
      ).thenAnswer((_) async => BaseResponse.failure(handledError));

      final result = await occasionRepoImpl.getAllOccasions();

      expect(result, isA<Failure<GetAllOccasionEntity>>());

      final failure = result as Failure<GetAllOccasionEntity>;

      expect(failure.errorHandler, same(handledError));

      expect(
        failure.errorHandler.errorModel.code,
        handledError.errorModel.code,
      );

      expect(
        failure.errorHandler.errorModel.message,
        handledError.errorModel.message,
      );

      verify(mockDataSource.getAllOccasions()).called(1);
    },
  );
}
