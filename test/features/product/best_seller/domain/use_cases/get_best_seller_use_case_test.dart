import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/product/best_seller/domain/entities/best_seller.dart';
import 'package:flower_app/features/product/best_seller/domain/entities/best_seller_response.dart';
import 'package:flower_app/features/product/best_seller/domain/entities/pagination_meta_data.dart';
import 'package:flower_app/features/product/best_seller/domain/repos/best_seller_repo.dart';
import 'package:flower_app/features/product/best_seller/domain/use_cases/get_best_seller_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_best_seller_use_case_test.mocks.dart';

@GenerateMocks([BestSellerRepo])
void main() {
  late MockBestSellerRepo mockBestSellerRepo;
  late GetBestSellerUseCase useCase;

  setUp(() {
    mockBestSellerRepo = MockBestSellerRepo();
    useCase = GetBestSellerUseCase(mockBestSellerRepo);
  });

  group('call', () {
    _testSuccessfulCallWithSingleItem(() => mockBestSellerRepo, () => useCase);
    _testSuccessfulCallWithMultipleItems(() => mockBestSellerRepo, () => useCase);
    _testSuccessfulCallWithEmptyList(() => mockBestSellerRepo, () => useCase);
    _testSuccessfulCallWithNullBestSellerList(() => mockBestSellerRepo, () => useCase);
    _testFailureWhenRepositoryReturnsFailure(() => mockBestSellerRepo, () => useCase);
    _testSuccessWithPaginationMetadata(() => mockBestSellerRepo, () => useCase);
    _testNoMoreThanOncePerInvocation(() => mockBestSellerRepo, () => useCase);
    _testDelegateToRepositoryAndReturnExactResponse(() => mockBestSellerRepo, () => useCase);
  });
}

void _testSuccessfulCallWithSingleItem(
    MockBestSellerRepo Function() getMockBestSellerRepo,
    GetBestSellerUseCase Function() getUseCase,) {
  test(
    'When call use case, '
        'it should return Success with BestSellerResponse when repository call succeeds',
        () async {
      final mockBestSellerRepo = getMockBestSellerRepo();
      final useCase = getUseCase();

      // Arrange
      final mockResponse = BestSellerResponse(
        message: 'success',
        bestSeller: [
          BestSeller(
            id: '1',
            title: 'Product 1',
            imgCover: 'img1.jpg',
            price: 100,
            priceAfterDiscount: 90,
            quantity: 10,
            sold: 5,
            bestSellerId: 'bs1',
            discount: 10,
          ),
        ],
        paginationMetadata: PaginationMetadata(
          currentPage: 1,
          numberOfPages: 1,
          limit: 10,
          total: 1,
        ),
      );
      when(
        mockBestSellerRepo.getBestSeller(),
      ).thenAnswer((_) async => BaseResponse.success(mockResponse));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<Success<BestSellerResponse>>());
      result.when(
        success: (data) {
          expect(data, isA<BestSellerResponse>());
          expect(data.message, 'success');
          expect(data.bestSeller?.length, 1);
          expect(data.bestSeller?.first.id, '1');
          expect(data.bestSeller?.first.title, 'Product 1');
        },
        failure: (_) => fail('Expected success but got failure'),
      );
      verify(mockBestSellerRepo.getBestSeller()).called(1);
    },
  );
}

