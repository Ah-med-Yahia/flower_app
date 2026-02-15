import 'dart:developer';

import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/search_widget.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_cubit.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_events.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<HomeScreenCubit, HomeScreenStates>(
      buildWhen: (previous, current) =>
          previous.isSearching != current.isSearching,
      builder: (context, state) {
        log(state.isSearching.toString());
        return Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, anim) => SizeTransition(
                sizeFactor: anim,
                axis: Axis.horizontal,
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: state.isSearching
                  ? const SizedBox.shrink()
                  : Row(
                      children: [
                        Assets.lottie.flower.svg(width: 24, height: 24),
                        const SizedBox(width: 4),
                        Text(
                          AppTextConstants.flowery,
                          style: textTheme.titleLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.imFellEnglish().fontFamily,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
            ),

            Expanded(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: SearchWidget(
                  isSearching: state.isSearching,
                  height: 38,
                  onPressedClearIcon: () {
                    context.read<HomeScreenCubit>().onEvent(
                      IsSearching(isSearching: false),
                    );
                  },
                  onTapOutside: () {
                    context.read<HomeScreenCubit>().onEvent(
                      IsSearching(isSearching: false),
                    );
                  },
                  onTap: () {
                    context.read<HomeScreenCubit>().onEvent(
                      IsSearching(isSearching: true),
                    );
                  },
                  onChanged: (value) {
                    context.read<HomeScreenCubit>().onEvent(
                      GetSearchProductsEvent(keyword: value),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
