import 'package:json_annotation/json_annotation.dart';
import 'package:flower_app/features/occasion/domain/entities/occasion_entity.dart';

part 'occasion_model.g.dart';

@JsonSerializable()
class OccasionModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'slug')
  final String slug;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(name: 'isSuperAdmin')
  final bool isSuperAdmin;
  @JsonKey(name: 'productsCount')
  final int productsCount;

  OccasionModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.isSuperAdmin,
    required this.productsCount,
  });

  factory OccasionModel.fromJson(Map<String, dynamic> json) =>
      _$OccasionModelFromJson(json);
  Map<String, dynamic> toJson() => _$OccasionModelToJson(this);
  OccasionEntity toEntity() {
    return OccasionEntity(id: id, name: name);
  }
}
