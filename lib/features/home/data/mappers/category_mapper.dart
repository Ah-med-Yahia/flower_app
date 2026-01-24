import '../../domain/entities/category_entity.dart';
import '../models/category_dto.dart';

extension CategoryMapper on CategoryDto {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      slug: slug,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isSuperAdmin: isSuperAdmin ?? false,
    );
  }
}
