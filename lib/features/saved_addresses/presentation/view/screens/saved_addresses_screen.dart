import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/core/widgets/custom_error_widget.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';
import 'package:flower_app/features/saved_addresses/presentation/view/widgets/saved_address_card.dart';
import 'package:flower_app/features/saved_addresses/presentation/view_model/saved_addresses_cubit.dart';
import 'package:flower_app/features/saved_addresses/presentation/view_model/saved_addresses_events.dart';
import 'package:flower_app/features/saved_addresses/presentation/view_model/saved_addresses_states.dart';
import 'package:flower_app/features/saved_addresses/presentation/view_model/saved_addresses_ui_events.dart';
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
      child: BlocListener<SavedAddressesCubit, SavedAddressesStates>(
        listenWhen: (previous, current) {
          // Only listen for navigation events
          return current.navigationEvent != null;
        },
        listener: (context, state) {
          final event = state.navigationEvent;
          if (event is NavigateToAddUpdateAddressUiEvent) {
            // Navigate to add/update address screen with optional addressId
          }
        },
        child: BlocBuilder<SavedAddressesCubit, SavedAddressesStates>(
          builder: (context, state) {
            if (state.savedAddressesState?.isLoading == true) {
              return const Scaffold(body: Center(child: LoadingIndicator()));
            }

            if ((state.savedAddressesState?.errorMessage?.isNotEmpty ??
                    false) &&
                state.savedAddressesState?.errorMessage != null &&
                state.savedAddressesState?.isLoading == false) {
              return Scaffold(
                body: CustomErrorWidget(
                  error:
                      state.savedAddressesState?.errorMessage ??
                      ErrorsConstant.defaultError,
                  onTryAgain: () {
                    savedAddressesCubit.onEvent(GetSavedAddressesEvent());
                  },
                ),
              );
            }

            if (state.savedAddressesState?.data != null &&
                state.savedAddressesState?.isLoading == false) {
              final addresses = state.savedAddressesState!.data!.addresses;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => context.pop(),
                  ),
                  title: Text(AppTextConstants.savedAddresses),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                    itemCount: addresses.length + 1,
                    itemBuilder: (context, index) {
                      if (index == addresses.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 20),
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
                                savedAddressesCubit.onEvent(
                                  AddNewAddressEvent(),
                                );
                              },
                              child: Text(AppTextConstants.addNewAddress),
                            ),
                          ),
                        );
                      }

                      // Address cards
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SavedAddressCard(
                          address: addresses[index],
                          onEdit: () {
                            savedAddressesCubit.onEvent(
                              EditSavedAddressEvent(addresses[index].id),
                            );
                          },
                          onDelete: () {
                            savedAddressesCubit.onEvent(
                              DeleteSavedAddressEvent(addresses[index].id),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
