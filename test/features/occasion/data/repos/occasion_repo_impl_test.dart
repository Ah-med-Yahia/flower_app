import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/core/constants/api_errors_constants.dart';
import 'package:online_exam_app/features/occasion/api/datasources_impl/occasion_data_source_impl.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/metadata_model.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/occasion_model.dart';
import 'package:online_exam_app/features/occasion/data/repos/occasion_repo_impl.dart';
import 'package:online_exam_app/features/occasion/domain/entities/get_all_occasion_entity.dart';
import 'package:test/test.dart';

import 'occasion_repo_impl_test.mocks.dart';

@GenerateMocks([OccasionDataSourceImpl])
void main() {
  late OccasionRepoImpl occasionRepoImpl;
  late MockOccasionDataSourceImpl mockDataSource;

  setUpAll(() {
    mockDataSource = MockOccasionDataSourceImpl();
    occasionRepoImpl = OccasionRepoImpl(
      occasionDataSourceContract: mockDataSource,
    );
  });
  group('Occasion Repo Implementation Test(get all occasions function)', () {
    _testGetAllOccasionsSuccessCase(occasionRepoImpl, mockDataSource);
    _testGetAllOccasionsFailureCase(occasionRepoImpl, mockDataSource);
    _testGetAllOccasionsDioFiluresCase(occasionRepoImpl, mockDataSource);
  });
}

void _testGetAllOccasionsSuccessCase(
  OccasionRepoImpl occasionRepoImpl,
  MockOccasionDataSourceImpl mockDataSource,
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
  MockOccasionDataSourceImpl mockDataSource,
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
      failureResult.errorhandeler.apiErrorModel.message,
      ApiErrors.defaultError,
    );

    expect(
      failureResult.errorhandeler.apiErrorModel.message,
      fakeError.apiErrorModel.message,
    );

    expect(failureResult.errorhandeler, isA<ErrorHandler>());

    verify(mockDataSource.getAllOccasions()).called(1);
  });
}

void _testGetAllOccasionsDioFiluresCase(
  OccasionRepoImpl occasionRepoImpl,
  MockOccasionDataSourceImpl mockDataSource,
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

      expect(failure.errorhandeler, same(handledError));

      expect(
        failure.errorhandeler.apiErrorModel.code,
        handledError.apiErrorModel.code,
      );

      expect(
        failure.errorhandeler.apiErrorModel.message,
        handledError.apiErrorModel.message,
      );

      verify(mockDataSource.getAllOccasions()).called(1);
    },
  );
}