void _testSuccessfulCallWithMultipleItems(
    MockBestSellerRepo Function() getMockBestSellerRepo,
    GetBestSellerUseCase Function() getUseCase,) {
  test(
    'When call use case, '
        'it should return Success with multiple items when repository returns multiple items',
        () async {
      final mockBestSellerRepo = getMockBestSellerRepo();
      final useCase = getUseCase();

      // Arrange
      final mockResponse = BestSellerResponse(
        message: 'success',
        bestSeller: [
          BestSeller(
            id: '1',
            title: 'Product 1',
            imgCover: 'img1.jpg',
            price: 100,
            priceAfterDiscount: 90,
            quantity: 10,
            sold: 5,
            bestSellerId: 'bs1',
            discount: 10,
          ),
          BestSeller(
            id: '2',
            title: 'Product 2',
            imgCover: 'img2.jpg',
            price: 200,
            priceAfterDiscount: 180,
            quantity: 20,
            sold: 10,
            bestSellerId: 'bs2',
            discount: 20,
          ),
        ],
        paginationMetadata: PaginationMetadata(
          currentPage: 1,
          numberOfPages: 1,
          limit: 10,
          total: 2,
        ),
      );
      when(
        mockBestSellerRepo.getBestSeller(),
      ).thenAnswer((_) async => BaseResponse.success(mockResponse));

      // Act
      final result = await useCase.call();

      // Assert
      result.when(
        success: (data) {
          expect(data.bestSeller?.length, 2);
          expect(data.bestSeller?[0].id, '1');
          expect(data.bestSeller?[1].id, '2');
          expect(data.paginationMetadata?.total, 2);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
      verify(mockBestSellerRepo.getBestSeller()).called(1);
    },
  );
}

void _testSuccessfulCallWithEmptyList(
    MockBestSellerRepo Function() getMockBestSellerRepo,
    GetBestSellerUseCase Function() getUseCase,) {
  test(
    'When call use case, '
        'it should return Success with empty list when repository returns empty list',
        () async {
      final mockBestSellerRepo = getMockBestSellerRepo();
      final useCase = getUseCase();

      // Arrange
      final mockResponse = BestSellerResponse(
        message: 'No items',
        bestSeller: [],
        paginationMetadata: PaginationMetadata(
          currentPage: 1,
          numberOfPages: 0,
          limit: 10,
          total: 0,
        ),
      );
      when(
        mockBestSellerRepo.getBestSeller(),
      ).thenAnswer((_) async => BaseResponse.success(mockResponse));

      // Act
      final result = await useCase.call();

      // Assert
      result.when(
        success: (data) {
          expect(data.message, 'No items');
          expect(data.bestSeller, isEmpty);
          expect(data.paginationMetadata?.total, 0);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
      verify(mockBestSellerRepo.getBestSeller()).called(1);
    },
  );
}

void _testSuccessfulCallWithNullBestSellerList(
    MockBestSellerRepo Function() getMockBestSellerRepo,
    GetBestSellerUseCase Function() getUseCase,) {
  test(
    'When call use case, '
        'it should return Success with null best seller list when repository returns null',
        () async {
      final mockBestSellerRepo = getMockBestSellerRepo();
      final useCase = getUseCase();

      // Arrange
      final mockResponse = BestSellerResponse(
        message: 'success',
        bestSeller: null,
        paginationMetadata: null,
      );
      when(
        mockBestSellerRepo.getBestSeller(),
      ).thenAnswer((_) async => BaseResponse.success(mockResponse));

      // Act
      final result = await useCase.call();

      // Assert
      result.when(
        success: (data) {
          expect(data.bestSeller, isNull);
          expect(data.paginationMetadata, isNull);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
      verify(mockBestSellerRepo.getBestSeller()).called(1);
    },
  );
}

void _testFailureWhenRepositoryReturnsFailure(
    MockBestSellerRepo Function() getMockBestSellerRepo,
    GetBestSellerUseCase Function() getUseCase,) {
  test('When call use case, '
      'it should return Failure when repository returns Failure', () async {
    final mockBestSellerRepo = getMockBestSellerRepo();
    final useCase = getUseCase();

    // Arrange
    final mockErrorHandler = ErrorHandler.handle(Exception('Network error'));
    when(
      mockBestSellerRepo.getBestSeller(),
    ).thenAnswer((_) async => BaseResponse.failure(mockErrorHandler));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, isA<Failure<BestSellerResponse>>());
    result.when(
      success: (_) => fail('Expected failure but got success'),
      failure: (errorHandler) {
        expect(errorHandler, isA<ErrorHandler>());
      },
    );
    verify(mockBestSellerRepo.getBestSeller()).called(1);
  });
}

void _testSuccessWithPaginationMetadata(
    MockBestSellerRepo Function() getMockBestSellerRepo,
    GetBestSellerUseCase Function() getUseCase,) {
  test(
    'When call use case, '
        'it should return Success with pagination metadata when repository returns data with pagination',
        () async {
      final mockBestSellerRepo = getMockBestSellerRepo();
      final useCase = getUseCase();

      // Arrange
      final mockResponse = BestSellerResponse(
        message: 'success',
        bestSeller: List.generate(
          25,
              (index) =>
              BestSeller(
                id: '$index',
                title: 'Product $index',
                imgCover: 'img$index.jpg',
                price: 100,
                priceAfterDiscount: 90,
                quantity: 10,
                sold: 5,
                bestSellerId: 'bs$index',
                discount: 10,
              ),
        ),
        paginationMetadata: PaginationMetadata(
          currentPage: 1,
          numberOfPages: 3,
          limit: 10,
          total: 25,
        ),
      );
      when(
        mockBestSellerRepo.getBestSeller(),
      ).thenAnswer((_) async => BaseResponse.success(mockResponse));

      // Act
      final result = await useCase.call();

      // Assert
      result.when(
        success: (data) {
          expect(data.bestSeller?.length, 25);
          expect(data.paginationMetadata, isNotNull);
          expect(data.paginationMetadata?.currentPage, 1);
          expect(data.paginationMetadata?.numberOfPages, 3);
          expect(data.paginationMetadata?.limit, 10);
          expect(data.paginationMetadata?.total, 25);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
      verify(mockBestSellerRepo.getBestSeller()).called(1);
    },
  );
}

void _testNoMoreThanOncePerInvocation(
    MockBestSellerRepo Function() getMockBestSellerRepo,
    GetBestSellerUseCase Function() getUseCase,) {
  test(
    'When call use case, '
        'it should not call repository more than once per invocation',
        () async {
      final mockBestSellerRepo = getMockBestSellerRepo();
      final useCase = getUseCase();

      // Arrange
      final mockResponse = BestSellerResponse(
        message: 'success',
        bestSeller: [],
      );
      when(
        mockBestSellerRepo.getBestSeller(),
      ).thenAnswer((_) async => BaseResponse.success(mockResponse));

      // Act
      await useCase.call();

      // Assert
      verify(mockBestSellerRepo.getBestSeller()).called(1);
      verifyNoMoreInteractions(mockBestSellerRepo);
    },
  );
}

void _testDelegateToRepositoryAndReturnExactResponse(
    MockBestSellerRepo Function() getMockBestSellerRepo,
    GetBestSellerUseCase Function() getUseCase,) {
  test(
    'When call use case, '
        'it should delegate to repository and return the exact response from repository',
        () async {
      final mockBestSellerRepo = getMockBestSellerRepo();
      final useCase = getUseCase();

      // Arrange
      final mockResponse = BestSellerResponse(
        message: 'custom message',
        bestSeller: [
          BestSeller(
            id: 'unique-id',
            title: 'Unique Product',
            imgCover: 'unique.jpg',
            price: 999,
            priceAfterDiscount: 899,
            quantity: 5,
            sold: 3,
            bestSellerId: 'unique-bs',
            discount: 100,
          ),
        ],
      );
      final expectedResult = BaseResponse.success(mockResponse);
      when(
        mockBestSellerRepo.getBestSeller(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, equals(expectedResult));
      verify(mockBestSellerRepo.getBestSeller()).called(1);
    },
  );
}
