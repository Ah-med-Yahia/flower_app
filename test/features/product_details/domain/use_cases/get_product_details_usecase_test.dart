import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/products/product_details/domain/models/product_response_model.dart';
import 'package:flower_app/features/products/product_details/domain/repo/product_details_repo_contract.dart';
import 'package:flower_app/features/products/product_details/domain/use_cases/get_product_details_usecase.dart';

import 'get_product_details_usecase_test.mocks.dart';

@GenerateMocks([ProductDetailsRepoContract])
void main() {
  late MockProductDetailsRepoContract mockRepo;
  late GetProductDetailsUsecase useCase;

  setUp(() {
    mockRepo = MockProductDetailsRepoContract();
    useCase = GetProductDetailsUsecase(mockRepo);
  });

  group('GetProductDetailsUsecase', () {
    const productId = '123';
    final mockProduct = ProductEntity(
      id: productId,
      title: 'Test Product',
      description: 'Test description',
      imageCover: 'cover.jpg',
      images: ['img1.jpg'],
      price: 100,
      priceAfterDiscount: 80,
      quantity: 10,
      categoryId: 'electronics',
      occasionId: 'sale',
    );

    test('should return success when repository call succeeds', () async {
      // Arrange
      final mockResponse = ProductResponseModel(
        message: 'success',
        product: mockProduct,
      );

      when(
        mockRepo.getProductDetails(productId),
      ).thenAnswer((_) async => BaseResponse.success(mockResponse));

      // Act
      final result = await useCase(productId);

      // Assert
      result.when(
        success: (data) {
          expect(data.message, 'success');
          expect(data.product.id, productId);
        },
        failure: (_) => fail('Expected success but got failure'),
      );

      verify(mockRepo.getProductDetails(productId)).called(1);
    });

    test('should return failure when repository call fails', () async {
      // Arrange

      when(mockRepo.getProductDetails(productId)).thenAnswer(
        (_) async =>
            BaseResponse.failure(ErrorHandler.handle("'Product not found'")),
      );

      // Act
      final result = await useCase(productId);

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isNotNull);
          expect(error.message, isNotEmpty);
        },
      );

      verify(mockRepo.getProductDetails(productId)).called(1);
    });
  });
}
