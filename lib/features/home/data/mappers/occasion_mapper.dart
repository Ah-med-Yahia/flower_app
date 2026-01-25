import 'package:flower_app/features/home/data/models/occasion_dto.dart';
import 'package:flower_app/features/home/domain/entities/occasion_entity.dart';

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
