import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:freshcycle/features/recipe_ai/domain/models/recipe_model.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RecipeAiRecipeCard extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeAiRecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEmojiBanner(context),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Gap(6.h),
                Text(
                  recipe.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                Gap(12.h),
                Text(
                  'MENGGUNAKAN YANG MAUK HABIS',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                Gap(6.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 4.h,
                  children: recipe.expiringIngredients
                      .map(
                        (ing) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.error.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.error.withValues(alpha: 0.2),
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            ing,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Gap(16.h),
                SizedBox(
                  width: double.infinity,
                  height: 44.h,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.push('/recipe-ai/detail', extra: recipe);
                    },
                    icon: Icon(
                      Icons.restaurant_rounded,
                      size: 16.r,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: Text(
                      'Lihat Resep',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Stack(
        children: [
          Center(
            child: Hero(
              tag: 'recipe-emoji-${recipe.id}',
              child: Material(
                color: Colors.transparent,
                child: Text(recipe.emoji, style: TextStyle(fontSize: 52.sp)),
              ),
            ),
          ),
          Positioned(
            top: 12.h,
            right: 12.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainer.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timer_rounded,
                    size: 12.r,
                    color: AppColors.warning,
                  ),
                  Gap(4.w),
                  Text(
                    '${recipe.cookingMinutes}m',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
