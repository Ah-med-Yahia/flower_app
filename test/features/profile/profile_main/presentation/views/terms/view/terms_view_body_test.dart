import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/core/widgets/custom_eleveted_button.dart';
import 'package:flower_app/core/widgets/custom_error_widget.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';
import 'package:flower_app/features/profile/profile_main/domain/entities/term_section_entity.dart';
import 'package:flower_app/features/profile/profile_main/presentation/view_models/terms/term_cubit.dart';
import 'package:flower_app/features/profile/profile_main/presentation/views/terms/view/terms_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'terms_view_body_test.mocks.dart';

@GenerateMocks([TermCubit])
void main() {
  late MockTermCubit mockCubit;
  setUp(() {
    mockCubit = MockTermCubit();
  });
  Widget buildTestableWidget() {
    return MaterialApp(
      home: BlocProvider<TermCubit>(
        create: (context) => mockCubit,
        child: const TermsViewBody(),
      ),
    );
  }

  group('All Test Cases for TermsViewBody Widget ', () {
    // 1 Test Case
    testWidgets(
      '(1) Test Case: When in Loading state, should show loading indicator',
      (WidgetTester tester) async {
        when(mockCubit.state).thenReturn(
          const TermStates(
            termState: BaseState<TermsAndConditionsEntity>(isLoading: true),
          ),
        );
        when(mockCubit.stream).thenAnswer(
          (_) => Stream.value(
            const TermStates(
              termState: BaseState<TermsAndConditionsEntity>(isLoading: true),
            ),
          ),
        );

        await tester.pumpWidget(buildTestableWidget());

        expect(find.byType(LoadingIndicator), findsOneWidget);
        expect(find.byType(Center), findsOneWidget);
        expect(find.byType(TermsViewBody), findsOneWidget);
        expect(find.byType(AppBar), findsNothing);
      },
    );
    // 2 Test Case
    testWidgets(
      '(2) Test Case: When in Error state, should show error widget',
      (WidgetTester tester) async {
        const String mockErrorMsg = 'Error Msg';
        when(mockCubit.state).thenReturn(
          const TermStates(
            termState: BaseState<TermsAndConditionsEntity>(
              isLoading: false,
              errorMessage: mockErrorMsg,
            ),
          ),
        );
        when(mockCubit.stream).thenAnswer(
          (_) => Stream.value(
            const TermStates(
              termState: BaseState<TermsAndConditionsEntity>(
                isLoading: false,
                errorMessage: mockErrorMsg,
              ),
            ),
          ),
        );

        await tester.pumpWidget(buildTestableWidget());
        // CustomErroWidget
        expect(find.byType(CustomErrorWidget), findsOneWidget);
        expect(find.byType(Center), findsNWidgets(2));
        expect(find.byType(Padding), findsNWidgets(2));
        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(Icon), findsOneWidget);
        expect(find.byType(Text), findsNWidgets(2));
        expect(find.byType(SizedBox), findsNWidgets(5));
        expect(find.byType(CustomElevatedButtonWidget), findsOneWidget);
        // TermsViewBody
        expect(find.byType(TermsViewBody), findsOneWidget);
        expect(find.byType(AppBar), findsNothing);
        expect(find.text(mockErrorMsg), findsOneWidget);
      },
    );

    // 3 Test Case
    testWidgets('(3) Test Case: When in Success state with no data, '
        'should show Text widget with no content message', (
      WidgetTester tester,
    ) async {
      when(mockCubit.state).thenReturn(
        const TermStates(
          termState: BaseState<TermsAndConditionsEntity>(
            isLoading: false,
            data: null,
            errorMessage: null,
          ),
        ),
      );
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          const TermStates(
            termState: BaseState<TermsAndConditionsEntity>(
              isLoading: false,
              data: null,
              errorMessage: null,
            ),
          ),
        ),
      );

      await tester.pumpWidget(buildTestableWidget());

      // TermsViewBody
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(TermsViewBody), findsOneWidget);
      expect(find.byType(AppBar), findsNothing);
      expect(find.text(ErrorsConstant.noContent), findsOneWidget);
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
      final mockData = TermsAndConditionsEntity(sections: mockSections);
      when(mockCubit.state).thenReturn(
        TermStates(
          termState: BaseState<TermsAndConditionsEntity>(
            isLoading: false,
            data: mockData,
            errorMessage: null,
          ),
        ),
      );
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          TermStates(
            termState: BaseState<TermsAndConditionsEntity>(
              isLoading: false,
              data: mockData,
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
