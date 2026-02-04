import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/categories/api/datasources_impl/remote_categories_data_source_impl.dart';
import 'package:flower_app/features/categories/data/models/get_all_categories_models/get_all_categories_response_model.dart';
import 'package:flower_app/features/categories/data/models/metadata/metadata_model.dart';
import 'package:flower_app/features/categories/data/repos/categories_repo_impl.dart';
import 'package:flower_app/features/categories/domain/entities/get_category_list_entity/category_entity.dart';
import 'package:flower_app/features/categories/domain/entities/get_category_list_entity/get_all_categories_list_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'categories_repo_impl_test.mocks.dart';

@GenerateMocks([RemoteCategoriesDataSourceImpl])
void main() {
  late CategoriesRepoImpl categoriesRepoImpl;
  late MockRemoteCategoriesDataSourceImpl mockDataSource;

  setUp(() {
    mockDataSource = MockRemoteCategoriesDataSourceImpl();
    categoriesRepoImpl = CategoriesRepoImpl(mockDataSource);
  });

  group('Categories Repo Implementation Test (get all categories function)', () {
    test('Test success case', () async {
      final mockCategoriesResponse = GetAllCategoriesResponseModel(
        message: 'Success',
        metadata: Metadata(
          currentPage: 1,
          totalPages: 1,
          limit: 2,
          totalItems: 50,
        ),
        categories: [],
      );

      when(
        mockDataSource.getAllCategories(),
      ).thenAnswer((_) async => BaseResponse.success(mockCategoriesResponse));

      final result = await categoriesRepoImpl.getAllCategories();

      expect(result, isA<Success<GetCategoryListEntity>>());
      final success = result as Success<GetCategoryListEntity>;
      expect(success.data.categories, isA<List<CategoryEntity>>());
      expect(success.data.categories!.length, 0);

      verify(mockDataSource.getAllCategories()).called(1);
    });

    test('should return BaseResponse.failure when datasource fails', () async {
      final fakeError = ErrorHandler.handle(Exception('API Failed'));

      when(
        mockDataSource.getAllCategories(),
      ).thenAnswer((_) async => BaseResponse.failure(fakeError));

      final result = await categoriesRepoImpl.getAllCategories();

      expect(result, isA<Failure<GetCategoryListEntity>>());

      final failureResult = result as Failure<GetCategoryListEntity>;

      expect(
        failureResult.errorHandler.errorModel.message,
        ErrorsConstant.defaultError,
      );

      expect(
        failureResult.errorHandler.errorModel.message,
        fakeError.errorModel.message,
      );

      expect(failureResult.errorHandler, isA<ErrorHandler>());

      verify(mockDataSource.getAllCategories()).called(1);
    });

    test(
      'should return BaseResponse.failure with correct error from error handler when datasource fails',
      () async {
        final dioError = DioException(
          requestOptions: RequestOptions(path: '/categories'),
          type: DioExceptionType.connectionError,
        );

        final handledError = ErrorHandler.handle(dioError);

        when(
          mockDataSource.getAllCategories(),
        ).thenAnswer((_) async => BaseResponse.failure(handledError));

        final result = await categoriesRepoImpl.getAllCategories();

        expect(result, isA<Failure<GetCategoryListEntity>>());

        final failure = result as Failure<GetCategoryListEntity>;

        expect(failure.errorHandler, same(handledError));

        expect(
          failure.errorHandler.errorModel.code,
          handledError.errorModel.code,
        );

        expect(
          failure.errorHandler.errorModel.message,
          handledError.errorModel.message,
        );

        verify(mockDataSource.getAllCategories()).called(1);
      },
    );
  });
}
