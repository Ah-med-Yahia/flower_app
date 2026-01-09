import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/error_handler/api_error_model.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/core/constants/api_errors_constants.dart';
import 'package:online_exam_app/features/occasion/domain/entities/get_all_occasion_entity.dart';
import 'package:online_exam_app/features/occasion/domain/entities/get_occasion_products_entity.dart';
import 'package:online_exam_app/features/occasion/domain/entities/occasion_entity.dart';
import 'package:online_exam_app/features/occasion/domain/entities/occasion_product_entity.dart';
import 'package:online_exam_app/features/occasion/domain/usecases/get_all_occasion_usecase.dart';
import 'package:online_exam_app/features/occasion/domain/usecases/get_occasion_products_usecase.dart';
import 'package:online_exam_app/features/occasion/presentation/view_model/occasion_cubit.dart';
import 'package:online_exam_app/features/occasion/presentation/view_model/occasion_event.dart';
import 'package:online_exam_app/features/occasion/presentation/view_model/occasion_state.dart';
import 'package:test/test.dart';

import 'occasion_cubit_test.mocks.dart';

@GenerateMocks([GetAllOccasionUsecase, GetOccasionProductsUsecase])
void main() {
  late OccasionCubit occasionCubit;
  late MockGetAllOccasionUsecase mockGetAllOccasionUsecase;
  late MockGetOccasionProductsUsecase mockGetOccasionProductsUsecase;
  setUpAll(() {
    mockGetAllOccasionUsecase = MockGetAllOccasionUsecase();
    mockGetOccasionProductsUsecase = MockGetOccasionProductsUsecase();
    occasionCubit = OccasionCubit(
      getAllOccasionUsecase: mockGetAllOccasionUsecase,
      getOccasionProductsUsecase: mockGetOccasionProductsUsecase,
    );
  });

  tearDownAll(() {
    occasionCubit.close();
  });
  group('OccasionCubit', () {
    _verfyInitialState(occasionCubit, mockGetAllOccasionUsecase);
    _verfySelectOccasion(occasionCubit, mockGetAllOccasionUsecase);
    _verifyGetAllOccasionsSuccess(occasionCubit, mockGetAllOccasionUsecase);
    _verifyGetAllOccasionsFailure(occasionCubit, mockGetAllOccasionUsecase);
    _verifyGetOccasionProductsSuccess(
      occasionCubit,
      mockGetOccasionProductsUsecase,
    );
    _verifyGetOccasionProductsFailure(
      occasionCubit,
      mockGetOccasionProductsUsecase,
    );
  });
}

void _verfyInitialState(
  OccasionCubit occasionCubit,
  MockGetAllOccasionUsecase mockGetAllOccasionUsecase,
) {
  test('test initial state', () {
    expect(occasionCubit.state, isA<OccasionState>());
    expect(occasionCubit.state.occasionState.data, isNull);
    expect(occasionCubit.state.occasionState.isLoading, false);
    occasionCubit.close();
  });
}

void _verfySelectOccasion(
  OccasionCubit occasionCubit,
  MockGetAllOccasionUsecase mockGetAllOccasionUsecase,
) {
  blocTest<OccasionCubit, OccasionState>(
    'emits state with new selectedIndex',
    build: () => occasionCubit,
    act: (cubit) => cubit.onEvent(SelectOccasion(5)),
    expect: () => [
      isA<OccasionState>().having(
        (state) => state.selectedIndex,
        'selectedIndex',
        5,
      ),
    ],
  );
}

void _verifyGetAllOccasionsSuccess(
  OccasionCubit occasionCubit,
  MockGetAllOccasionUsecase mockGetAllOccasionUsecase,
) {
  final occasionEntityMockResponse = GetAllOccasionEntity(
    occasions: [
      OccasionEntity(id: '1', name: 'Birthday'),
      OccasionEntity(id: '2', name: 'Anniversary'),
    ],
  );
  blocTest<OccasionCubit, OccasionState>(
    'emits [Loading, Success] when GetAllOccasions is added and succeeds',
    build: () {
      when(mockGetAllOccasionUsecase.getAllOccasions()).thenAnswer(
        (_) async => BaseResponse.success(occasionEntityMockResponse),
      );
      return occasionCubit;
    },
    act: (cubit) => cubit.onEvent(GetAllOccasions()),
    expect: () => [
      isA<OccasionState>().having(
        (state) => state.occasionState.isLoading,
        'isLoading should be true',
        true,
      ),
      isA<OccasionState>()
          .having(
            (state) => state.occasionState.isLoading,
            'isLoading should be false',
            false,
          )
          .having(
            (state) => state.occasionState.data,
            'data should match mock response',
            occasionEntityMockResponse,
          )
          .having(
            (state) => state.occasionState.errorMessage,
            'errorMessage should be null',
            isNull,
          ),
    ],
    verify: (_) {
      verify(mockGetAllOccasionUsecase.getAllOccasions()).called(1);
    },
  );
}

