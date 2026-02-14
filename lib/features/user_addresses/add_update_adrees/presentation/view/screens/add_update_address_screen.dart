import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/validators/app_validators.dart';
import 'package:flower_app/core/widgets/arrow_back_button.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/city_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/location_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/state_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view/widgets/address_dropdowns.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view/widgets/address_form_fields.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view/widgets/address_listeners.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view/widgets/address_map_widget.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view_model/add_update_addresse_cubit.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view_model/add_update_addresse_events.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view_model/add_update_addresse_states.dart';
import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

  bool _isInitialDataLoaded = false;

  bool get isFormValid =>
      _addressController.text.isNotEmpty &&
      AppValidators.validatePhoneNumber(_phoneController.text) == null &&
      _nameController.text.isNotEmpty &&
      selectedGovernorate != null &&
      selectedCity != null &&
      selectedLocation != null &&
      (widget.address == null ||
          widget.address!.street != _addressController.text ||
          widget.address!.phone != _phoneController.text ||
          widget.address!.city != selectedCity!.cityNameEn ||
          widget.address!.lat != selectedLocation!.latitude.toString() ||
          widget.address!.long != selectedLocation!.longitude.toString() ||
          widget.address!.username != _nameController.text);

  @override
  void initState() {
    super.initState();
    _addressController.addListener(_onFormChanged);
    _phoneController.addListener(_onFormChanged);
    _nameController.addListener(_onFormChanged);

    // Pre-fill form fields if editing existing address
    if (widget.address != null) {
      _addressController.text = widget.address!.street;
      _phoneController.text = widget.address!.phone;
      _nameController.text = widget.address!.username;
      selectedLocation = LocationEntity(
        latitude: double.tryParse(widget.address!.lat) ?? 0.0,
        longitude: double.tryParse(widget.address!.long) ?? 0.0,
      );

      // Move map to stored location
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (selectedLocation != null) {
          _mapController.move(
            LatLng(selectedLocation!.latitude, selectedLocation!.longitude),
            15.0,
          );
        }
      });
    }
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
      create: (_) => cubit
        ..onEvent(
          // Skip getting current location if editing existing address
          widget.address != null
              ? GetGovernoratesEvent()
              : LoadInitialDataEvent(),
        ),
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
          isEditing: widget.address != null,
          child: BlocBuilder<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
            builder: (context, state) {
              if (state.governoratesState?.isLoading == true) {
                return const LoadingIndicator();
              }

              // Auto-load governorate and city for existing address
              if (widget.address != null &&
                  !_isInitialDataLoaded &&
                  selectedGovernorate == null &&
                  state.governoratesState?.data != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _loadExistingAddressData(
                    context,
                    state.governoratesState!.data!,
                  );
                });
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
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _loadExistingAddressData(
    BuildContext context,
    List<StateEntity> governorates,
  ) async {
    if (widget.address == null || _isInitialDataLoaded) return;

    final cubit = context.read<AddUpdateAddresseCubit>();
    final cityName = widget.address!.city;

    // Search through all governorates to find the one containing this city
    for (final governorate in governorates) {
      // Load cities for this governorate
      cubit.onEvent(GetCitiesEvent(governorateId: governorate.id));

      // Wait for cities to load
      await Future.delayed(const Duration(milliseconds: 200));

      final cities = cubit.state.citiesState?.data ?? [];

      // Check if this governorate contains our city
      final matchingCity = cities.cast<CityEntity?>().firstWhere(
        (city) => city?.cityNameEn == cityName,
        orElse: () => null,
      );

      if (matchingCity != null) {
        // Found it! Set the governorate and city
        setState(() {
          selectedGovernorate = governorate;
          selectedCity = matchingCity;
          _isInitialDataLoaded = true;
        });
        break;
      }
    }

    // If city not found in any governorate, mark as loaded anyway
    if (!_isInitialDataLoaded) {
      setState(() {
        _isInitialDataLoaded = true;
      });
    }
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
