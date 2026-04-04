import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/shared/presentation/widgets/custom_eleveted_button.dart';
import 'package:flower_app/core/shared/presentation/widgets/custom_error_widget.dart';
import 'package:flower_app/core/shared/presentation/widgets/loading_indicator_widget.dart';
import 'package:flower_app/features/tabs/profile/profile_main/domain/entities/term_section_entity.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/cubit/terms/static_content_cubit.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/cubit/terms/static_content_states.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/screens/terms/view/terms_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'terms_view_body_test.mocks.dart';

@GenerateMocks([StaticContentCubit])
void main() {
  late MockStaticContentCubit mockCubit;
  setUp(() {
    mockCubit = MockStaticContentCubit();
  });
  Widget buildTestableWidget({bool isAboutApp = false}) {
    return MaterialApp(
      home: BlocProvider<StaticContentCubit>(
        create: (context) => mockCubit,
        child: TermsViewBody(isAboutApp: isAboutApp),
      ),
    );
  }

  group('All Test Cases for TermsViewBody Widget ', () {
    // 1 Test Case
    testWidgets(
      '(1) Test Case: When in Loading state, should show loading indicator',
      (WidgetTester tester) async {
        when(mockCubit.state).thenReturn(
          const StaticContentStates(
            contentState: BaseState<List<TermSectionEntity>>(isLoading: true),
          ),
        );
        when(mockCubit.stream).thenAnswer(
          (_) => Stream.value(
            const StaticContentStates(
              contentState: BaseState<List<TermSectionEntity>>(isLoading: true),
            ),
          ),
        );

        await tester.pumpWidget(buildTestableWidget());

        // TermsViewBody => Scaffold => appBar => title
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byType(Text), findsOneWidget);
        expect(find.text(AppTextConstants.termsAppBarTitleEn), findsOneWidget);
        // TermsViewBody => Scaffold => appBar => actions => IconButton
        expect(find.byType(IconButton), findsOneWidget);
        expect(find.byIcon(Icons.language), findsOneWidget);
        expect(find.byTooltip(AppTextConstants.switchToArabic), findsOneWidget);
        // TermsViewBody => Scaffold => body => Center
        expect(find.byType(LoadingIndicator), findsOneWidget);
        expect(find.byType(Center), findsNWidgets(2));
        expect(find.byType(TermsViewBody), findsOneWidget);
      },
    );
    // 2 Test Case
    testWidgets(
      '(2) Test Case: When in Error state, should show error widget',
      (WidgetTester tester) async {
        const String mockErrorMsg = 'Error Msg';
        when(mockCubit.state).thenReturn(
          const StaticContentStates(
            contentState: BaseState<List<TermSectionEntity>>(
              isLoading: false,
              errorMessage: mockErrorMsg,
            ),
          ),
        );
        when(mockCubit.stream).thenAnswer(
          (_) => Stream.value(
            const StaticContentStates(
              contentState: BaseState<List<TermSectionEntity>>(
                isLoading: false,
                errorMessage: mockErrorMsg,
              ),
            ),
          ),
        );

        await tester.pumpWidget(buildTestableWidget());

        // TermsViewBody => Scaffold => appBar => title
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text(AppTextConstants.termsAppBarTitleEn), findsOneWidget);
        // TermsViewBody => Scaffold => appBar => actions => IconButton
        expect(find.byType(IconButton), findsOneWidget);
        expect(find.byIcon(Icons.language), findsOneWidget);
        expect(find.byTooltip(AppTextConstants.switchToArabic), findsOneWidget);
        // TermsViewBody => Scaffold => body => CustomErrorWidget
        expect(find.byType(CustomErrorWidget), findsOneWidget);
        expect(find.byType(Center), findsNWidgets(3));
        expect(find.byType(Padding), findsNWidgets(5));
        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(Icon), findsNWidgets(2));
        expect(find.byType(Text), findsNWidgets(3));
        expect(find.byType(SizedBox), findsNWidgets(6));
        expect(find.byType(CustomElevatedButtonWidget), findsOneWidget);
        // TermsViewBody
        expect(find.byType(TermsViewBody), findsOneWidget);
        expect(find.text(mockErrorMsg), findsOneWidget);
      },
    );

    // 3 Test Case
    testWidgets('(3) Test Case: When in Success state with no data, '
        'should show Text widget with no content message', (
      WidgetTester tester,
    ) async {
      const List<TermSectionEntity> mockSections = [];
      when(mockCubit.state).thenReturn(
        const StaticContentStates(
          contentState: BaseState<List<TermSectionEntity>>(
            isLoading: false,
            data: mockSections,
            errorMessage: null,
          ),
        ),
      );
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          const StaticContentStates(
            contentState: BaseState<List<TermSectionEntity>>(
              isLoading: false,
              data: mockSections,
              errorMessage: null,
            ),
          ),
        ),
      );

      await tester.pumpWidget(buildTestableWidget());

      // TermsViewBody
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(3));
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(TermsViewBody), findsOneWidget);
    });

    // 4 Test Case
    testWidgets('(4) Test Case: When in Success state with data, '
        'should show ListView.separated widget with 2 correct items', (
      WidgetTester tester,
    ) async {
      final List<TermSectionEntity> mockSections = [
        const TermSectionEntity(
          section: 'section1',
          title: {'en': 'section 1 title', 'ar': 'section 1 title'},
          content: {'en': 'section 1 content', 'ar': 'section 1 content'},
          style: SectionStyleEntity(),
        ),
        const TermSectionEntity(
          section: 'section2',
          title: {'en': 'section 2 title', 'ar': 'section 2 title'},
          content: {'en': 'section 2 content', 'ar': 'section 2 content'},
          style: SectionStyleEntity(),
        ),
      ];
      when(mockCubit.state).thenReturn(
        StaticContentStates(
          contentState: BaseState<List<TermSectionEntity>>(
            isLoading: false,
            data: mockSections,
            errorMessage: null,
          ),
        ),
      );
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          StaticContentStates(
            contentState: BaseState<List<TermSectionEntity>>(
              isLoading: false,
              data: mockSections,
              errorMessage: null,
            ),
          ),
        ),
      );

      await tester.pumpWidget(buildTestableWidget());

      // TermsViewBody => Scaffold => appBar => title
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text(AppTextConstants.termsAppBarTitleEn), findsOneWidget);
      // TermsViewBody => Scaffold => appBar => actions => IconButton
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byIcon(Icons.language), findsOneWidget);
      expect(find.byTooltip(AppTextConstants.switchToArabic), findsOneWidget);
      // TermsViewBody => Scaffold => body => ListView
      expect(find.byType(ListView), findsOneWidget);
      // TermsViewBody => Scaffold => body => ListView => separated
      expect(find.byType(Divider), findsOneWidget);
      // TermsViewBody => Scaffold => body => ListView => padding
      expect(find.byType(Padding), findsAny);
    });

    //-------------------------------------------------------------------------//
  });
}
