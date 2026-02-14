import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/invoice_creation_entity.dart';

import 'invoice_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'invoice_creation_model.g.dart';

@JsonSerializable()
class InvoiceCreationModel {
  @JsonKey(name: 'enabled')
  final bool? enabled;
  @JsonKey(name: 'invoice_data')
  final InvoiceDataModel? invoiceData;

  const InvoiceCreationModel({this.enabled, this.invoiceData});

  factory InvoiceCreationModel.fromJson(Map<String, dynamic> json) {
    return InvoiceCreationModel(
      enabled: json['enabled'] as bool?,
      invoiceData: json['invoice_data'] == null
          ? null
          : InvoiceDataModel.fromJson(
              json['invoice_data'] as Map<String, dynamic>,
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'invoice_data': invoiceData?.toJson(),
  };

  InvoiceCreationEntity toEntity() {
    return InvoiceCreationEntity(
      enabled: enabled,
      invoiceData: invoiceData?.toEntity(),
    );
  }
}
