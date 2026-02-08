import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_intents.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_state.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/radio_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SearchAndFilterProducts extends StatelessWidget {
  const SearchAndFilterProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        buildWhen: (previous, current) =>
            previous.isSearching != current.isSearching,
        builder: (context, state) {
          final isSearching = state.isSearching;
          return AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInBack,
            child: Row(
              children: [
                Expanded(
                  flex: isSearching ? 1 : 5,
                  child: TextField(
                    cursorColor: AppColors.grey,
                    decoration: InputDecoration(
                      hint: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            size: 24,
                            color: AppColors.grey,
                          ),
                          4.horizontalSpacing,
                          Text(
                            AppTextConstants.search,
                            style: textTheme.titleMedium!.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                      suffixIcon: isSearching
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: AppColors.grey,
                              ),
                              onPressed: () {
                                context.read<CategoriesCubit>().onIntent(
                                  IsSearching(),
                                );
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                            )
                          : null,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: AppColors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: AppColors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                    onTapUpOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<CategoriesCubit>().onIntent(IsSearching());
                    },
                    onTap: () =>
                        context.read<CategoriesCubit>().onIntent(IsSearching()),
                    onChanged: (value) {
                      if (context.read<CategoriesCubit>().state.categoryId !=
                          null) {
                        context.read<CategoriesCubit>().onIntent(
                          GetCategoryProducts(
                            context.read<CategoriesCubit>().state.categoryId!,
                            keyword: value,
                          ),
                        );
                      }
                    },
                  ),
                ),

                AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInBack,
                  child: !isSearching
                      ? Row(
                          children: [
                            8.horizontalSpacing,
                            Container(
                              width: screenSize.width * 0.15,
                              height: double.infinity,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: AppColors.grey),
                              ),
                              child: InkWell(
                                onTap: () {
                                  final cubit = context.read<CategoriesCubit>();
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: AppColors.background,
                                    transitionAnimationController:
                                        AnimationController(
                                          vsync: Navigator.of(context),
                                          duration: const Duration(
                                            milliseconds: 400,
                                          ),
                                        )..forward(),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.vertical(
                                            top: Radius.circular(32),
                                          ),
                                    ),
                                    builder: (context) {
                                      return BlocProvider.value(
                                        value: cubit,
                                        child: const RadioFilterWidget(),
                                      );
                                    },
                                  );
                                },
                                child: SvgPicture.asset(
                                  Assets.icons.filterIcon.path,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.grey,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
