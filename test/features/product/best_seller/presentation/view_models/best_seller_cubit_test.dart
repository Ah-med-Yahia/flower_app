import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/config/error_handler/error_model.dart';
import 'package:flower_app/features/product/best_seller/domain/entities/best_seller.dart';
import 'package:flower_app/features/product/best_seller/domain/entities/best_seller_response.dart';
import 'package:flower_app/features/product/best_seller/domain/entities/pagination_meta_data.dart';
import 'package:flower_app/features/product/best_seller/domain/use_cases/get_best_seller_use_case.dart';
import 'package:flower_app/features/product/best_seller/presentation/view_models/best_seller_cubit.dart';
import 'package:flower_app/features/product/best_seller/presentation/view_models/best_seller_events.dart';
import 'package:flower_app/features/product/best_seller/presentation/view_models/best_seller_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'best_seller_cubit_test.mocks.dart';

@GenerateMocks([GetBestSellerUseCase])
void main() {
  late MockGetBestSellerUseCase mockUseCase;
  late BestSellerCubit cubit;
  setUp(() {
    mockUseCase = MockGetBestSellerUseCase();
    cubit = BestSellerCubit(mockUseCase);
  });
  tearDown(() => cubit.close());
  group('BestSellerCubit when doIntent is called', () {
    _testInitialState(() => cubit);
    _testSuccessfulGetBestSellerEvent(() => mockUseCase, () => cubit);
    _testFailureWhenGetBestSellerEvent(() => mockUseCase, () => cubit);
    _testVerifyStoreCorrectDataInStateWhenFailure(
      () => mockUseCase,
      () => cubit,
    );
    _testNavigateToCartEvent(() => cubit);
    _testNavigateToProductDetailsEvent(() => cubit);
    _testMultipleBestSellerItems(() => mockUseCase, () => cubit);
    _testEmptyBestSellerList(() => mockUseCase, () => cubit);
  });
}

// Test data factory to avoid duplication
BestSellerResponse _createMockBestSellerResponse({
  String message = 'success',
  int itemCount = 1,
}) {
  final items = List.generate(
    itemCount,
    (index) => BestSeller(
      id: '${index + 1}',
      title: 'Product ${index + 1}',
      imgCover: 'img${index + 1}.jpg',
      price: 100 + (index * 10),
      priceAfterDiscount: 90 + (index * 10),
      quantity: 10,
      sold: 5,
      bestSellerId: 'bs${index + 1}',
      discount: 10,
    ),
  );

  return BestSellerResponse(
    message: message,
    bestSeller: items,
    paginationMetadata: PaginationMetadata(
      currentPage: 1,
      numberOfPages: 1,
      limit: 10,
      total: itemCount,
    ),
  );
}

void _testInitialState(BestSellerCubit Function() bestSellerCubit) {
  test('When cubit is initialized, '
      'it should start with default values', () async {
    final cubit = bestSellerCubit();

    expect(cubit.state, isA<BestSellerState>());
    final forgetPasswordState = cubit.state.bestSellerState;
    expect(forgetPasswordState.isLoading, false);
    expect(forgetPasswordState.errorMessage, null);
    expect(forgetPasswordState.data, null);
  });
}

void _testSuccessfulGetBestSellerEvent(
  MockGetBestSellerUseCase Function() mockUGetBestSellerUseCase,
  BestSellerCubit Function() bestSellerCubit,
) {
  final mockBestSellerResponse = _createMockBestSellerResponse();
  final successResponse = BaseResponse<BestSellerResponse>.success(
    mockBestSellerResponse,
  );

  const state = BestSellerState();

  blocTest<BestSellerCubit, BestSellerState>(
    'When call GetBestSellerProductEvent action, '
    'it should return data of type BestSellerResponse, '
    'and update the correct state',
    // ARRANGE
    build: () => bestSellerCubit(),
    setUp: () {
      when(
        mockUGetBestSellerUseCase().call(),
      ).thenAnswer((_) async => successResponse);
    },
    // ACT
    act: (cubit) => cubit.doIntent(const GetBestSellerProductEvent()),
    // ASSERT
    expect: () => [
      // Loading state
      state.copyWith(
        bestSellerState: state.bestSellerState.copyWith(isLoading: true),
      ),
      // Success state with data
      state.copyWith(
        bestSellerState: state.bestSellerState.copyWith(
          isLoading: false,
          data: mockBestSellerResponse,
        ),
      ),
    ],
    verify: (cubit) {
      verify(mockUGetBestSellerUseCase().call()).called(1);
      // Verify data is stored correctly
      final finalState = cubit.state.bestSellerState;
      expect(finalState.data, equals(mockBestSellerResponse));
      expect(finalState.isLoading, false);
      expect(finalState.errorMessage, null);
    },
  );
}

void _testFailureWhenGetBestSellerEvent(
  MockGetBestSellerUseCase Function() mockUGetBestSellerUseCase,
  BestSellerCubit Function() bestSellerCubit,
) {
  const errorMessage = 'Network error';
  final apiErrorModel = ErrorModel(message: errorMessage);
  final errorHandler = ErrorHandler.handle(apiErrorModel);
  final failureResponse = BaseResponse<BestSellerResponse>.failure(
    errorHandler,
  );

  const state = BestSellerState();

  blocTest<BestSellerCubit, BestSellerState>(
    'When call GetBestSellerProductEvent action, '
    'it should return failure, '
    'and update the correct state',
    // ARRANGE
    build: () => bestSellerCubit(),
    setUp: () {
      when(
        mockUGetBestSellerUseCase().call(),
      ).thenAnswer((_) async => failureResponse);
    },
    // ACT
    act: (cubit) => cubit.doIntent(const GetBestSellerProductEvent()),
    // ASSERT
    expect: () => [
      // Loading state
      state.copyWith(
        bestSellerState: state.bestSellerState.copyWith(isLoading: true),
      ),
      // Success state with data
      state.copyWith(
        bestSellerState: state.bestSellerState.copyWith(
          isLoading: false,
          errorMessage: errorMessage,
        ),
      ),
    ],
    verify: (cubit) {
      verify(mockUGetBestSellerUseCase().call()).called(1);
    },
  );
}

