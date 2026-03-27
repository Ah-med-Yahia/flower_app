class AddressEntity {
  final String? id;
  final String? street;
  final String? city;

  const AddressEntity({this.id, this.street, this.city});

  factory AddressEntity.fake() {
    return const AddressEntity(
      id: '1',
      street: 'Street Placeholder',
      city: 'City Placeholder',
    );
  }
}
