import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../../core/widgets/loading_indicator_widget.dart';
import '../../../view_models/terms/term_cubit.dart';
import '../widget/terms_body.dart';

class TermsViewBody extends StatefulWidget {
  const TermsViewBody({super.key});

  @override
  State<TermsViewBody> createState() => _TermsViewBodyState();
}

class _TermsViewBodyState extends State<TermsViewBody> {
  late final TermCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<TermCubit>();
    cubit.doIntent(GetTermDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TermCubit, TermStates>(
      builder: (context, state) {
        final termState = state.termState;
        if (termState.isLoading) {
          return const Scaffold(body: Center(child: LoadingIndicator()));
        }
        if (termState.errorMessage != null) {
          return CustomErrorWidget(
            error: termState.errorMessage ?? ErrorsConstant.defaultError,
            onTryAgain: () {
              cubit.doIntent(GetTermDataEvent());
            },
          );
        }
        if (termState.data == null) {
          return Scaffold(
            body: Center(
              child: Text(
                ErrorsConstant.noContent,
                style: TextTheme.of(context).titleMedium,
              ),
            ),
          );
        }

        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: TermsBody(
            initialLanguage:
                AppTextConstants.enLang, // Change to 'ar' for Arabic by default
          ),
        );
      },
    );
  }
}
