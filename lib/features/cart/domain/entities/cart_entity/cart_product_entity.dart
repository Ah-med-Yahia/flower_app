import 'package:equatable/equatable.dart';

class CartProductEntity extends Equatable {
  final String title;
  final String slug;
  final String description;
  final String? imgCover;
  final List<String>? images;
  final int price;
  final int priceAfterDiscount;
  final int quantity;
  final String category;
  final String occasion;

  const CartProductEntity({
    required this.title,
    required this.slug,
    required this.description,
    this.imgCover,
    this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.category,
    required this.occasion,
  });

  @override
  List<Object?> get props => [
    title,
    title,
    slug,
    description,
    imgCover,
    images,
    price,
    priceAfterDiscount,
    quantity,
    category,
    occasion,
  ];
}
