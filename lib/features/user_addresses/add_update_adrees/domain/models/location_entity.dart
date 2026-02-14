import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final double latitude;
  final double longitude;
  final String? street;
  final String? city;
  final String? state;
  const LocationEntity({
    required this.latitude,
    required this.longitude,
    this.street,
    this.city,
    this.state,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
