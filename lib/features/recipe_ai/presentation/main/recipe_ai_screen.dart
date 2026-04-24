import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:freshcycle/features/recipe_ai/domain/enums/recipe_priority.dart';
import 'package:freshcycle/features/recipe_ai/domain/models/recipe_model.dart';
import 'package:freshcycle/features/recipe_ai/presentation/main/widgets/recipe_ai_expiring_card.dart';
import 'package:freshcycle/features/recipe_ai/presentation/main/widgets/recipe_ai_generate_button.dart';
import 'package:freshcycle/features/recipe_ai/presentation/main/widgets/recipe_ai_header.dart';
import 'package:freshcycle/features/recipe_ai/presentation/main/widgets/recipe_ai_hint_text.dart';
import 'package:freshcycle/features/recipe_ai/presentation/main/widgets/recipe_ai_priority_toggle.dart';
import 'package:freshcycle/features/recipe_ai/presentation/main/widgets/recipe_ai_results.dart';
import 'package:freshcycle/features/recipe_ai/providers/recipe_ai_provider.dart';
import 'package:gap/gap.dart';

class RecipeAiScreen extends ConsumerStatefulWidget {
  const RecipeAiScreen({super.key});

  @override
  ConsumerState<RecipeAiScreen> createState() => _RecipeAiScreenState();
}

class _RecipeAiScreenState extends ConsumerState<RecipeAiScreen> {
  RecipePriority _selectedPriority = RecipePriority.expiring;

  final List<RecipeAiExpiringItem> _expiringItems = const [
    RecipeAiExpiringItem(name: 'Ayam Fillet', label: 'Besok', urgent: true),
    RecipeAiExpiringItem(
      name: 'Susu Full Cream',
      label: '2 hari',
      urgent: false,
    ),
    RecipeAiExpiringItem(name: 'Pisang', label: '3 hari', urgent: false),
  ];

  static const List<RecipeModel> _dummyRecipes = [
    RecipeModel(
      id: '1',
      title: 'Tumis Ayam Brokoli',
      description:
          'Tumisan gurih dengan ayam fillet dan brokoli segar, cocok untuk makan malam cepat dan bergizi.',
      cookingMinutes: 20,
      servings: 2,
      expiringIngredients: ['Ayam Fillet', 'Brokoli'],
      otherIngredients: ['Bawang Putih', 'Kecap Manis'],
      steps: [
        'Potong ayam fillet menjadi ukuran kecil dan cuci bersih.',
        'Potong brokoli, lalu rendam dalam air garam sebentar.',
        'Tumis bawang putih cincang hingga harum.',
        'Masukkan ayam fillet, tumis hingga berubah warna.',
        'Tambahkan brokoli dan kecap manis, aduk rata.',
        'Tambahkan sedikit air, masak hingga matang.',
      ],
      emoji: '🍳',
    ),
    RecipeModel(
      id: '2',
      title: 'Salad Sayur Segar',
      description:
          'Salad sehat dengan campuran sayuran segar dari stok kamu, disajikan dengan dressing lemon.',
      cookingMinutes: 10,
      servings: 1,
      expiringIngredients: ['Wortel', 'Bayam'],
      otherIngredients: ['Lemon', 'Olive Oil'],
      steps: [
        'Cuci bersih wortel dan bayam, tiriskan.',
        'Potong wortel bentuk korek api atau serut halus.',
        'Campurkan bayam dan wortel dalam mangkuk.',
        'Peras lemon dan tambahkan olive oil sebagai dressing.',
        'Aduk rata dan sajikan segera.',
      ],
      emoji: '🥗',
    ),
    RecipeModel(
      id: '3',
      title: 'Smoothie Anggur Susu',
      description:
          'Minuman segar dari anggur hijau dan susu full cream, kaya nutrisi untuk sarapan.',
      cookingMinutes: 5,
      servings: 1,
      expiringIngredients: ['Susu Full Cream', 'Anggur Hijau'],
      otherIngredients: ['Madu', 'Es Batu'],
      steps: [
        'Cuci bersih anggur hijau, buang batangnya.',
        'Masukkan anggur, susu full cream, madu, dan es batu ke dalam blender.',
        'Blender hingga halus dan tercampur rata.',
        'Tuang ke gelas dan sajikan segera.',
      ],
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
                child: RecipeAiExpiringCard(
                  items: _expiringItems,
                  onTap: () => _showExpiringDialog(context),
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
            SliverToBoxAdapter(child: Gap(12.h)),

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

  void _showExpiringDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Bahan Segera Habis',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: _expiringItems.length,
            separatorBuilder: (_, __) => Gap(10.h),
            itemBuilder: (context, index) {
              final item = _expiringItems[index];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: item.urgent
                            ? AppColors.danger.withValues(alpha: 0.15)
                            : AppColors.warning.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        item.label,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: item.urgent
                              ? AppColors.danger
                              : AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Tutup',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
