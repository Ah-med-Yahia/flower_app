import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/categories/api/api_service/categories_api_client.dart';
import 'package:flower_app/features/categories/api/datasources_impl/remote_categories_data_source_impl.dart';
import 'package:flower_app/features/categories/data/models/get_all_categories_models/category_model.dart';
import 'package:flower_app/features/categories/data/models/get_all_categories_models/get_all_categories_response_model.dart';
import 'package:flower_app/core/shared/data/models/get_products_models/products_response_model.dart';
import 'package:flower_app/core/shared/data/models/get_products_models/product_model.dart';
import 'package:flower_app/features/categories/data/models/metadata/category_metadata_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_categories_data_source_impl_test.mocks.dart';

@GenerateMocks([CategoriesApiClient])
void main() {
  late RemoteCategoriesDataSourceImpl dataSource;
  late MockCategoriesApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockCategoriesApiClient();
    dataSource = RemoteCategoriesDataSourceImpl(mockApiClient);
  });

  group(
    'categories data source implementation test (get all categories function)',
    () {
      test('Test Success Case', () async {
        final mockResponse = GetAllCategoriesResponseModel(
          message: 'Success',
          metadata: CategoryMetadataModel(
            currentPage: 1,
            totalPages: 1,
            limit: 2,
            totalItems: 50,
          ),
          categories: [],
        );

        when(
          mockApiClient.getAllCategories(),
        ).thenAnswer((_) async => mockResponse);

        final result = await dataSource.getAllCategories();

        expect(result, isA<Success<GetAllCategoriesResponseModel>>());
        final success = result as Success<GetAllCategoriesResponseModel>;
        expect(success.data.message, 'Success');
        expect(success.data.metadata, isA<CategoryMetadataModel>());
        expect(success.data.categories, isA<List<CategoryModel>>());
        verify(mockApiClient.getAllCategories()).called(1);
      });

      test('Test Error Case', () async {
        final dummyError = ErrorHandler.handle(
          Exception('Failed to fetch categories'),
        );

        when(mockApiClient.getAllCategories()).thenThrow(dummyError);

        final result = await dataSource.getAllCategories();

        expect(result, isA<Failure<GetAllCategoriesResponseModel>>());

        final failure = result as Failure<GetAllCategoriesResponseModel>;

        expect(
          failure.errorHandler.errorModel.message,
          ErrorsConstant.defaultError,
        );

        verify(mockApiClient.getAllCategories()).called(1);
      });
    },
  );

  group('get category products test cases', () {
    test('Test Success Case', () async {
      final mockResponse = ProductsResponseModel(
        message: 'Success',
        metadata: CategoryMetadataModel(
          currentPage: 1,
          totalPages: 1,
          limit: 2,
          totalItems: 50,
        ),
        products: [],
      );

      when(
        mockApiClient.getCategoryProducts(categoryId: anyNamed('categoryId')),
      ).thenAnswer((_) async => mockResponse);

      final result = await dataSource.getCategoryProducts(categoryId: '1');

      expect(result, isA<Success<ProductsResponseModel>>());
      final success = result as Success<ProductsResponseModel>;
      expect(success.data.message, 'Success');
      expect(success.data.metadata, isA<CategoryMetadataModel>());
      expect(success.data.products, isA<List<ProductModel>>());
      verify(mockApiClient.getCategoryProducts(categoryId: '1')).called(1);
    });

    test('Test Error Case', () async {
      final dummyError = ErrorHandler.handle(
        Exception('Failed to fetch products'),
      );

      when(
        mockApiClient.getCategoryProducts(categoryId: anyNamed('categoryId')),
      ).thenThrow(dummyError);

      final result = await dataSource.getCategoryProducts(categoryId: '1');

      expect(result, isA<Failure<ProductsResponseModel>>());

      final failure = result as Failure<ProductsResponseModel>;

      expect(
        failure.errorHandler.errorModel.message,
        ErrorsConstant.defaultError,
      );

      verify(mockApiClient.getCategoryProducts(categoryId: '1')).called(1);
    });
  });
}
