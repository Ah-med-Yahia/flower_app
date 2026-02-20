import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/config/error_handler/error_model.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';
import 'package:flower_app/core/shared/domain/use_cases.dart/get_products_use_cases.dart';
import 'package:flower_app/features/products/occasion/domain/entities/get_all_occasions_list_entity.dart';
import 'package:flower_app/features/products/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/products/occasion/domain/usecases/get_all_occasion_usecase.dart';
import 'package:flower_app/features/products/occasion/presentation/view_model/occasion_cubit.dart';
import 'package:flower_app/features/products/occasion/presentation/view_model/occasion_event.dart';
import 'package:flower_app/features/products/occasion/presentation/view_model/occasion_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'occasion_cubit_test.mocks.dart';

@GenerateMocks([GetAllOccasionUsecase, GetProductsUseCase])
void main() {
  late OccasionCubit occasionCubit;
  late MockGetAllOccasionUsecase mockGetAllUsecase;
  late MockGetProductsUseCase mockGetProductsUsecase;

  setUp(() {
    mockGetAllUsecase = MockGetAllOccasionUsecase();
    mockGetProductsUsecase = MockGetProductsUseCase();
    occasionCubit = OccasionCubit(mockGetAllUsecase, mockGetProductsUsecase);
  });

  tearDown(() => occasionCubit.close());

  group('OccasionCubit - Initial State', () {
    test('should have correct initial state', () {
      expect(occasionCubit.state.occasionState.data, isNull);
      expect(occasionCubit.state.occasionState.isLoading, false);
    });
  });

  group('OccasionCubit - Selection', () {
    blocTest<OccasionCubit, OccasionState>(
      'emits state with updated selectedIndex',
      build: () => occasionCubit,
      act: (cubit) => cubit.onEvent(SelectOccasion(5)),
      expect: () => [
        isA<OccasionState>().having((s) => s.selectedIndex, 'index', 5),
      ],
    );
  });

  group('OccasionCubit - GetAllOccasions', () {
    final tOccasions = GetOccasionListEntity(
      occasions: [OccasionEntity(id: '1', name: 'Birthday')],
    );

    final tProducts = ProductsResponseEntity(
      products: [
        ProductEntity(
          id: '1',
          categoryId: '1',
          occasionId: '1',
          price: 2,
          quantity: 2,
          title: 'title',
        ),
      ],
    );

    blocTest<OccasionCubit, OccasionState>(
      'emits [Loading, Success] when successful',
      build: () {
        when(
          mockGetAllUsecase.getAllOccasions(),
        ).thenAnswer((_) async => BaseResponse.success(tOccasions));
        // Stub for the automatic call to getOccasionProducts after success
        when(
          mockGetProductsUsecase(occasionId: '1'),
        ).thenAnswer((_) async => BaseResponse.success(tProducts));
        return occasionCubit;
      },
      act: (cubit) => cubit.onEvent(GetAllOccasions()),
      expect: () => [
        isA<OccasionState>().having(
          (s) => s.occasionState.isLoading,
          'loading',
          true,
        ),
        isA<OccasionState>()
            .having((s) => s.occasionState.isLoading, 'loading', false)
            .having((s) => s.occasionState.data, 'data', tOccasions),
        // Additional states from getOccasionProducts call
        isA<OccasionState>().having(
          (s) => s.occasionProductsState.isLoading,
          'products loading',
          true,
        ),
        isA<OccasionState>()
            .having((s) => s.occasionProductsState.isLoading, 'loading', false)
            .having((s) => s.occasionProductsState.data, 'data', tProducts),
      ],
    );

    blocTest<OccasionCubit, OccasionState>(
      'emits [Loading, Failure] when usecase fails',
      build: () {
        final error = ErrorHandler.handle(
          ErrorModel(
            message: ErrorsConstant.internalServerError,
            code: ResponseCode.internalServerError,
          ),
        );
        when(
          mockGetAllUsecase.getAllOccasions(),
        ).thenAnswer((_) async => BaseResponse.failure(error));
        return occasionCubit;
      },
      act: (cubit) => cubit.onEvent(GetAllOccasions()),
      expect: () => [
        isA<OccasionState>().having(
          (s) => s.occasionState.isLoading,
          'loading',
          true,
        ),
        isA<OccasionState>()
            .having((s) => s.occasionState.isLoading, 'loading', false)
            .having(
              (s) => s.occasionState.errorMessage,
              'error',
              ErrorsConstant.internalServerError,
            ),
      ],
    );
  });

  group('OccasionCubit - GetOccasionProducts', () {
    const tId = '123';
    final tProducts = ProductsResponseEntity(
      products: [
        ProductEntity(
          id: '1',
          categoryId: '1',
          occasionId: '1',
          price: 2,
          quantity: 2,
          title: 'title',
        ),
      ],
    );

    blocTest<OccasionCubit, OccasionState>(
      'emits [Loading, Success] when successful',
      build: () {
        when(
          mockGetProductsUsecase(occasionId: tId),
        ).thenAnswer((_) async => BaseResponse.success(tProducts));
        return occasionCubit;
      },
      act: (cubit) => cubit.onEvent(GetOccasionProducts(tId)),
      expect: () => [
        isA<OccasionState>().having(
          (s) => s.occasionProductsState.isLoading,
          'loading',
          true,
        ),
        isA<OccasionState>()
            .having((s) => s.occasionProductsState.isLoading, 'loading', false)
            .having((s) => s.occasionProductsState.data, 'data', tProducts),
      ],
    );
  });
}
