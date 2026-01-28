class CategoryProductEntity {
  final String id;
  final String name;
  final String image;
  final num price;
  final num priceAfterDiscount;
  final int discountPercentage;

  CategoryProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.priceAfterDiscount,
    this.discountPercentage = 0,
  });

  CategoryProductEntity copyWith({int? discountPercentage}) {
    return CategoryProductEntity(
      id: id,
      name: name,
      image: image,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
    );
  }
}
