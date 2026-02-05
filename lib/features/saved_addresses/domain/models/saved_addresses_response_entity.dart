import 'package:equatable/equatable.dart';

class SavedAddressesResponseEntity extends Equatable {
  final String message;
  final List<AddressEntity> addresses;

  const SavedAddressesResponseEntity({
    required this.message,
    required this.addresses,
  });

  @override
  List<Object?> get props => [message, addresses];
}

class AddressEntity extends Equatable {
  final String id;
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String username;

  const AddressEntity({
    required this.id,
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });

  @override
  List<Object?> get props => [id, street, phone, city, lat, long, username];
}
