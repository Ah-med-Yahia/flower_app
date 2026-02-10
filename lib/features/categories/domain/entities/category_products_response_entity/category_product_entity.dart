class CategoryProductEntity {
  final String id;
  final String title;
  final String? description;
  final String? imageCover;
  final List<String>? images;
  final double price;
  final double? priceAfterDiscount;
  final double? discount;
  final String? discountPercentage;
  final String categoryId;
  final String occasionId;
  final int quantity;
  final bool inStock;

  CategoryProductEntity({
    required this.id,
    required this.title,
    this.description,
    this.imageCover,
    this.images,
    required this.price,
    this.priceAfterDiscount,
    this.discount,
    this.discountPercentage,
    required this.categoryId,
    required this.occasionId,
    required this.quantity,
    this.inStock = true,
  });

  CategoryProductEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? imageCover,
    List<String>? images,
    double? price,
    double? priceAfterDiscount,
    double? discount,
    String? discountPercentage,
    String? categoryId,
    String? occasionId,
    bool? inStock,
    int? quantity,
  }) {
    return CategoryProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageCover: imageCover ?? this.imageCover,
      images: images ?? this.images,
      price: price ?? this.price,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      discount: discount ?? this.discount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      categoryId: categoryId ?? this.categoryId,
      occasionId: occasionId ?? this.occasionId,
      inStock: inStock ?? this.inStock,
      quantity: quantity ?? this.quantity,
    );
  }
}
