import 'dart:ui';

import 'package:flower_app/features/tabs/profile/profile_main/data/mappers/terms_mapper.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/terms_and_conditions/bilingual_content.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/terms_and_conditions/bilingual_list.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/terms_and_conditions/section_style.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/terms_and_conditions/term_section.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/terms_and_conditions/terms_and_conditions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('All test cases scenarios of TermsMapper', () {
    // 1 Test Case
    test(
      '(1) Test Case: Maps TermSection with BilingualList content correctly',
      () {
        final section = TermSection(
          section: 'section 1',
          content: BilingualList(en: ['en1', 'en2'], ar: ['ar1', 'ar2']),
          style: SectionStyle(),
        );
        final model = TermsAndConditions(sections: [section]);
        final result = TermsMapper.toEntity(model);

        expect(result.sections.first.content['en'], ['en1', 'en2']);
        expect(result.sections.first.content['ar'], ['ar1', 'ar2']);
      },
    );
    // 2 Test Case
    test(
      '(2) Test Case: Maps TermSection with BilingualContent content correctly',
      () {
        final section = TermSection(
          section: 'section 2',
          content: BilingualContent(
            en: 'English content',
            ar: 'Arabic content',
          ),
          style: SectionStyle(),
        );
        final model = TermsAndConditions(sections: [section]);
        final result = TermsMapper.toEntity(model);

        expect(result.sections.first.content['en'], 'English content');
        expect(result.sections.first.content['ar'], 'Arabic content');
      },
    );
    // 3 Test Case
    test(
      '(3) Test Case: Maps TermSection with null title returns null in entity',
      () {
        final section = TermSection(
          section: 'section 3',
          title: null,
          content: BilingualContent(en: 'en', ar: 'ar'),
          style: SectionStyle(),
        );
        final model = TermsAndConditions(sections: [section]);
        final result = TermsMapper.toEntity(model);

        expect(result.sections.first.title, isNull);
      },
    );
    // 4 Test Case
    test(
      '(4) Test Case: Parses hex color string into Color with opaque alpha',
      () {
        final section = TermSection(
          section: 'section 4',
          content: BilingualContent(en: 'en', ar: 'ar'),
          style: SectionStyle(color: '#112233'),
        );
        final model = TermsAndConditions(sections: [section]);
        final result = TermsMapper.toEntity(model);

        expect(result.sections.first.style.color, const Color(0xFF112233));
      },
    );
  });
}
