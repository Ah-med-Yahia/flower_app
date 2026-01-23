import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/error_handler/error_model.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/occasion/domain/entities/get_all_occasions_list_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/occasion/domain/usecases/get_all_occasion_usecase.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_cubit.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_event.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_state.dart';
import 'package:test/test.dart';

import 'occasion_cubit_test.mocks.dart';

@GenerateMocks([GetAllOccasionUsecase])
void main() {
  late OccasionCubit occasionCubit;
  late MockGetAllOccasionUsecase mockGetAllOccasionUsecase;

  setUpAll(() {
    mockGetAllOccasionUsecase = MockGetAllOccasionUsecase();
    occasionCubit = OccasionCubit(
      getAllOccasionUsecase: mockGetAllOccasionUsecase,
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
  final occasionEntityMockResponse = GetOccasionListEntity(
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
  const errorMessage = ErrorsConstant.internalServerError;
  const errorCode = ResponseCode.internalServerError;
  final mockApiErrorModel = ErrorModel(message: errorMessage, code: errorCode);
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