void _verifyGetAllOccasionsFailure(
  OccasionCubit occasionCubit,
  MockGetAllOccasionUsecase mockGetAllOccasionUsecase,
) {
  const errorMessage = ApiErrors.internalServerError;
  const errorCode = ResponseCode.internalServerError;
  final mockApiErrorModel = ApiErrorModel(
    message: errorMessage,
    code: errorCode,
  );
  final mockErrorHandler = ErrorHandler.handle(mockApiErrorModel);
  blocTest<OccasionCubit, OccasionState>(
    'emits [Loading, Failure] when GetAllOccasions is added and fails',
    build: () {
      when(
        mockGetAllOccasionUsecase.getAllOccasions(),
      ).thenAnswer((_) async => BaseResponse.failure(mockErrorHandler));
      return occasionCubit;
    },
    act: (cubit) => cubit.onEvent(GetAllOccasions()),
    expect: () => [
      isA<OccasionState>().having(
        (state) => state.occasionState.isLoading,
        'isLoading',
        true,
      ),
      isA<OccasionState>()
          .having((state) => state.occasionState.isLoading, 'isLoading', false)
          .having(
            (state) => state.occasionState.errorMessage,
            'errorMessage',
            errorMessage,
          ),
    ],
    verify: (_) {
      verify(mockGetAllOccasionUsecase.getAllOccasions()).called(1);
    },
  );
}

void _verifyGetOccasionProductsSuccess(
  OccasionCubit occasionCubit,
  MockGetOccasionProductsUsecase mockGetOccasionProductsUsecase,
) {
  final mockResponse = GetOccasionProductsEntity(
    products: [
      OccasionProductEntity(
        id: '1',
        title: 'Product 1',
        imgCover: '',
        price: 100,
        priceAfterDiscount: 80,
      ),
      OccasionProductEntity(
        id: '2',
        title: 'Product 2',
        imgCover: '',
        price: 200,
        priceAfterDiscount: 150,
      ),
    ],
  );

  blocTest<OccasionCubit, OccasionState>(
    'emits [Loading, Success] when getOccasionProducts succeeds',
    build: () {
      when(
        mockGetOccasionProductsUsecase.getOccasionProducts('123'),
      ).thenAnswer((_) async => BaseResponse.success(mockResponse));
      return occasionCubit;
    },
    act: (cubit) => cubit.getOccasionProducts('123'),
    expect: () => [
      isA<OccasionState>().having(
        (state) => state.occasionProductsState.isLoading,
        'isLoading should be true',
        true,
      ),
      isA<OccasionState>()
          .having(
            (state) => state.occasionProductsState.isLoading,
            'isLoading should be false',
            false,
          )
          .having(
            (state) => state.occasionProductsState.data,
            'data should match mock response',
            mockResponse,
          )
          .having(
            (state) => state.occasionProductsState.errorMessage,
            'errorMessage should be null',
            isNull,
          ),
    ],
    verify: (_) {
      verify(
        mockGetOccasionProductsUsecase.getOccasionProducts('123'),
      ).called(1);
    },
  );
}

void _verifyGetOccasionProductsFailure(
  OccasionCubit occasionCubit,
  MockGetOccasionProductsUsecase mockGetOccasionProductsUsecase,
) {
  const errorMessage = ApiErrors.internalServerError;
  const errorCode = ResponseCode.internalServerError;
  final mockErrorModel = ApiErrorModel(message: errorMessage, code: errorCode);
  final mockErrorHandler = ErrorHandler.handle(mockErrorModel);

  blocTest<OccasionCubit, OccasionState>(
    'emits [Loading, Failure] when getOccasionProducts fails',
    build: () {
      when(
        mockGetOccasionProductsUsecase.getOccasionProducts('123'),
      ).thenAnswer((_) async => BaseResponse.failure(mockErrorHandler));
      return occasionCubit;
    },
    act: (cubit) => cubit.getOccasionProducts('123'),
    expect: () => [
      isA<OccasionState>().having(
        (state) => state.occasionProductsState.isLoading,
        'isLoading should be true',
        true,
      ),
      isA<OccasionState>()
          .having(
            (state) => state.occasionProductsState.isLoading,
            'isLoading should be false',
            false,
          )
          .having(
            (state) => state.occasionProductsState.errorMessage,
            'errorMessage should match error handler',
            errorMessage,
          )
          .having(
            (state) => state.occasionProductsState.data,
            'data should be null',
            isNull,
          ),
    ],
    verify: (_) {
      verify(
        mockGetOccasionProductsUsecase.getOccasionProducts('123'),
      ).called(1);
    },
  );
}
