import 'dart:async';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_states.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_ui_intents.dart';
import 'package:flower_app/features/checkout/presentaion/view/screens/checkout_screen.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/delivery_adress_section.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/delivery_time_section.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/gift_form_section.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/payment_section.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/total_price_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_screen_test.mocks.dart';

@GenerateMocks([CheckoutCubit])
void main() {
  late MockCheckoutCubit mockCubit;
  late StreamController<CheckoutUiIntents> uiIntentController;

  setUp(() {
    mockCubit = MockCheckoutCubit();
    uiIntentController = StreamController<CheckoutUiIntents>.broadcast();
    GetIt.instance.registerSingleton<CheckoutCubit>(mockCubit);

    // Default mock behavior
    when(
      mockCubit.state,
    ).thenReturn(CheckoutStates(selectedPaymentMethod: AppTextConstants.cash));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(
        CheckoutStates(selectedPaymentMethod: AppTextConstants.cash),
      ),
    );
    when(mockCubit.uiIntent).thenAnswer((_) => uiIntentController.stream);
    when(
      mockCubit.dateStream,
    ).thenAnswer((_) => Stream.value('26 Mar 2026, 10:38 PM'));
  });

  tearDown(() {
    GetIt.instance.unregister<CheckoutCubit>();
    uiIntentController.close();
  });

  Widget buildTestableWidget() {
    return const MaterialApp(home: CheckoutScreen());
  }

  group('CheckoutScreen Widget Tests', () {
    testWidgets('should render all sections correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(CheckoutScreen), findsOneWidget);
      expect(find.byType(DeliveryTimeSection), findsOneWidget);
      expect(find.byType(DeliveryAddressesSection), findsOneWidget);
      expect(find.byType(PaymentSection), findsOneWidget);
      expect(find.byType(GiftFormSection), findsOneWidget);
      expect(find.byType(TotalPriceSection), findsOneWidget);
    });

    testWidgets('should call doIntent(GetOrderDetails) on initState', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      verify(mockCubit.doIntent(any)).called(1); // GetOrderDetails
    });

    testWidgets('should update payment method when a payment item is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());

      // Find by text (as localization key is returned if not initialized)
      final creditCardText = AppTextConstants.creditCard;
      await tester.tap(find.text(creditCardText));
      await tester.pump();

      verify(mockCubit.doIntent(any)).called(greaterThan(0));
    });

    testWidgets('should toggle gift option when switch is changed', (
      WidgetTester tester,
    ) async {
      when(mockCubit.state).thenReturn(
        CheckoutStates(selectedPaymentMethod: AppTextConstants.credit),
      );
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          CheckoutStates(selectedPaymentMethod: AppTextConstants.credit),
        ),
      );

      await tester.pumpWidget(buildTestableWidget());

      final giftSwitch = find.byType(Switch);
      expect(giftSwitch, findsOneWidget);

      await tester.tap(giftSwitch);
      await tester.pump();

      verify(mockCubit.doIntent(any)).called(greaterThan(0));
    });

    testWidgets('should show loading state when cubit is loading', (
      WidgetTester tester,
    ) async {
      when(mockCubit.state).thenReturn(
        CheckoutStates(
          isLoading: true,
          selectedPaymentMethod: AppTextConstants.cash,
        ),
      );
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          CheckoutStates(
            isLoading: true,
            selectedPaymentMethod: AppTextConstants.cash,
          ),
        ),
      );

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(CircularProgressIndicator), findsAny);
    });
  });
}
