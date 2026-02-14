import 'package:flutter/material.dart';

import '../../../../../../core/gen/assets.gen.dart';
import '../../../../../../core/theme/app_colors.dart';

class EditProfilePictureSectionWidget extends StatelessWidget {
  final String pictureURL;

  const EditProfilePictureSectionWidget({super.key, required this.pictureURL});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(60),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.secondary,
              child: Image.network(
                pictureURL,
                fit: BoxFit.cover,
                width: 120,
                height: 120,
                errorBuilder: (context, error, stackTrace) =>
                    Assets.images.logo.image(),
              ),
            ),
          ),
          SizedBox(
            height: 32,
            width: 32,
            child: FloatingActionButton.small(
              clipBehavior: Clip.antiAlias,
              onPressed: () {
                // Image picker logic
              },
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
