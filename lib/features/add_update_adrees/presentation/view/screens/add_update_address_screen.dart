import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/validators/app_validators.dart';
import 'package:flower_app/core/widgets/arrow_back_button.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_response_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/city_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/location_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/state_entity.dart';
import 'package:flower_app/features/add_update_adrees/presentation/view/widgets/address_dropdowns.dart';
import 'package:flower_app/features/add_update_adrees/presentation/view/widgets/address_form_fields.dart';
import 'package:flower_app/features/add_update_adrees/presentation/view/widgets/address_listeners.dart';
import 'package:flower_app/features/add_update_adrees/presentation/view/widgets/address_map_widget.dart';
import 'package:flower_app/features/add_update_adrees/presentation/view_model/add_update_addresse_cubit.dart';
import 'package:flower_app/features/add_update_adrees/presentation/view_model/add_update_addresse_events.dart';
import 'package:flower_app/features/add_update_adrees/presentation/view_model/add_update_addresse_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

class AddUpdateAddressScreen extends StatefulWidget {
  final AddressEntity? address;
  const AddUpdateAddressScreen({super.key, this.address});

  @override
  State<AddUpdateAddressScreen> createState() => _AddUpdateAddressScreenState();
}

class _AddUpdateAddressScreenState extends State<AddUpdateAddressScreen> {
  LocationEntity? selectedLocation;
  StateEntity? selectedGovernorate;
  CityEntity? selectedCity;

  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _mapController = MapController();

  bool get isFormValid =>
      _addressController.text.isNotEmpty &&
      AppValidators.validatePhoneNumber(_phoneController.text) == null &&
      _nameController.text.isNotEmpty &&
      selectedGovernorate != null &&
      selectedCity != null &&
      selectedLocation != null;
  @override
  void initState() {
    super.initState();
    _addressController.addListener(_onFormChanged);
    _phoneController.addListener(_onFormChanged);
    _nameController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<AddUpdateAddresseCubit>();
    return BlocProvider(
      create: (_) => cubit..onEvent(LoadInitialDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppTextConstants.address),
          leading: const ArrowBackButton(),
        ),
        body: AddAddressListeners(
          mapController: _mapController,
          onLocationChanged: (location) {
            setState(() => selectedLocation = location);
          },
          child: BlocBuilder<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
            builder: (context, state) {
              if (state.governoratesState?.isLoading == true) {
                return const LoadingIndicator();
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    AddressMapWidget(
                      mapController: _mapController,
                      selectedLocation: selectedLocation,
                      isLoading: state.locationState?.isLoading ?? false,
                      onMapTap: (latLng) {
                        setState(() {
                          selectedLocation = LocationEntity(
                            latitude: latLng.latitude,
                            longitude: latLng.longitude,
                          );
                        });
                      },
                      onGetCurrentLocation: () {
                        setState(() {
                          selectedGovernorate = null;
                          selectedCity = null;
                        });
                        context.read<AddUpdateAddresseCubit>().onEvent(
                          GetCurrentLocationEvent(),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    AddressFormFields(
                      addressController: _addressController,
                      phoneController: _phoneController,
                      nameController: _nameController,
                    ),
                    const SizedBox(height: 16),
                    AddressDropdowns(
                      governorates: state.governoratesState?.data ?? [],
                      cities: state.citiesState?.data ?? [],
                      selectedGovernorate: selectedGovernorate,
                      selectedCity: selectedCity,
                      onGovernorateChanged: (gov) {
                        setState(() {
                          selectedGovernorate = gov;
                          selectedCity = null;
                        });
                        context.read<AddUpdateAddresseCubit>().onEvent(
                          GetCitiesEvent(governorateId: gov.id),
                        );
                        context.read<AddUpdateAddresseCubit>().onCityChanged(
                          gov.governorateNameEn,
                          '',
                        );
                      },
                      onCityChanged: (city) {
                        setState(() => selectedCity = city);
                        if (selectedGovernorate != null) {
                          context.read<AddUpdateAddresseCubit>().onCityChanged(
                            selectedGovernorate!.governorateNameEn,
                            city.cityNameEn,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isFormValid
                            ? () => _handleSave(context)
                            : null,
                        child: state.addUpdateState?.isLoading ?? false
                            ? const LoadingIndicator()
                            : Text(
                                AppTextConstants.saveAddress,
                                style: const TextStyle(
                                  color: AppColors.background,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleSave(BuildContext context) {
    final request = AddUpdateAddressRequestEntity(
      street: _addressController.text,
      phone: _phoneController.text,
      city: selectedCity!.cityNameEn,
      lat: selectedLocation!.latitude.toString(),
      long: selectedLocation!.longitude.toString(),
      username: _nameController.text,
    );

    if (widget.address != null) {
      context.read<AddUpdateAddresseCubit>().onEvent(
        UpdateAddressEvent(address: request, id: widget.address!.id),
      );
    } else {
      context.read<AddUpdateAddresseCubit>().onEvent(
        AddAddressEvent(address: request),
      );
    }
  }
}
