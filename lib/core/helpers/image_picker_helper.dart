import 'dart:io';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> showImagePickerDialog(BuildContext context) async {
  final ImageSource? source = await showDialog<ImageSource>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        AppTextConstants.uploadPhoto,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      backgroundColor: AppColors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(Icons.photo_library, color: AppColors.primary),
            ),
            title: Text(
              AppTextConstants.gallery,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              AppTextConstants.chooseFromYourPhotos,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(Icons.camera_alt, color: AppColors.primary),
            ),
            title: Text(
              AppTextConstants.camera,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              AppTextConstants.takeNewPhoto,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text(
            AppTextConstants.cancel,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );

  if (source == null) return null;

  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: source);

  return image != null ? File(image.path) : null;
}
