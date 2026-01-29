import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/di/di.dart';
import '../../../view_models/terms/term_cubit.dart';
import 'terms_view_body.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<TermCubit>(
        create: (context) => getIt<TermCubit>(),
        child: const TermsViewBody(),
      ),
    );
  }
}
