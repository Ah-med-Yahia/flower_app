import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';

class AdressesResponseEntity {
  final String? message;
  final List<AddressEntity>? addresses;

  const AdressesResponseEntity({this.message, this.addresses});
}
