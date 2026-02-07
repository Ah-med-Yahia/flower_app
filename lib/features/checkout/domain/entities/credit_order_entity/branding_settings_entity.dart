import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/icon_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/logo_entity.dart';

class BrandingSettingsEntity {
  final String? backgroundColor;
  final String? borderStyle;
  final String? buttonColor;
  final String? displayName;
  final String? fontFamily;
  final IconEntity? icon;
  final LogoEntity? logo;

  const BrandingSettingsEntity({
    this.backgroundColor,
    this.borderStyle,
    this.buttonColor,
    this.displayName,
    this.fontFamily,
    this.icon,
    this.logo,
  });
}
