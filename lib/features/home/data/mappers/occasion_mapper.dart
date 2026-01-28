import '../../domain/entities/occasion_entity.dart';
import '../models/occasion_dto.dart';

extension OccasionMapper on OccasionDto {
  OccasionEntity toEntity() {
    return OccasionEntity(
      id: id ?? '',
      name: name ?? '',
      slug: slug ?? '',
      image: image ?? '',
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      isSuperAdmin: isSuperAdmin ?? false,
    );
  }
}
