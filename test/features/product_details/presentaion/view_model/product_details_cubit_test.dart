import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/product_details/domain/models/product_model.dart';
import 'package:flower_app/features/product_details/domain/models/product_response_model.dart';
import 'package:flower_app/features/product_details/domain/use_cases/get_product_details_usecase.dart';
import 'package:flower_app/features/product_details/presentaion/view_model/product_details_cubit.dart';
import 'package:flower_app/features/product_details/presentaion/view_model/product_details_events.dart';
import 'package:flower_app/features/product_details/presentaion/view_model/product_details_states.dart';

import 'product_details_cubit_test.mocks.dart';

@GenerateMocks([GetProductDetailsUsecase])
Future<void> main() async {
  late ProductDetailsCubit cubit;
  late MockGetProductDetailsUsecase mockGetProductDetailsUsecase;

  setUp(() {
    mockGetProductDetailsUsecase = MockGetProductDetailsUsecase();
    cubit = ProductDetailsCubit(mockGetProductDetailsUsecase);
  });
  tearDown(() => cubit.close());
  group('ProductDetailsCubit', () {
    const productId = '123';
    final mockProduct = ProductModel(
      id: productId,
      title: 'Test Product',
      slug: 'test-product',
      description: 'Test description',
      imgCover: 'cover.jpg',
      images: ['img1.jpg'],
      price: 100,
      priceAfterDiscount: 80,
      quantity: 10,
      category: 'electronics',
      occasion: 'sale',
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime(2024, 1, 1),
      sold: 5,
      rateAvg: 4.5,
      rateCount: 10,
      isInWishlist: false,
    );
    final mockResponse = ProductResponseModel(
      message: 'success',
      product: mockProduct,
    );
    test('initial state should have null productDetailsState', () {
      expect(cubit.state.productDetailsState, isNull);
    });

    blocTest<ProductDetailsCubit, ProductDetailsStates>(
      'emits [loading, success] when getting product details succeeds',
      build: () {
        when(
          mockGetProductDetailsUsecase(any),
        ).thenAnswer((_) async => BaseResponse.success(mockResponse));

        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetProductDetailsEvent(productId)),
      expect: () => [
        predicate<ProductDetailsStates>((state) {
          return state.productDetailsState?.isLoading == true &&
              state.productDetailsState?.data == null &&
              state.productDetailsState?.errorMessage == null;
        }),
        predicate<ProductDetailsStates>((state) {
          return state.productDetailsState?.isLoading == false &&
              state.productDetailsState?.data != null &&
              state.productDetailsState?.data?.product.id == productId &&
              state.productDetailsState?.errorMessage == null;
        }),
      ],
      verify: (_) {
        verify(mockGetProductDetailsUsecase.call(productId)).called(1);
      },
    );
    blocTest<ProductDetailsCubit, ProductDetailsStates>(
      'emits [loading, failure] when getting product details fails',
      build: () {
        when(mockGetProductDetailsUsecase(any)).thenAnswer(
          (_) async =>
              BaseResponse.failure(ErrorHandler.handle('Something went wrong')),
        );

        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetProductDetailsEvent(productId)),
      expect: () => [
        predicate<ProductDetailsStates>((state) {
          return state.productDetailsState?.isLoading == true &&
              state.productDetailsState?.data == null &&
              state.productDetailsState?.errorMessage == null;
        }),
        predicate<ProductDetailsStates>((state) {
          return state.productDetailsState?.isLoading == false &&
              state.productDetailsState?.data == null &&
              state.productDetailsState!.errorMessage!.isNotEmpty;
        }),
      ],
      verify: (_) {
        verify(mockGetProductDetailsUsecase.call(productId)).called(1);
      },
    );
  });
}
