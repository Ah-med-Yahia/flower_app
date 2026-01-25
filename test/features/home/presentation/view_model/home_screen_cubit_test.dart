import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/home/domain/entities/category_entity.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/home/domain/usecases/get_home_data_usecase.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_cubit.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_events.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_screen_cubit_test.mocks.dart';

@GenerateMocks([GetHomeDataUsecase])
Future<void> main() async {
  late HomeScreenCubit cubit;
  late MockGetHomeDataUsecase mockUseCase;

  setUp(() {
    mockUseCase = MockGetHomeDataUsecase();
    cubit = HomeScreenCubit(mockUseCase);
  });
  tearDown(() => cubit.close());

  group('getHomeData', () {
    final HomeResponseEntity mockHomeScreenData = HomeResponseEntity(
      message: '',
      categories: [
        CategoryEntity(
          id: '1',
          name: 'name',
          slug: 'slug',
          image: 'image',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isSuperAdmin: false,
        ),
      ],
      bestSeller: [
        ProductEntity(
          id: '1',
          title: 'title',
          slug: 'slug',
          description: 'description',
          imgCover: 'imgCover',
          images: [],
          price: 1,
          priceAfterDiscount: 1,
          quantity: 1,
          category: 'category',
          occasion: 'occasion',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          v: 1,
          isSuperAdmin: false,
          rateAvg: 1,
          rateCount: 1,
          discount: 1,
          sold: 1,
        ),
      ],
      occasions: [
        OccasionEntity(
          id: '1',
          name: 'name',
          slug: 'slug',
          image: 'image',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isSuperAdmin: false,
        ),
      ],
    );

    test('initial state should have null homeScreenStates', () {
      expect(cubit.state.homeScreenStates, isNull);
    });
    blocTest<HomeScreenCubit, HomeScreenStates>(
      'emits [loading, success] when getting Home Screen Data succeeds',
      build: () {
        when(
          mockUseCase.call(),
        ).thenAnswer((_) async => BaseResponse.success(mockHomeScreenData));
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetHomeScreenDataEvent()),
      expect: () => [
        predicate<HomeScreenStates>((state) {
          return state.homeScreenStates?.isLoading == true &&
              state.homeScreenStates?.data == null &&
              state.homeScreenStates?.errorMessage == null;
        }),
        predicate<HomeScreenStates>((state) {
          return state.homeScreenStates?.isLoading == false &&
              state.homeScreenStates?.data != null &&
              state.homeScreenStates?.errorMessage == null;
        }),
      ],
      verify: (_) {
        verify(mockUseCase.call()).called(1);
      },
    );
    blocTest(
      'emits [loading, failure] when getting Home Screen Data fails',
      build: () {
        when(mockUseCase.call()).thenAnswer(
          (_) async =>
              BaseResponse.failure(ErrorHandler.handle('Something went wrong')),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetHomeScreenDataEvent()),
      expect: () => [
        predicate<HomeScreenStates>((state) {
          return state.homeScreenStates?.isLoading == true &&
              state.homeScreenStates?.data == null &&
              state.homeScreenStates?.errorMessage == null;
        }),
        predicate<HomeScreenStates>((state) {
          return state.homeScreenStates?.isLoading == false &&
              state.homeScreenStates?.data == null &&
              state.homeScreenStates?.errorMessage != null;
        }),
      ],
      verify: (_) {
        verify(mockUseCase.call()).called(1);
      },
    );
  });
}
