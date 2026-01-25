import 'package:equatable/equatable.dart';

class CartProductEntity extends Equatable {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final int price;
  final int priceAfterDiscount;
  final int quantity;
  final String category;
  final String occasion;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSuperAdmin;
  final int sold;
  final int rateAvg;
  final int rateCount;
  final String productId;

  const CartProductEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.createdAt,
    required this.updatedAt,
    required this.isSuperAdmin,
    required this.sold,
    required this.rateAvg,
    required this.rateCount,
    required this.productId,
  });

  @override
  List<Object?> get props => [
    id,
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
    createdAt,
    updatedAt,
    isSuperAdmin,
    sold,
    rateAvg,
    rateCount,
    productId,
  ];
}
