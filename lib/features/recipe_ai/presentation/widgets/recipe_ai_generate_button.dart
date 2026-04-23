import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/recipe_ai/providers/recipe_ai_provider.dart';
import 'package:gap/gap.dart';

class RecipeAiGenerateButton extends ConsumerWidget {
  const RecipeAiGenerateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recipeAiStateProvider);
    final isLoading = state == RecipeAiState.loading;
    final hasResult = state == RecipeAiState.result;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      ref.read(recipeAiStateProvider.notifier).state =
                          RecipeAiState.loading;
                      await Future.delayed(const Duration(seconds: 2));
                      ref.read(recipeAiStateProvider.notifier).state =
                          RecipeAiState.result;
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                disabledBackgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 18.w,
                          height: 18.h,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onPrimary,
                            strokeWidth: 2,
                          ),
                        ),
                        Gap(10.w),
                        Text(
                          'AI sedang memasak...',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.auto_awesome_rounded,
                          size: 20.r,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        Gap(8.w),
                        Text(
                          hasResult ? 'Generate Ulang' : 'Generate Resep AI',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
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
