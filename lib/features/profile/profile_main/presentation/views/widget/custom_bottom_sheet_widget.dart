import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/spacing.dart';

enum Language { english, arabic }

class CustomBottomSheetWidget extends StatefulWidget {
  const CustomBottomSheetWidget({super.key});

  @override
  State<CustomBottomSheetWidget> createState() =>
      _CustomBottomSheetWidgetState();
}

class _CustomBottomSheetWidgetState extends State<CustomBottomSheetWidget> {
  Language? selectedLanguage = Language.english;

  Widget buildLanguageItem({required Language language}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 1)],
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            selectedLanguage = language;
          });
        },
        title: Text(
          language == Language.english ? 'English' : 'Arabic',
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
            Text('Choose Language', style: titleLarge),
            (sizeHeight * 0.015).verticalSpacing,
            RadioGroup(
              groupValue: selectedLanguage,
              onChanged: (Language? value) {
                setState(() {
                  selectedLanguage = value;
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
