import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/recipe_ai/domain/models/recipe_model.dart';
import 'package:freshcycle/features/recipe_ai/presentation/widgets/recipe_ai_recipe_card.dart';
import 'package:gap/gap.dart';

class RecipeAiResults extends StatelessWidget {
  final List<RecipeModel> recipes;

  const RecipeAiResults({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(8.h),
          Divider(
            color: Theme.of(context).colorScheme.outline,
            thickness: 0.5,
          ),
          Gap(16.h),
          Text(
            'Rekomendasi untuk Kamu',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Gap(16.h),
          ...recipes.map((recipe) => RecipeAiRecipeCard(recipe: recipe)),
        ],
      ),
    );
  }
}
