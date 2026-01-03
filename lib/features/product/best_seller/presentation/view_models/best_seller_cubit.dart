import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/get_best_seller_use_case.dart';
import 'best_seller_events.dart';
import 'best_seller_state.dart';

@injectable
class BestSellerCubit extends Cubit<BestSellerState> {
  final GetBestSellerUseCase _getBestSellerUseCase;

  BestSellerCubit(this._getBestSellerUseCase) : super(const BestSellerState());

  final _streamController = StreamController<BestSellerEvents>.broadcast();

  Stream<BestSellerEvents> get uiEvents => _streamController.stream;

  Future<void> doIntent(BestSellerEvents event) async {
    switch (event) {
      case GetBestSellerProductEvent():
        _getBestSeller();
      case NavigateToProductDetailsEvent():
        _navigateToProductDetailsEvent(event);
      case NavigateToCartEvent():
        _navigateToCartEvent(event);
    }
  }

  void _getBestSeller() async {
    emit(
      state.copyWith(
        bestSellerState: state.bestSellerState.copyWith(isLoading: true),
      ),
    );
    final apiCallResult = await _getBestSellerUseCase.call();
    apiCallResult.when(
      success: (data) {
        emit(
          state.copyWith(
            bestSellerState: state.bestSellerState.copyWith(
              data: data,
              isLoading: false,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            bestSellerState: state.bestSellerState.copyWith(
              errorMessage: error.message,
              isLoading: false,
            ),
          ),
        );
      },
    );
  }

  void _navigateToCartEvent(NavigateToCartEvent event) {
    _streamController.add(NavigateToCartEvent());
  }

  void _navigateToProductDetailsEvent(NavigateToProductDetailsEvent event) {
    _streamController.add(NavigateToProductDetailsEvent());
  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }
}
