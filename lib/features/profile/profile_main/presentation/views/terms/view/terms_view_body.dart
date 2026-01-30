import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../core/constants/errors_constants.dart';
import '../../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../../core/widgets/loading_indicator_widget.dart';
import '../../../view_models/terms/term_cubit.dart';
import '../widget/terms_section_widget.dart';

class TermsViewBody extends StatefulWidget {
  const TermsViewBody({super.key});

  @override
  State<TermsViewBody> createState() => _TermsViewBodyState();
}

class _TermsViewBodyState extends State<TermsViewBody> {
  late final TermCubit cubit;
  late String currentLanguage;

  @override
  void initState() {
    super.initState();
    cubit = context.read<TermCubit>();
    cubit.doIntent(GetTermDataEvent());
    const String initialLanguage = AppTextConstants.enLang;
    currentLanguage = initialLanguage;
  }

  void toggleLanguage() {
    setState(() {
      currentLanguage = currentLanguage == AppTextConstants.enLang
          ? AppTextConstants.arLang
          : AppTextConstants.enLang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TermCubit, TermStates>(
      builder: (context, state) {
        final termState = state.termState;

        if (termState.isLoading) {
          return const Center(child: LoadingIndicator());
        }
        if (termState.errorMessage != null) {
          final error = termState.errorMessage!.trim().isEmpty
              ? ErrorsConstant.defaultError
              : termState.errorMessage!;
          return CustomErrorWidget(
            error: error,
            onTryAgain: () => cubit.doIntent(GetTermDataEvent()),
          );
        }
        if (termState.data == null) {
          return const Center(child: Text(ErrorsConstant.noContent));
        }
        final termsData = termState.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              currentLanguage == AppTextConstants.enLang
                  ? AppTextConstants.termsAppBarTitleEn
                  : AppTextConstants.termsAppBarTitleAr,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.language),
                onPressed: toggleLanguage,
                tooltip: currentLanguage == AppTextConstants.enLang
                    ? AppTextConstants.switchToArabic
                    : AppTextConstants.switchToEnglish,
              ),
            ],
          ),
          body: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            padding: const EdgeInsets.all(16),
            itemCount: termsData.sections.length,
            itemBuilder: (context, index) {
              final section = termsData.sections[index];
              return TermsSectionWidget(
                section: section,
                language: currentLanguage,
              );
            },
          ),
        );
      },
    );
  }
}
