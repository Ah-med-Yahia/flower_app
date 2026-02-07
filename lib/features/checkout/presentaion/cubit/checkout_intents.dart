sealed class CheckoutIntents {
  const CheckoutIntents();
}

class GetAdresses extends CheckoutIntents {}

class GetOrderDetails extends CheckoutIntents {}

class SelectDeliveryAddressIntent extends CheckoutIntents {
  final String addressId;
  const SelectDeliveryAddressIntent(this.addressId);
}

class EditDeliveryAddressIntent extends CheckoutIntents {
  final String addressId;
  const EditDeliveryAddressIntent(this.addressId);
}

class AddNewAddressIntent extends CheckoutIntents {}

class SelectPaymentMethodIntent extends CheckoutIntents {
  final String paymentMethod;
  const SelectPaymentMethodIntent(this.paymentMethod);
}

class ToggleGiftOptionIntent extends CheckoutIntents {
  final bool isGift;
  const ToggleGiftOptionIntent(this.isGift);
}

class UpdateGiftNameIntent extends CheckoutIntents {
  final String giftName;
  const UpdateGiftNameIntent(this.giftName);
}

class UpdateGiftPhoneIntent extends CheckoutIntents {
  final String giftPhone;
  const UpdateGiftPhoneIntent(this.giftPhone);
}

class PlaceOrderIntent extends CheckoutIntents {}
