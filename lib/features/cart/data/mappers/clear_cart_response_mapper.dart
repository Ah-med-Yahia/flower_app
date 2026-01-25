import 'package:flower_app/features/cart/data/models/clear_cart_response_model.dart';
import 'package:flower_app/features/cart/domain/entities/clear_cart_response_entity.dart';

extension ClearCartResponseMapper on ClearCartResponseModel {
  ClearCartResponseEntity toEntity() {
    return ClearCartResponseEntity(message: message);
  }
}
