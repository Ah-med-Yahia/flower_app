import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/terms_and_conditions/bilingual_content.dart';
import '../../../../data/models/terms_and_conditions/bilingual_list.dart';
import '../../../../data/models/terms_and_conditions/term_section.dart';
import '../../../../data/models/terms_and_conditions/text_style_config.dart';
import '../../../view_models/terms/term_cubit.dart';

class TermsBody extends StatefulWidget {
  final String initialLanguage; // 'en' or 'ar'

  const TermsBody({super.key, this.initialLanguage = 'en'});

  @override
  State<TermsBody> createState() => _TermsBodyState();
}

class _TermsBodyState extends State<TermsBody> {
  late String currentLanguage;
  late TermCubit cubit;

  @override
  void initState() {
    super.initState();
    currentLanguage = widget.initialLanguage;
    cubit = context.read<TermCubit>();
  }

  void toggleLanguage() {
    setState(() {
      currentLanguage = currentLanguage == 'en' ? 'ar' : 'en';
    });
  }

  Color parseColor(String colorString) {
    try {
      if (colorString.startsWith('#')) {
        return Color(
          int.parse(colorString.substring(1), radix: 16) + 0xFF000000,
        );
      }
    } catch (e) {
      debugPrint('Error parsing color: $colorString');
    }
    return Colors.black;
  }

  FontWeight parseFontWeight(String weight) {
    switch (weight.toLowerCase()) {
      case 'bold':
        return FontWeight.bold;
      case 'normal':
      default:
        return FontWeight.normal;
    }
  }

  TextAlign parseTextAlign(String align) {
    switch (align.toLowerCase()) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'left':
      default:
        return TextAlign.left;
    }
  }

  TextStyle buildTextStyle(TextStyleConfig config, String language) {
    return TextStyle(
      fontSize: config.fontSize,
      fontWeight: parseFontWeight(config.fontWeight),
      color: parseColor(config.color),
    );
  }

  Widget buildSection(TermSection section) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (section.title != null) _buildTitle(section),
          _buildContent(section),
        ],
      ),
    );
  }

  Widget _buildTitle(TermSection section) {
    final titleStyle = section.style.title;
    if (titleStyle == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        section.title!.get(currentLanguage),
        style: buildTextStyle(titleStyle, currentLanguage),
        textAlign: parseTextAlign(titleStyle.textAlign.get(currentLanguage)),
      ),
    );
  }

  Widget _buildContent(TermSection section) {
    if (section.style.fontSize != null) {
      return _buildSimpleContent(section);
    }

    final contentStyle = section.style.content;
    if (contentStyle == null) return const SizedBox.shrink();

    if (section.content is BilingualList) {
      return _buildListContent(section.content as BilingualList, contentStyle);
    } else if (section.content is BilingualContent) {
      return _buildTextContent(
        (section.content as BilingualContent).get(currentLanguage),
        contentStyle,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildSimpleContent(TermSection section) {
    if (section.content is BilingualContent) {
      final content = section.content as BilingualContent;
      return Text(
        content.get(currentLanguage),
        style: TextStyle(
          fontSize: section.style.fontSize,
          fontWeight: parseFontWeight(section.style.fontWeight ?? 'normal'),
          color: parseColor(section.style.color ?? '#000000'),
        ),
        textAlign: parseTextAlign(
          section.style.textAlign?.get(currentLanguage) ?? 'left',
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildTextContent(String text, TextStyleConfig config) {
    return Text(
      text,
      style: buildTextStyle(config, currentLanguage),
      textAlign: parseTextAlign(config.textAlign.get(currentLanguage)),
    );
  }

  Widget _buildListContent(BilingualList list, TextStyleConfig config) {
    final items = list.get(currentLanguage);
    final textAlign = parseTextAlign(config.textAlign.get(currentLanguage));
    final isRTL = currentLanguage == 'ar';

    return Column(
      crossAxisAlignment: isRTL
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Text('• ', style: buildTextStyle(config, currentLanguage)),
              Expanded(
                child: Text(
                  item,
                  style: buildTextStyle(config, currentLanguage),
                  textAlign: textAlign,
                  textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TermCubit, TermStates>(
      builder: (context, state) {
        final termState = state.termState;

        if (termState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (termState.errorMessage != null) {
          return Center(child: Text(termState.errorMessage!));
        }

        final terms = termState.data;
        if (terms == null) {
          return const Center(
            child: Text(AppTextConstants.noTermsDataAvailable),
          );
        }

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
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: terms.sections
                  .map((section) => buildSection(section))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
