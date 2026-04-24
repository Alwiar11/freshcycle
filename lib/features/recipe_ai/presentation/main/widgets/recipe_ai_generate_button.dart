import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_primary_button.dart';
import 'package:freshcycle/features/recipe_ai/providers/recipe_ai_provider.dart';

class RecipeAiGenerateButton extends ConsumerWidget {
  const RecipeAiGenerateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recipeAiStateProvider);
    final isLoading = state == RecipeAiState.loading;
    final hasResult = state == RecipeAiState.result;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: AppPrimaryButton(
        label: hasResult ? 'Generate Ulang' : 'Generate Resep AI',
        icon: Icons.auto_awesome_rounded,
        isLoading: isLoading,
        loadingLabel: 'AI sedang memasak...',
        height: 56,
        borderRadius: 20,
        onPressed: () async {
          ref.read(recipeAiStateProvider.notifier).state =
              RecipeAiState.loading;
          await Future.delayed(const Duration(seconds: 2));
          ref.read(recipeAiStateProvider.notifier).state = RecipeAiState.result;
        },
      ),
    );
  }
}
