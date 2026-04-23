import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/recipe_ai/domain/enums/recipe_priority.dart';
import 'package:freshcycle/features/recipe_ai/domain/models/recipe_model.dart';
import 'package:freshcycle/features/recipe_ai/presentation/widgets/recipe_ai_expiring_card.dart';
import 'package:freshcycle/features/recipe_ai/presentation/widgets/recipe_ai_generate_button.dart';
import 'package:freshcycle/features/recipe_ai/presentation/widgets/recipe_ai_header.dart';
import 'package:freshcycle/features/recipe_ai/presentation/widgets/recipe_ai_hint_text.dart';
import 'package:freshcycle/features/recipe_ai/presentation/widgets/recipe_ai_pantry_card.dart';
import 'package:freshcycle/features/recipe_ai/presentation/widgets/recipe_ai_priority_toggle.dart';
import 'package:freshcycle/features/recipe_ai/presentation/widgets/recipe_ai_results.dart';
import 'package:freshcycle/features/recipe_ai/providers/recipe_ai_provider.dart';
import 'package:gap/gap.dart';

class RecipeAiScreen extends ConsumerStatefulWidget {
  const RecipeAiScreen({super.key});

  @override
  ConsumerState<RecipeAiScreen> createState() => _RecipeAiScreenState();
}

class _RecipeAiScreenState extends ConsumerState<RecipeAiScreen> {
  RecipePriority _selectedPriority = RecipePriority.expiring;

  static const List<RecipeModel> _dummyRecipes = [
    RecipeModel(
      id: '1',
      title: 'Tumis Ayam Brokoli',
      description:
          'Tumisan gurih dengan ayam fillet dan brokoli segar, cocok untuk makan malam cepat dan bergizi.',
      cookingMinutes: 20,
      expiringIngredients: ['Ayam Fillet', 'Brokoli'],
      otherIngredients: ['Bawang Putih', 'Kecap Manis'],
      emoji: '🍳',
    ),
    RecipeModel(
      id: '2',
      title: 'Salad Sayur Segar',
      description:
          'Salad sehat dengan campuran sayuran segar dari stok kamu, disajikan dengan dressing lemon.',
      cookingMinutes: 10,
      expiringIngredients: ['Wortel', 'Bayam'],
      otherIngredients: ['Lemon', 'Olive Oil'],
      emoji: '🥗',
    ),
    RecipeModel(
      id: '3',
      title: 'Smoothie Anggur Susu',
      description:
          'Minuman segar dari anggur hijau dan susu full cream, kaya nutrisi untuk sarapan.',
      cookingMinutes: 5,
      expiringIngredients: ['Susu Full Cream', 'Anggur Hijau'],
      otherIngredients: ['Madu', 'Es Batu'],
      emoji: '🥤',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recipeAiStateProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: RecipeAiHeader()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Row(
                  children: [
                    Expanded(
                      flex: 55,
                      child: RecipeAiExpiringCard(onTap: () {}),
                    ),
                    Gap(12.w),
                    Expanded(flex: 45, child: RecipeAiPantryCard(onTap: () {})),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: RecipeAiPriorityToggle(
                selected: _selectedPriority,
                onSelected: (priority) =>
                    setState(() => _selectedPriority = priority),
              ),
            ),
            SliverToBoxAdapter(child: Gap(16.h)),
            const SliverToBoxAdapter(child: RecipeAiGenerateButton()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: RecipeAiHintText(priority: _selectedPriority),
              ),
            ),
            if (state == RecipeAiState.result)
              SliverToBoxAdapter(
                child: RecipeAiResults(recipes: _dummyRecipes),
              ),
            SliverToBoxAdapter(child: Gap(40.h)),
          ],
        ),
      ),
    );
  }
}
