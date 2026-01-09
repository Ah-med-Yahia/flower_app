import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/features/occasion/api/datasources_impl/occasion_data_source_impl.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/metadata_model.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/occasion_model.dart';
import 'package:online_exam_app/features/occasion/data/models/get_occasion_products_models/get_occasion_products_response_model.dart';
import 'package:online_exam_app/features/occasion/data/models/get_occasion_products_models/product_metadata_model.dart';
import 'package:online_exam_app/features/occasion/data/repos/occasion_repo_impl.dart';
import 'package:online_exam_app/features/occasion/domain/entities/get_all_occasion_entity.dart';
import 'package:online_exam_app/features/occasion/domain/entities/get_occasion_products_entity.dart';
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
  group('Occasion Repo Implementation Test', () {
    _testGetAllOccasionsSuccessCase(occasionRepoImpl, mockDataSource);
    _testGetAllOccasionsFailureCase(occasionRepoImpl, mockDataSource);
    _testGetAllOccasionsDioFiluresCase(occasionRepoImpl, mockDataSource);
    _testGetOccasionProductsSuccessCase(occasionRepoImpl, mockDataSource);
    _testGetOccasionProductsFailureCase(occasionRepoImpl, mockDataSource);
    _testGetOccasionProductsDioFailureCase(occasionRepoImpl, mockDataSource);
  });
}

void _testGetAllOccasionsSuccessCase(
  OccasionRepoImpl occasionRepoImpl,
  MockOccasionDataSourceImpl mockDataSource,
) {
  test(
    'should return Success<GetAllOccasionEntity> when datasource succeeds',
    () async {
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

      expect(result, isA<Success<GetAllOccasionEntity>>());
      expect(success.data.occasions, isA<List<OccasionModel>>());
      expect(success.data.occasions!.length, 0);

      verify(mockDataSource.getAllOccasions()).called(1);
    },
  );
}

void _testGetAllOccasionsFailureCase(
  OccasionRepoImpl occasionRepoImpl,
  MockOccasionDataSourceImpl mockDataSource,
) {
  test(
    'should return Failure<GetAllOccasionEntity> when datasource returns failure',
    () async {
      final fakeError = ErrorHandler.handle(Exception("API Failed"));

      when(
        mockDataSource.getAllOccasions(),
      ).thenAnswer((_) async => BaseResponse.failure(fakeError));

      final result = await occasionRepoImpl.getAllOccasions();
      final failureResult = result as Failure<GetAllOccasionEntity>;

      expect(result, isA<Failure<GetAllOccasionEntity>>());
      expect(
        failureResult.errorhandeler.apiErrorModel.message,
        fakeError.apiErrorModel.message,
      );
      expect(failureResult.errorhandeler, isA<ErrorHandler>());

      verify(mockDataSource.getAllOccasions()).called(1);
    },
  );
}

void _testGetAllOccasionsDioFiluresCase(
  OccasionRepoImpl occasionRepoImpl,
  MockOccasionDataSourceImpl mockDataSource,
) {
  test(
    'should return Failure<GetAllOccasionEntity> with handled DioException when datasource fails',
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
      final failure = result as Failure<GetAllOccasionEntity>;

      expect(result, isA<Failure<GetAllOccasionEntity>>());
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

void _testGetOccasionProductsSuccessCase(
  OccasionRepoImpl occasionRepoImpl,
  MockOccasionDataSourceImpl mockDataSource,
) {
  test(
    'should return Success<GetOccasionProductsEntity> when datasource succeeds',
    () async {
      const occasionId = '123';
      final mockResponse = GetOccasionProductsResponseModel(
        message: 'Success',
        metadata: ProductMetadataModel(
          currentPage: 1,
          totalPages: 1,
          limit: 10,
          totalItems: 0,
        ),
        products: [],
      );

      when(
        mockDataSource.getOccasionProducts(occasionId),
      ).thenAnswer((_) async => BaseResponse.success(mockResponse));

      final result = await occasionRepoImpl.getOccasionProducts(occasionId);
      final success = result as Success<GetOccasionProductsEntity>;

      expect(result, isA<Success<GetOccasionProductsEntity>>());
      expect(success.data.products, isA<List>());
      expect(success.data.products.length, 0);

      verify(mockDataSource.getOccasionProducts(occasionId)).called(1);
    },
  );
}

void _testGetOccasionProductsFailureCase(
  OccasionRepoImpl occasionRepoImpl,
  MockOccasionDataSourceImpl mockDataSource,
) {
  test(
    'should return Failure<GetOccasionProductsEntity> when datasource returns failure',
    () async {
      const occasionId = '123';
      final fakeError = ErrorHandler.handle(Exception('API Failed'));

      when(
        mockDataSource.getOccasionProducts(occasionId),
      ).thenAnswer((_) async => BaseResponse.failure(fakeError));

      final result = await occasionRepoImpl.getOccasionProducts(occasionId);
      final failure = result as Failure<GetOccasionProductsEntity>;

      expect(result, isA<Failure<GetOccasionProductsEntity>>());
      expect(
        failure.errorhandeler.apiErrorModel.message,
        fakeError.apiErrorModel.message,
      );

      verify(mockDataSource.getOccasionProducts(occasionId)).called(1);
    },
  );
}

void _testGetOccasionProductsDioFailureCase(
  OccasionRepoImpl occasionRepoImpl,
  MockOccasionDataSourceImpl mockDataSource,
) {
  test(
    'should return Failure<GetOccasionProductsEntity> with handled DioException when datasource fails',
    () async {
      const occasionId = '123';
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/related/occasion/$occasionId'),
        type: DioExceptionType.connectionError,
      );
      final handledError = ErrorHandler.handle(dioError);

      when(
        mockDataSource.getOccasionProducts(occasionId),
      ).thenAnswer((_) async => BaseResponse.failure(handledError));

      final result = await occasionRepoImpl.getOccasionProducts(occasionId);
      final failure = result as Failure<GetOccasionProductsEntity>;

      expect(result, isA<Failure<GetOccasionProductsEntity>>());
      expect(failure.errorhandeler, same(handledError));
      expect(
        failure.errorhandeler.apiErrorModel.code,
        handledError.apiErrorModel.code,
      );

      verify(mockDataSource.getOccasionProducts(occasionId)).called(1);
    },
  );
}
