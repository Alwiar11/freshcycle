import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_primary_button.dart';
import 'package:freshcycle/features/recipe_ai/domain/models/recipe_model.dart';
import 'package:freshcycle/features/recipe_ai/presentation/detail/widgets/recipe_detail_header.dart';
import 'package:freshcycle/features/recipe_ai/presentation/detail/widgets/recipe_ingredients_section.dart';
import 'package:freshcycle/features/recipe_ai/presentation/detail/widgets/recipe_meta_row.dart';
import 'package:freshcycle/features/recipe_ai/presentation/detail/widgets/recipe_section_tile.dart';
import 'package:freshcycle/features/recipe_ai/presentation/detail/widgets/recipe_steps_section.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RecipeDetailScreen extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: RecipeDetailHeader(recipe: recipe)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(24.h),
                        Text(
                          recipe.title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 24.sp,
                                height: 1.2,
                              ),
                        ),
                        Gap(10.h),
                        Text(
                          recipe.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                height: 1.6,
                                fontSize: 15.sp,
                              ),
                        ),
                        Gap(24.h),
                        RecipeMetaRow(recipe: recipe),
                        Gap(32.h),
                        RecipeSectionTitle(title: 'Bahan-Bahan'),
                        Gap(12.h),
                        RecipeIngredientsSection(recipe: recipe),
                        Gap(32.h),
                        RecipeSectionTitle(title: 'Cara Memasak'),
                        Gap(12.h),
                        RecipeStepsSection(steps: recipe.steps),
                        Gap(120.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 24.h,
            child: AppPrimaryButton(
              label: 'Buat Resep Ini',
              icon: Icons.restaurant_rounded,
              onPressed: () => context.push('/cooking-session'),
            ),
          ),
        ],
      ),
    );
  }
}
