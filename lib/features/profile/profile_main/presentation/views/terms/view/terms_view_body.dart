import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../../core/widgets/loading_indicator_widget.dart';
import '../../../view_models/terms/static_content_cubit.dart';
import '../../../view_models/terms/static_content_states.dart';
import '../widget/terms_section_widget.dart';

class TermsViewBody extends StatefulWidget {
  final bool isAboutApp;

  const TermsViewBody({super.key, required this.isAboutApp});

  @override
  State<TermsViewBody> createState() => _TermsViewBodyState();
}

class _TermsViewBodyState extends State<TermsViewBody> {
  late final StaticContentCubit cubit;
  late String currentLanguage;
  late final bool isAboutApp;

  @override
  void initState() {
    super.initState();
    isAboutApp = widget.isAboutApp;
    currentLanguage = AppTextConstants.enLangKey;
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
      currentLanguage = currentLanguage == AppTextConstants.enLangKey
          ? AppTextConstants.arLangKey
          : AppTextConstants.enLangKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isAboutApp
              ? (currentLanguage == AppTextConstants.enLangKey
                    ? AppTextConstants.appInfoAppBarTitleEn
                    : AppTextConstants.appInfoAppBarTitleAr)
              : (currentLanguage == AppTextConstants.enLangKey
                    ? AppTextConstants.termsAppBarTitleEn
                    : AppTextConstants.termsAppBarTitleAr),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: toggleLanguage,
            tooltip: currentLanguage == AppTextConstants.enLangKey
                ? AppTextConstants.switchToArabic
                : AppTextConstants.switchToEnglish,
          ),
        ],
      ),
      body: BlocBuilder<StaticContentCubit, StaticContentStates>(
        builder: (context, state) {
          if (state.contentIsLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (state.contentErrorMessage.isNotEmpty &&
              state.contentsData.isEmpty) {
            return CustomErrorWidget(
              error: state.contentErrorMessage,
              onTryAgain: () => cubit.doIntent(
                isAboutApp ? GetAboutAppDataEvent() : GetTermDataEvent(),
              ),
            );
          }

          if (state.contentsData.isEmpty) {
            return Center(child: Text(AppTextConstants.noTermsDataAvailable));
          }

          final data = state.contentsData;
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final section = data[index];
              return TermsSectionWidget(
                section: section,
                language: currentLanguage,
              );
            },
          );
        },
      ),
    );
  }
}
