import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/shared/presentation/widgets/toast_utils.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/location_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view_model/add_update_addresse_cubit.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view_model/add_update_addresse_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class AddAddressListeners extends StatelessWidget {
  final Widget child;
  final MapController mapController;
  final ValueChanged<LocationEntity> onLocationChanged;
  final bool isEditing; // ADD THIS

  const AddAddressListeners({
    super.key,
    required this.child,
    required this.mapController,
    required this.onLocationChanged,
    required this.isEditing, // ADD THIS
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
          listenWhen: (p, c) => p.locationState != c.locationState,
          listener: (context, state) {
            final location = state.locationState?.data;

            if (location != null && state.locationState?.isLoading == false) {
              onLocationChanged(location);

              mapController.move(
                LatLng(location.latitude, location.longitude),
                13,
              );
            }
          },
        ),

        BlocListener<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
          listenWhen: (p, c) => p.addUpdateState != c.addUpdateState,
          listener: (context, state) {
            if (state.addUpdateState?.data != null) {
              // CHANGE THIS SECTION:
              ToastUtils.showSuccessToast(
                context,
                isEditing
                    ? AppTextConstants.addressUpdatedSuccessfully
                    : AppTextConstants.addressSavedSuccessfully,
              );
              context.pop(true); // Add this to close the screen after success
            }

            if (state.addUpdateState?.errorMessage != null) {
              ToastUtils.showErrorToast(
                context,
                state.addUpdateState!.errorMessage!,
              );
            }
          },
        ),
      ],
      child: child,
    );
  }
}
