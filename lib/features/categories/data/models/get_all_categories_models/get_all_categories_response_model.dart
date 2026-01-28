import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/get_all_categories_list_entity.dart';
import 'category_model.dart';
import 'metadata_model.dart';

part 'get_all_categories_response_model.g.dart';

@JsonSerializable()
class GetAllCategoriesResponseModel {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'metadata')
  final Metadata? metadata;
  @JsonKey(name: 'categories', defaultValue: [])
  final List<Category>? categories;

  GetAllCategoriesResponseModel({this.message, this.metadata, this.categories});

  factory GetAllCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllCategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCategoriesResponseModelToJson(this);

  GetCategoryListEntity toEntity() {
    return GetCategoryListEntity(
      categories: categories?.map((e) => e.toEntity()).toList(),
    );
  }
}
