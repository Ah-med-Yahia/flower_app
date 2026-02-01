import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String id;
  final String? street;
  final String? city;
  final String? lat;
  final String? long;
  final String? phone;
  final String? username;

  const AddressEntity({
    this.id = '',
    this.street,
    this.city,
    this.lat,
    this.long,
    this.phone,
    this.username,
  });

  factory AddressEntity.fake() {
    return const AddressEntity(
      street: 'Street Placeholder',
      city: 'City Placeholder',
      lat: '0.0',
      long: '0.0',
      phone: '1234567890',
    );
  }

  @override
  List<Object?> get props => [id, street, city, lat, long, phone, username];
}