void _testVerifyStoreCorrectDataInStateWhenFailure(
  MockGetBestSellerUseCase Function() mockUGetBestSellerUseCase,
  BestSellerCubit Function() bestSellerCubit,
) {
  const errorMessage = 'Network error';
  final apiErrorModel = ErrorModel(message: errorMessage);
  final errorHandler = ErrorHandler.handle(apiErrorModel);
  final failureResponse = BaseResponse<BestSellerResponse>.failure(
    errorHandler,
  );

  test(
    'When Called GetBestSellerProductEvent action, '
    'with failure message it should save the correct data in the state',
    () async {
      when(
        mockUGetBestSellerUseCase().call(),
      ).thenAnswer((_) async => failureResponse);

      final cubit = bestSellerCubit();
      await cubit.doIntent(const GetBestSellerProductEvent());

      final state = cubit.state.bestSellerState;
      expect(state.data, isNull);
      expect(state.isLoading, false);
      expect(state.errorMessage, errorMessage);
    },
  );
}

void _testNavigateToCartEvent(BestSellerCubit Function() bestSellerCubit) {
  test(
    'When call NavigateToCartEvent, it should emit event to stream',
    () async {
      final cubit = bestSellerCubit();
      final initialState = cubit.state;

      // Listen to the stream before emitting
      expectLater(cubit.uiEvents, emits(isA<NavigateToCartEvent>()));

      // Act
      await cubit.doIntent(const NavigateToCartEvent());

      // Assert state doesn't change
      expect(cubit.state, equals(initialState));
    },
  );
}

void _testNavigateToProductDetailsEvent(
  BestSellerCubit Function() bestSellerCubit,
) {
  test(
    'When call NavigateToProductDetailsEvent, it should emit event to stream',
    () async {
      final cubit = bestSellerCubit();
      final initialState = cubit.state;
      const productId = '123';

      // Listen to the stream before emitting
      expectLater(cubit.uiEvents, emits(isA<NavigateToProductDetailsEvent>()));

      // Act
      await cubit.doIntent(
        const NavigateToProductDetailsEvent(productId: productId),
      );

      // Assert state doesn't change
      expect(cubit.state, equals(initialState));
    },
  );
}

void _testMultipleBestSellerItems(
  MockGetBestSellerUseCase Function() mockUGetBestSellerUseCase,
  BestSellerCubit Function() bestSellerCubit,
) {
  final mockResponse = _createMockBestSellerResponse(itemCount: 5);
  final successResponse = BaseResponse<BestSellerResponse>.success(
    mockResponse,
  );

  const state = BestSellerState();

  blocTest<BestSellerCubit, BestSellerState>(
    'When GetBestSellerProductEvent returns multiple items, '
    'it should store all items correctly',
    build: () => bestSellerCubit(),
    setUp: () {
      when(
        mockUGetBestSellerUseCase().call(),
      ).thenAnswer((_) async => successResponse);
    },
    act: (cubit) => cubit.doIntent(const GetBestSellerProductEvent()),
    expect: () => [
      state.copyWith(
        bestSellerState: state.bestSellerState.copyWith(isLoading: true),
      ),
      state.copyWith(
        bestSellerState: state.bestSellerState.copyWith(
          isLoading: false,
          data: mockResponse,
        ),
      ),
    ],
    verify: (cubit) {
      final finalState = cubit.state.bestSellerState;
      expect(finalState.data?.bestSeller?.length, equals(5));
      expect(finalState.data?.bestSeller?[0].id, equals('1'));
      expect(finalState.data?.bestSeller?[4].id, equals('5'));
      expect(finalState.data?.paginationMetadata?.total, equals(5));
    },
  );
}

void _testEmptyBestSellerList(
  MockGetBestSellerUseCase Function() mockUGetBestSellerUseCase,
  BestSellerCubit Function() bestSellerCubit,
) {
  final mockResponse = _createMockBestSellerResponse(itemCount: 0);
  final successResponse = BaseResponse<BestSellerResponse>.success(
    mockResponse,
  );

  const state = BestSellerState();

  blocTest<BestSellerCubit, BestSellerState>(
    'When GetBestSellerProductEvent returns empty list, '
    'it should handle it gracefully',
    build: () => bestSellerCubit(),
    setUp: () {
      when(
        mockUGetBestSellerUseCase().call(),
      ).thenAnswer((_) async => successResponse);
    },
    act: (cubit) => cubit.doIntent(const GetBestSellerProductEvent()),
    expect: () => [
      state.copyWith(
        bestSellerState: state.bestSellerState.copyWith(isLoading: true),
      ),
      state.copyWith(
        bestSellerState: state.bestSellerState.copyWith(
          isLoading: false,
          data: mockResponse,
        ),
      ),
    ],
    verify: (cubit) {
      final finalState = cubit.state.bestSellerState;
      expect(finalState.data?.bestSeller?.isEmpty, isTrue);
      expect(finalState.data?.paginationMetadata?.total, equals(0));
      expect(finalState.isLoading, false);
      expect(finalState.errorMessage, null);
    },
  );
}
