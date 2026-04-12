import 'dart:io';

import 'package:flower_app/core/helpers/image_picker_helper.dart';
import 'package:flower_app/features/tabs/profile/edit_profile/presentation/view_models/edit_profile_cubit.dart';
import 'package:flower_app/features/tabs/profile/edit_profile/presentation/view_models/edit_profile_events.dart';
import 'package:flower_app/features/tabs/profile/edit_profile/presentation/view_models/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/gen/assets.gen.dart';
import '../../../../../../../core/theme/app_colors.dart';

class EditProfilePictureSectionWidget extends StatefulWidget {
  final String pictureURL;

  const EditProfilePictureSectionWidget({super.key, required this.pictureURL});

  @override
  State<EditProfilePictureSectionWidget> createState() =>
      _EditProfilePictureSectionWidgetState();
}

class _EditProfilePictureSectionWidgetState
    extends State<EditProfilePictureSectionWidget> {
  Future<void> _pickImage() async {
    final File? file = await showImagePickerDialog(context);
    if (file != null) {
      if (mounted) {
        context.read<EditProfileCubit>().doIntent(
          ImagePickerEvent(imageFile: file),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(60),
            child: BlocBuilder<EditProfileCubit, EditProfileStates>(
              buildWhen: (previous, current) =>
                  current.imageUploadState != previous.imageUploadState,
              builder: (context, state) {
                return CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.secondary,
                  child: Image.network(
                    state.imageUploadState.data ?? widget.pictureURL,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                    errorBuilder: (context, error, stackTrace) =>
                        Assets.images.logo.image(),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 32,
            width: 32,
            child: FloatingActionButton.small(
              clipBehavior: Clip.antiAlias,
              onPressed: _pickImage,
              backgroundColor: AppColors.background,
              elevation: 0,
              child: const Icon(Icons.camera_alt_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
