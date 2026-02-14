import 'package:equatable/equatable.dart';

class StateEntity extends Equatable {
  final String id;
  final String governorateNameAr;
  final String governorateNameEn;

  const StateEntity({
    required this.id,
    required this.governorateNameAr,
    required this.governorateNameEn,
  });

  factory StateEntity.fromJson(Map<String, dynamic> json) {
    return StateEntity(
      id: json['id'] ?? '',
      governorateNameAr: json['governorate_name_ar'] ?? '',
      governorateNameEn: json['governorate_name_en'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, governorateNameAr, governorateNameEn];
}
