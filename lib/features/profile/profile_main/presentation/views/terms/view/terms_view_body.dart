import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../core/constants/errors_constants.dart';
import '../../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../../core/widgets/loading_indicator_widget.dart';
import '../../../../domain/entities/about_app_entity.dart';
import '../../../../domain/entities/term_section_entity.dart';
import '../../../view_models/terms/static_content_cubit.dart';
import '../../../view_models/terms/static_content_states.dart';
import '../widget/terms_section_widget.dart';

class TermsViewBody extends StatefulWidget {
  final bool isAboutApp;

  const TermsViewBody({super.key, required this.isAboutApp});

  @override
  State<TermsViewBody> createState() => _TermsViewBodyState();
}

enum ShowContent { terms, about }

class _TermsViewBodyState extends State<TermsViewBody> {
  late final StaticContentCubit cubit;
  late String currentLanguage;
  late final isAboutApp = widget.isAboutApp;

  @override
  void initState() {
    super.initState();
    currentLanguage = AppTextConstants.enLang;
    cubit = context.read<StaticContentCubit>();
    _loadInitialData();
  }

  void _loadInitialData() {
    if (isAboutApp) {
      cubit.doIntent(GetAboutAppDataEvent());
    } else {
      cubit.doIntent(GetTermDataEvent());
    }
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
    return BlocBuilder<StaticContentCubit, StaticContentStates>(
      builder: (context, state) {
        final contentState = isAboutApp ? state.aboutState : state.legalState;
        if (contentState.isLoading) {
          return const Center(child: LoadingIndicator());
        }
        if (contentState.errorMessage != null) {
          final error = contentState.errorMessage!.trim().isEmpty
              ? ErrorsConstant.defaultError
              : contentState.errorMessage!;
          return CustomErrorWidget(
            error: error,
            onTryAgain: () => cubit.doIntent(
              isAboutApp ? GetAboutAppDataEvent() : GetTermDataEvent(),
            ),
          );
        }
        if (contentState.data == null) {
          return const Center(child: Text(ErrorsConstant.noContent));
        }

        final List<TermSectionEntity> contentData = isAboutApp
            ? (contentState.data as AboutAppEntity).aboutApp
            : (contentState.data as TermsAndConditionsEntity).sections;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              isAboutApp
                  ? (currentLanguage == AppTextConstants.enLang
                        ? AppTextConstants.appInfoAppBarTitleEn
                        : AppTextConstants.appInfoAppBarTitleAr)
                  : (currentLanguage == AppTextConstants.enLang
                        ? AppTextConstants.termsAppBarTitleEn
                        : AppTextConstants.termsAppBarTitleAr),
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
            itemCount: contentData.length,
            itemBuilder: (context, index) {
              final section = contentData[index];
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
