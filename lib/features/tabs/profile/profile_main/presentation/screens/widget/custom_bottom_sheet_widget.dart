import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/cubit/profile_main_cubit.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/cubit/profile_main_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/shared/presentation/widgets/spacing.dart';

enum Language { english, arabic }

class CustomBottomSheetWidget extends StatefulWidget {
  const CustomBottomSheetWidget({super.key});

  @override
  State<CustomBottomSheetWidget> createState() =>
      _CustomBottomSheetWidgetState();
}

class _CustomBottomSheetWidgetState extends State<CustomBottomSheetWidget> {
  late Language? selectedLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedLanguage = context.locale.languageCode == 'en'
        ? Language.english
        : Language.arabic;
  }

  Widget buildLanguageItem({required Language language}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 1)],
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            selectedLanguage = language;
            context.read<ProfileMainCubit>().doIntent(
              UpdateLanguageIntent(language == Language.english ? 'en' : 'ar'),
            );
            context.setLocale(
              Locale(language == Language.english ? 'en' : 'ar'),
            );
          });
        },
        title: Text(
          language == Language.english
              ? AppTextConstants.english
              : AppTextConstants.arabic,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontFamily: GoogleFonts.outfit().fontFamily,
          ),
        ),
        trailing: Radio<Language>(
          activeColor: AppColors.primary,
          value: language == Language.english
              ? Language.english
              : Language.arabic,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final titleLarge = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.secondary,
      fontFamily: GoogleFonts.outfit().fontFamily,
    );
    return SizedBox(
      height: sizeHeight * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (sizeHeight * 0.03).verticalSpacing,
            Text(AppTextConstants.chooseLanguage, style: titleLarge),
            (sizeHeight * 0.015).verticalSpacing,
            RadioGroup(
              groupValue: selectedLanguage,
              onChanged: (Language? value) {
                setState(() {
                  selectedLanguage = value;
                  context.read<ProfileMainCubit>().doIntent(
                    UpdateLanguageIntent(
                      value == Language.english ? 'en' : 'ar',
                    ),
                  );
                  context.setLocale(
                    Locale(value == Language.english ? 'en' : 'ar'),
                  );
                });
              },
              child: Column(
                spacing: 16,
                children: [
                  buildLanguageItem(language: Language.english),
                  buildLanguageItem(language: Language.arabic),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
