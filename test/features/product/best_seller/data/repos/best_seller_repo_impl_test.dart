import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/features/product/best_seller/data/datasource/remote/best_seller_remote_data_source.dart';
import 'package:online_exam_app/features/product/best_seller/data/models/best_seller_dto.dart';
import 'package:online_exam_app/features/product/best_seller/data/models/best_seller_response_dto.dart';
import 'package:online_exam_app/features/product/best_seller/data/repos/best_seller_repo_impl.dart';
import 'package:online_exam_app/features/product/best_seller/domain/entities/best_seller_response.dart';

import 'best_seller_repo_impl_test.mocks.dart';

@GenerateMocks([BestSellerRemoteDataSource])
void main() {
  late BestSellerRepoImpl repository;
  late MockBestSellerRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockBestSellerRemoteDataSource();
    repository = BestSellerRepoImpl(mockRemoteDataSource);
  });

  group('getBestSeller', () {
    test(
      'When call getBestSeller, '
      'it should return Success with BestSellerResponse when remote data source call succeeds',
      () async {
        // Arrange
        final mockDto = BestSellerResponseDto(
          message: 'success',
          bestSellerDto: [
            BestSellerDto(
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
        );
        when(
          mockRemoteDataSource.getBestSeller(),
        ).thenAnswer((_) async => mockDto);

        // Act
        final result = await repository.getBestSeller();

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
        verify(mockRemoteDataSource.getBestSeller()).called(1);
      },
    );

    test(
      'When call getBestSeller, '
      'it should return Success with multiple items when remote data source returns multiple items',
      () async {
        // Arrange
        final mockDto = BestSellerResponseDto(
          message: 'success',
          bestSellerDto: [
            BestSellerDto(
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
            BestSellerDto(
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
            BestSellerDto(
              id: '3',
              title: 'Product 3',
              imgCover: 'img3.jpg',
              price: 300,
              priceAfterDiscount: 270,
              quantity: 30,
              sold: 15,
              bestSellerId: 'bs3',
              discount: 30,
            ),
          ],
        );
        when(
          mockRemoteDataSource.getBestSeller(),
        ).thenAnswer((_) async => mockDto);

        // Act
        final result = await repository.getBestSeller();

        // Assert
        result.when(
          success: (data) {
            expect(data.bestSeller?.length, 3);
            expect(data.bestSeller?[0].id, '1');
            expect(data.bestSeller?[1].id, '2');
            expect(data.bestSeller?[2].id, '3');
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockRemoteDataSource.getBestSeller()).called(1);
      },
    );

    test(
      'When call getBestSeller, '
      'it should return Success with empty list when remote data source returns empty list',
      () async {
        // Arrange
        final mockDto = BestSellerResponseDto(
          message: 'No items',
          bestSellerDto: [],
        );
        when(
          mockRemoteDataSource.getBestSeller(),
        ).thenAnswer((_) async => mockDto);

        // Act
        final result = await repository.getBestSeller();

        // Assert
        result.when(
          success: (data) {
            expect(data.message, 'No items');
            expect(data.bestSeller, isEmpty);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockRemoteDataSource.getBestSeller()).called(1);
      },
    );

    test(
      'When call getBestSeller, '
      'it should return Success with empty list when remote data source returns null list',
      () async {
        // Arrange
        final mockDto = BestSellerResponseDto(
          message: 'success',
          bestSellerDto: null,
        );
        when(
          mockRemoteDataSource.getBestSeller(),
        ).thenAnswer((_) async => mockDto);

        // Act
        final result = await repository.getBestSeller();

        // Assert
        result.when(
          success: (data) {
            expect(data.bestSeller, isEmpty);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockRemoteDataSource.getBestSeller()).called(1);
      },
    );

    test(
      'When call getBestSeller, '
      'it should return Failure when remote data source throws exception',
      () async {
        // Arrange
        final exception = Exception('Network error');
        when(mockRemoteDataSource.getBestSeller()).thenThrow(exception);

        // Act
        final result = await repository.getBestSeller();

        // Assert
        expect(result, isA<Failure<BestSellerResponse>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (errorHandler) {
            expect(errorHandler, isA<ErrorHandler>());
          },
        );
        verify(mockRemoteDataSource.getBestSeller()).called(1);
      },
    );

    test(
      'When call getBestSeller, '
      'it should return Failure when remote data source throws any error',
      () async {
        // Arrange
        when(mockRemoteDataSource.getBestSeller()).thenThrow(Error());

        // Act
        final result = await repository.getBestSeller();

        // Assert
        expect(result, isA<Failure<BestSellerResponse>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (errorHandler) {
            expect(errorHandler, isA<ErrorHandler>());
          },
        );
        verify(mockRemoteDataSource.getBestSeller()).called(1);
      },
    );

    test(
      'When call getBestSeller, '
      'it should correctly transform DTO to entity with pagination metadata',
      () async {
        // Arrange
        final mockDto = BestSellerResponseDto(
          message: 'success',
          bestSellerDto: List.generate(
            15,
            (index) => BestSellerDto(
              id: '$index',
              title: 'Product $index',
              imgCover: 'img$index.jpg',
              price: 100 * (index + 1),
              priceAfterDiscount: 90 * (index + 1),
              quantity: 10,
              sold: 5,
              bestSellerId: 'bs$index',
              discount: 10,
            ),
          ),
        );
        when(
          mockRemoteDataSource.getBestSeller(),
        ).thenAnswer((_) async => mockDto);

        // Act
        final result = await repository.getBestSeller();

        // Assert
        result.when(
          success: (data) {
            expect(data.bestSeller?.length, 15);
            expect(data.paginationMetadata, isNotNull);
            expect(data.paginationMetadata?.total, 15);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockRemoteDataSource.getBestSeller()).called(1);
      },
    );

    test(
      'When call getBestSeller, '
      'it should not call remote data source more than once per invocation',
      () async {
        // Arrange
        final mockDto = BestSellerResponseDto(
          message: 'success',
          bestSellerDto: [],
        );
        when(
          mockRemoteDataSource.getBestSeller(),
        ).thenAnswer((_) async => mockDto);

        // Act
        await repository.getBestSeller();

        // Assert
        verify(mockRemoteDataSource.getBestSeller()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}
