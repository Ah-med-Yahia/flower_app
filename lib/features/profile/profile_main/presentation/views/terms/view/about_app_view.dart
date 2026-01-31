import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/di/di.dart';
import '../../../view_models/terms/static_content_cubit.dart';
import '../../../view_models/terms/static_content_states.dart';
import 'terms_view_body.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<StaticContentCubit>(
        create: (context) =>
            getIt<StaticContentCubit>()..doIntent(GetAboutAppDataEvent()),
        child: const TermsViewBody(isAboutApp: true),
      ),
    );
  }
}
