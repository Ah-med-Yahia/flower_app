import 'package:equatable/equatable.dart';

class BestSeller extends Equatable {
  final String? id;
  final String? title;
  final String? imgCover;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final int? sold;
  final String? bestSellerId;
  final int? discount;

  const BestSeller({
    this.id,
    this.title,
    this.imgCover,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.sold,
    this.bestSellerId,
    this.discount,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    imgCover,
    price,
    priceAfterDiscount,
    quantity,
    sold,
    bestSellerId,
    discount,
  ];
}
