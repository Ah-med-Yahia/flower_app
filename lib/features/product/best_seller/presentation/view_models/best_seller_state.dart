import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/product/best_seller/domain/entities/best_seller.dart';

import '../../domain/entities/best_seller_response.dart';

class BestSellerState extends Equatable {
  final BaseState<BestSellerResponse> bestSellerState;

  const BestSellerState({
    this.bestSellerState = const BaseState<BestSellerResponse>(),
  });

  //-------------------------Pagination---------------------------------//
  int? get metaCurrentPage =>
      bestSellerState.data?.paginationMetadata?.currentPage;

  int? get metaNumberOfPages =>
      bestSellerState.data?.paginationMetadata?.numberOfPages;

  int? get metaLimit => bestSellerState.data?.paginationMetadata?.limit;

  int? get metaTotal => bestSellerState.data?.paginationMetadata?.total;

  //-------------------------Items List---------------------------------//
  List<BestSeller>? get bestSellerList => bestSellerState.data?.bestSeller;

  BestSellerState copyWith({BaseState<BestSellerResponse>? bestSellerState}) {
    return BestSellerState(
      bestSellerState: bestSellerState ?? this.bestSellerState,
    );
  }

  @override
  List<Object?> get props => [bestSellerState];
}
