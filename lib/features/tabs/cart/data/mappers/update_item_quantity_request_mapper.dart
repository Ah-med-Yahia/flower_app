import 'package:flower_app/features/tabs/cart/data/models/update_item_quantity_request_model.dart';
import 'package:flower_app/features/tabs/cart/domain/entities/update_item_quantity_request_entity.dart';

extension UpdateItemQuantityRequestMapper on UpdateItemQuantityRequestEntity {
  UpdateItemQuantityRequestModel toModel() {
    return UpdateItemQuantityRequestModel(quantity: quantity);
  }
}
