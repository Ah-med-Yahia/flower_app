import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/di/di.dart';
import '../../../../profile_main/domain/entities/user_data_response.dart';
import '../../view_models/edit_profile_cubit.dart';
import 'edit_profile_view_body.dart';

class EditProfileView extends StatelessWidget {
  final UserDataResponse userData;

  const EditProfileView({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EditProfileCubit>(),
      child: EditProfileViewBody(userData: userData),
    );
  }
}
