import 'package:flower_app/features/checkout/data/models/response/credit_card_order/metadata_model.dart';
import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/invoice_data_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'invoice_data_model.g.dart';

@JsonSerializable()
class InvoiceDataModel {
  @JsonKey(name: 'account_tax_ids')
  final dynamic accountTaxIds;
  @JsonKey(name: 'custom_fields')
  final dynamic customFields;
  @JsonKey(name: 'description')
  final dynamic description;
  @JsonKey(name: 'footer')
  final dynamic footer;
  @JsonKey(name: 'issuer')
  final dynamic issuer;
  @JsonKey(name: 'metadata')
  final MetadataModel? metadata;
  @JsonKey(name: 'rendering_options')
  final dynamic renderingOptions;

  const InvoiceDataModel({
    this.accountTaxIds,
    this.customFields,
    this.description,
    this.footer,
    this.issuer,
    this.metadata,
    this.renderingOptions,
  });

  factory InvoiceDataModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDataModel(
        accountTaxIds: json['account_tax_ids'] as dynamic,
        customFields: json['custom_fields'] as dynamic,
        description: json['description'] as dynamic,
        footer: json['footer'] as dynamic,
        issuer: json['issuer'] as dynamic,
        metadata: json['metadata'] == null
            ? null
            : MetadataModel.fromJson(json['metadata'] as Map<String, dynamic>),
        renderingOptions: json['rendering_options'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
    'account_tax_ids': accountTaxIds,
    'custom_fields': customFields,
    'description': description,
    'footer': footer,
    'issuer': issuer,
    'metadata': metadata?.toJson(),
    'rendering_options': renderingOptions,
  };

  InvoiceDataEntity toEntity() {
    return InvoiceDataEntity(
      accountTaxIds: accountTaxIds,
      customFields: customFields,
      description: description,
      footer: footer,
      issuer: issuer,
      metadata: metadata?.toEntity(),
      renderingOptions: renderingOptions,
    );
  }
}
