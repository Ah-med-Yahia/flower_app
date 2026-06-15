class TrackOrderModel {
  final String id;
  final String state;
  final String orderNumber;
  final String createdAt;
  final bool isDelivered;
  final DriverModel? driver;
  final StoreModel? store;
  final UserModel? user;

  const TrackOrderModel({
    required this.id,
    required this.state,
    required this.orderNumber,
    required this.createdAt,
    required this.isDelivered,
    this.driver,
    this.store,
    this.user,
  });

  factory TrackOrderModel.fromMap(Map<String, dynamic> map) {
    final orderMap = map['orders'] != null
        ? (map['orders'] as Map<String, dynamic>)
        : map;

    return TrackOrderModel(
      id: orderMap['id'] as String? ?? '',
      state: orderMap['state'] as String? ?? 'Accepted',
      orderNumber: orderMap['orderNumber'] as String? ?? '',
      createdAt: orderMap['createdAt'] as String? ?? '',
      isDelivered: orderMap['isDelivered'] as bool? ?? false,
      driver: map['driver'] != null
          ? DriverModel.fromMap(map['driver'] as Map<String, dynamic>)
          : null,
      store: orderMap['store'] != null
          ? StoreModel.fromMap(orderMap['store'] as Map<String, dynamic>)
          : null,
      user: orderMap['user'] != null
          ? UserModel.fromMap(orderMap['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class DriverModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String photo;
  final LocationModel? location;

  const DriverModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.photo,
    this.location,
  });

  String get fullName => '$firstName $lastName';

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      photo: map['photo'] as String? ?? '',
      location: map['location'] != null
          ? LocationModel.fromMap(map['location'] as Map<String, dynamic>)
          : null,
    );
  }
}

class StoreModel {
  final String name;
  final String address;
  final String phoneNumber;
  final String image;
  final String latLong;

  const StoreModel({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.image,
    required this.latLong,
  });

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      name: map['name'] as String? ?? '',
      address: map['address'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      image: map['image'] as String? ?? '',
      latLong: map['latLong'] as String? ?? '',
    );
  }
}

class UserModel {
  final String firstName;
  final String lastName;
  final String phone;
  final LocationModel? location;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.location,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      location: map['location'] != null
          ? LocationModel.fromMap(map['location'] as Map<String, dynamic>)
          : null,
    );
  }
}

class LocationModel {
  final double latitude;
  final double longitude;

  const LocationModel({required this.latitude, required this.longitude});

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
