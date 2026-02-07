import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';

class OrderRequestEntity {
  final AddressEntity? addressEntity;

  OrderRequestEntity({this.addressEntity});
}
