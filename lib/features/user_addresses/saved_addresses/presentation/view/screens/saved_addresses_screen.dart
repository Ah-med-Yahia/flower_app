import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/core/widgets/custom_error_widget.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view/widgets/saved_address_card.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view_model/saved_addresses_cubit.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view_model/saved_addresses_events.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view_model/saved_addresses_states.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view_model/saved_addresses_ui_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  final SavedAddressesCubit savedAddressesCubit = getIt<SavedAddressesCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          savedAddressesCubit..onEvent(GetSavedAddressesEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => context.pop(),
            ),
          ),
          title: Text(AppTextConstants.savedAddresses),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocListener<SavedAddressesCubit, SavedAddressesStates>(
                listenWhen: (previous, current) {
                  return current.navigationEvent != null;
                },
                listener: (context, state) async {
                  final event = state.navigationEvent;
                  if (event is NavigateToAddUpdateAddressUiEvent) {
                    final result = await context.push(
                      AppRoutesConstants.addUpdateAddressRoute,
                      extra: event.address,
                    );

                    if (result == true && mounted) {
                      savedAddressesCubit.onEvent(GetSavedAddressesEvent());
                    }
                  }
                },
                child: BlocBuilder<SavedAddressesCubit, SavedAddressesStates>(
                  builder: (context, state) {
                    // Initial loading
                    if (state.savedAddressesState?.isLoading == true &&
                        state.savedAddressesState?.data == null) {
                      return const Center(child: LoadingIndicator());
                    }

                    // Error state
                    if ((state.savedAddressesState?.errorMessage?.isNotEmpty ??
                            false) &&
                        state.savedAddressesState?.errorMessage != null &&
                        state.savedAddressesState?.isLoading == false) {
                      return CustomErrorWidget(
                        error:
                            state.savedAddressesState?.errorMessage ??
                            ErrorsConstant.defaultError,
                        onTryAgain: () {
                          savedAddressesCubit.onEvent(GetSavedAddressesEvent());
                        },
                      );
                    }

                    // Address list
                    if (state.savedAddressesState?.data != null) {
                      final addresses =
                          state.savedAddressesState!.data!.addresses;
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: ListView.builder(
                              itemCount: addresses.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: SavedAddressCard(
                                    address: addresses[index],
                                    onEdit: () {
                                      savedAddressesCubit.onEvent(
                                        EditSavedAddressEvent(addresses[index]),
                                      );
                                    },
                                    onDelete: () {
                                      savedAddressesCubit.onEvent(
                                        DeleteSavedAddressEvent(
                                          addresses[index].id,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            // Add new address button - always visible at bottom
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  onPressed: () {
                    savedAddressesCubit.onEvent(AddNewAddressEvent());
                  },
                  child: Text(AppTextConstants.addNewAddress),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
