import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/branding_settings_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'icon_model.dart';
import 'logo_model.dart';
part 'branding_settings_model.g.dart';

@JsonSerializable()
class BrandingSettingsModel {
  @JsonKey(name: 'background_color')
  final String? backgroundColor;
  @JsonKey(name: 'border_style')
  final String? borderStyle;
  @JsonKey(name: 'button_color')
  final String? buttonColor;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'font_family')
  final String? fontFamily;
  @JsonKey(name: 'icon')
  final IconModel? icon;
  @JsonKey(name: 'logo')
  final LogoModel? logo;

  const BrandingSettingsModel({
    this.backgroundColor,
    this.borderStyle,
    this.buttonColor,
    this.displayName,
    this.fontFamily,
    this.icon,
    this.logo,
  });

  factory BrandingSettingsModel.fromJson(Map<String, dynamic> json) {
    return BrandingSettingsModel(
      backgroundColor: json['background_color'] as String?,
      borderStyle: json['border_style'] as String?,
      buttonColor: json['button_color'] as String?,
      displayName: json['display_name'] as String?,
      fontFamily: json['font_family'] as String?,
      icon: json['icon'] == null
          ? null
          : IconModel.fromJson(json['icon'] as Map<String, dynamic>),
      logo: json['logo'] == null
          ? null
          : LogoModel.fromJson(json['logo'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'background_color': backgroundColor,
    'border_style': borderStyle,
    'button_color': buttonColor,
    'display_name': displayName,
    'font_family': fontFamily,
    'icon': icon?.toJson(),
    'logo': logo?.toJson(),
  };

  BrandingSettingsEntity toEntity() {
    return BrandingSettingsEntity(
      backgroundColor: backgroundColor,
      borderStyle: borderStyle,
      buttonColor: buttonColor,
      displayName: displayName,
      fontFamily: fontFamily,
      icon: icon?.toEntity(),
      logo: logo?.toEntity(),
    );
  }
}
