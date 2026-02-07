import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/cart/cart_entity.dart';

class CheckoutStates extends BaseState<void> {
  final CartEntity? cart;
  final List<AddressEntity> addresses;

  final AddressEntity? selectedAddress;
  final String selectedPaymentMethod;

  final bool isGift;
  final String giftName;
  final String giftPhone;

  const CheckoutStates({
    super.errorMessage,
    super.isLoading,
    this.cart,
    this.addresses = const [],
    this.selectedAddress,
    this.selectedPaymentMethod = 'cash',
    this.isGift = false,
    this.giftName = '',
    this.giftPhone = '',
  });

  @override
  List<Object?> get props => [
    errorMessage,
    isLoading,
    cart,
    addresses,
    selectedAddress,
    selectedPaymentMethod,
    isGift,
    giftName,
    giftPhone,
  ];

  @override
  CheckoutStates copyWith({
    void data,
    String? errorMessage,
    bool? isLoading,
    CartEntity? cart,
    List<AddressEntity>? addresses,
    AddressEntity? selectedAddress,
    String? selectedPaymentMethod,
    bool? isGift,
    String? giftName,
    String? giftPhone,
  }) {
    return CheckoutStates(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      cart: cart ?? this.cart,
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isGift: isGift ?? this.isGift,
      giftName: giftName ?? this.giftName,
      giftPhone: giftPhone ?? this.giftPhone,
    );
  }
}
