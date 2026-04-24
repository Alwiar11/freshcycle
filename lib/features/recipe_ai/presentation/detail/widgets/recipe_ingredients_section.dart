import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:freshcycle/features/recipe_ai/domain/models/recipe_model.dart';
import 'package:freshcycle/features/recipe_ai/presentation/detail/widgets/recipe_ingredient_chip.dart';
import 'package:gap/gap.dart';

class RecipeIngredientsSection extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeIngredientsSection({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (recipe.expiringIngredients.isNotEmpty) ...[
          _buildSubLabel(context, 'Gunakan segera', AppColors.danger),
          Gap(8.h),
          _buildChips(recipe.expiringIngredients, isUrgent: true),
          Gap(16.h),
        ],
        if (recipe.otherIngredients.isNotEmpty) ...[
          _buildSubLabel(
            context,
            'Bahan lain',
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          Gap(8.h),
          _buildChips(recipe.otherIngredients, isUrgent: false),
        ],
      ],
    );
  }

  Widget _buildSubLabel(BuildContext context, String text, Color color) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: color,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildChips(List<String> ingredients, {required bool isUrgent}) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: ingredients
          .map((ing) => RecipeIngredientChip(name: ing, isUrgent: isUrgent))
          .toList(),
    );
  }
}
