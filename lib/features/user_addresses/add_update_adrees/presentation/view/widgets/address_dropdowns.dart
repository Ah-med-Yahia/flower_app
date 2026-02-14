import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/city_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/state_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view/widgets/custom_dropdown_field.dart';
import 'package:flutter/material.dart';

class AddressDropdowns extends StatelessWidget {
  final List<StateEntity> governorates;
  final List<CityEntity> cities;
  final StateEntity? selectedGovernorate;
  final CityEntity? selectedCity;
  final ValueChanged<StateEntity> onGovernorateChanged;
  final ValueChanged<CityEntity> onCityChanged;

  const AddressDropdowns({
    super.key,
    required this.governorates,
    required this.cities,
    required this.selectedGovernorate,
    required this.selectedCity,
    required this.onGovernorateChanged,
    required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomDropdownField<StateEntity>(
            labelText: AppTextConstants.state,
            hintText: AppTextConstants.selectState,
            value: selectedGovernorate,
            items: governorates,
            itemLabel: (gov) => gov.governorateNameEn,
            onChanged: (value) {
              if (value != null) onGovernorateChanged(value);
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomDropdownField<CityEntity>(
            labelText: AppTextConstants.city,
            hintText: AppTextConstants.selectCity,
            value: selectedCity,
            enabled: selectedGovernorate != null,
            items: cities,
            itemLabel: (city) => city.cityNameEn,
            onChanged: (value) {
              if (value != null) onCityChanged(value);
            },
          ),
        ),
      ],
    );
  }
}
