import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/cart/cart_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/order_request/order_request_entity.dart';
import 'package:flower_app/features/checkout/domain/use_cases/add_cache_order_use_case.dart';
import 'package:flower_app/features/checkout/domain/use_cases/add_credit_card_use_case.dart';
import 'package:flower_app/features/checkout/domain/use_cases/get_adresses_use_case.dart';
import 'package:flower_app/features/checkout/domain/use_cases/get_cart_info_use_case.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_intents.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_states.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_ui_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutStates> {
  final GetAdressesUseCase _getAdressesUseCase;
  final GetCartInfoUseCase _getCartInfoUseCase;
  final AddCacheOrderUseCase _addCacheOrderUseCase;
  final AddCreditCardUseCase _addCreditCardUseCase;

  final StreamController<CheckoutUiIntents> _uiIntentController =
      StreamController();

  Stream<CheckoutUiIntents> get uiIntent => _uiIntentController.stream;

  final _dateController = StreamController<String>();
  Timer? _timer;

  Stream<String> get dateStream => _dateController.stream;

  CheckoutCubit(
    this._getAdressesUseCase,
    this._getCartInfoUseCase,
    this._addCacheOrderUseCase,
    this._addCreditCardUseCase,
  ) : super(CheckoutStates(selectedPaymentMethod: AppTextConstants.cash));

  void doIntent(CheckoutIntents intent) {
    switch (intent) {
      case GetAdresses():
      case GetOrderDetails():
        _initializeCheckout();
        break;
      case SelectDeliveryAddressIntent():
        _selectAddress(intent.addressId);
        break;
      case EditDeliveryAddressIntent():
        _uiIntentController.add(
          NavigateToEditAddressIntent(addressId: intent.addressId),
        );
        break;
      case AddNewAddressIntent():
        _uiIntentController.add(NavigateToNewAddressIntent());
        break;
      case SelectPaymentMethodIntent():
        emit(state.copyWith(selectedPaymentMethod: intent.paymentMethod));
        break;
      case ToggleGiftOptionIntent():
        emit(state.copyWith(isGift: intent.isGift));
        break;
      case UpdateGiftNameIntent():
        emit(state.copyWith(giftName: intent.giftName));
        break;
      case UpdateGiftPhoneIntent():
        emit(state.copyWith(giftPhone: intent.giftPhone));
        break;
      case PlaceOrderIntent():
        if (state.cart == null || (state.cart?.totalPrice ?? 0) == 0) {
          _uiIntentController.add(
            ShowErrorIntent(message: AppTextConstants.emptyCart),
          );
          return;
        }
        _placeOrder();
        break;
    }
  }

  Future<void> _initializeCheckout() async {
    if (state.isLoading) return;
    if (state.addresses.isEmpty && state.cart == null) {
      emit(state.copyWith(isLoading: true));
    }

    final results = await Future.wait([
      _getAdressesUseCase(),
      _getCartInfoUseCase(),
    ]);

    final addressResult = results[0] as BaseResponse<List<AddressEntity>>;
    final cartResult = results[1] as BaseResponse<CartEntity>;

    CheckoutStates newState = state.copyWith(isLoading: false);

    addressResult.map(
      success: (response) {
        newState = newState.copyWith(addresses: response.data);
        if (response.data.isNotEmpty && state.selectedAddress == null) {
          newState = newState.copyWith(selectedAddress: response.data.first);
        }
      },
      failure: (error) {
        _uiIntentController.add(
          ShowErrorIntent(message: error.errorHandler.message),
        );
      },
    );

    cartResult.map(
      success: (response) {
        newState = newState.copyWith(cart: response.data);
      },
      failure: (error) {
        _uiIntentController.add(
          ShowErrorIntent(message: error.errorHandler.message),
        );
      },
    );

    emit(newState);
  }

  void _selectAddress(String addressId) {
    final address = state.addresses.firstWhere(
      (element) => element.id == addressId,
      orElse: () => state.addresses.first,
    );
    emit(state.copyWith(selectedAddress: address));
  }

  Future<void> _placeOrder() async {
    if (state.selectedAddress == null) {
      _uiIntentController.add(
        ShowErrorIntent(message: AppTextConstants.selectDeliveryAddress),
      );
      return;
    }

    if (state.isGift) {
      if (state.giftName.trim().isEmpty) {
        _uiIntentController.add(
          ShowErrorIntent(message: AppTextConstants.enterRecipientName),
        );
        return;
      }
      if (state.giftPhone.trim().isEmpty) {
        _uiIntentController.add(
          ShowErrorIntent(message: AppTextConstants.enterRecipientphone),
        );
        return;
      }
    }

    _uiIntentController.add(ShowLoadingIntent());

    final request = OrderRequestEntity(addressId: state.selectedAddress?.id);

    if (state.selectedPaymentMethod == AppTextConstants.credit) {
      final result = await _addCreditCardUseCase(request);
      emit(state.copyWith(isLoading: false));
      _uiIntentController.add(HideLoadingIntent());

      result.map(
        success: (response) {
          final url = response.data.session?.url;
          if (url != null) {
            _uiIntentController.add(NavigateToWebviewIntent(url: url));
          } else {
            _uiIntentController.add(
              ShowErrorIntent(message: AppTextConstants.paymentUrlNotFound),
            );
          }
        },
        failure: (error) {
          _uiIntentController.add(
            ShowErrorIntent(message: error.errorHandler.message),
          );
        },
      );
    } else {
      final result = await _addCacheOrderUseCase(request);
      emit(state.copyWith(isLoading: false));
      _uiIntentController.add(HideLoadingIntent());

      result.map(
        success: (response) {
          _uiIntentController.add(
            NavigateToSuccessIntent(
              message:
                  response.data.message ??
                  AppTextConstants.yourOrderPlacedSuccessfully,
            ),
          );
        },
        failure: (error) {
          _uiIntentController.add(
            ShowErrorIntent(message: error.errorHandler.message),
          );
        },
      );
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now().add(const Duration(hours: 1));
      final day = now.day.toString().padLeft(2, '0');
      final month = DateFormat('MMM').format(now);
      final year = now.year;
      final time = DateFormat('hh:mm a').format(now);
      _dateController.add('$day $month $year, $time');
    });
  }

  @override
  Future<void> close() {
    _uiIntentController.close();
    _timer?.cancel();
    _dateController.close();
    return super.close();
  }
}
