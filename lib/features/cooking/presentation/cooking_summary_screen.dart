import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:freshcycle/core/widgets/app_primary_button.dart';

import 'package:freshcycle/features/cooking/domain/models/cooking_step.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CookingSummaryScreen extends StatefulWidget {
  final String recipeTitle;
  final String recipeEmoji;
  final Map<int, Map<String, double>> adjustedQty;
  final List<CookingStep> steps;

  const CookingSummaryScreen({
    super.key,
    required this.recipeTitle,
    required this.recipeEmoji,
    required this.adjustedQty,
    required this.steps,
  });

  @override
  State<CookingSummaryScreen> createState() => _CookingSummaryScreenState();
}

class _CookingSummaryScreenState extends State<CookingSummaryScreen> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  // Flatten semua ingredient yang dipakai dari semua steps
  List<_UsedIngredient> get _usedIngredients {
    final Map<String, _UsedIngredient> map = {};

    for (int i = 0; i < widget.steps.length; i++) {
      for (final ing in widget.steps[i].ingredients) {
        final adjusted = widget.adjustedQty[i]?[ing.name] ?? ing.qty;
        if (map.containsKey(ing.name)) {
          map[ing.name] = _UsedIngredient(
            name: ing.name,
            unit: ing.unit,
            originalQty: map[ing.name]!.originalQty + ing.qty,
            adjustedQty: map[ing.name]!.adjustedQty + adjusted,
          );
        } else {
          map[ing.name] = _UsedIngredient(
            name: ing.name,
            unit: ing.unit,
            originalQty: ing.qty,
            adjustedQty: adjusted,
          );
        }
      }
    }

    return map.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(24.h),
                    _buildSuccessHeader(context),
                    Gap(32.h),
                    _buildIngredientsUsed(context),
                    Gap(24.h),
                    _buildNoteSection(context),
                    Gap(24.h),
                  ],
                ),
              ),
            ),
            _buildBottomActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessHeader(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(widget.recipeEmoji, style: TextStyle(fontSize: 64.sp)),
          Gap(12.h),
          Text(
            'Selesai Memasak! 🎉',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          Gap(6.h),
          Text(
            widget.recipeTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsUsed(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bahan yang Digunakan',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        Gap(4.h),
        Text(
          'Stok akan dikurangi sesuai jumlah di bawah',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Gap(12.h),
        ..._usedIngredients.map(
          (ing) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: _UsedIngredientRow(ingredient: ing),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catatan Memasak',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        Gap(4.h),
        Text(
          'Opsional — akan disimpan ke riwayat',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Gap(12.h),
        TextField(
          controller: _noteController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Misal: Besok coba kurangi garam, tambah bawang putih...',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.4),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: AppPrimaryButton(
        label: 'Konfirmasi & Kurangi Stok',
        icon: Icons.check_circle_rounded,
        onPressed: () {
          // TODO: kurangi stok di Supabase
          context.go('/');
        },
      ),
    );
  }
}

class _UsedIngredient {
  final String name;
  final String unit;
  final double originalQty;
  final double adjustedQty;

  const _UsedIngredient({
    required this.name,
    required this.unit,
    required this.originalQty,
    required this.adjustedQty,
  });
}

class _UsedIngredientRow extends StatelessWidget {
  final _UsedIngredient ingredient;

  const _UsedIngredientRow({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    final isAdjusted = ingredient.adjustedQty != ingredient.originalQty;
    final isDiff = ingredient.adjustedQty > ingredient.originalQty;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isAdjusted
              ? AppColors.warning.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              ingredient.name,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          if (isAdjusted) ...[
            Text(
              '${ingredient.originalQty} ${ingredient.unit}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Gap(6.w),
            Icon(
              Icons.arrow_forward_rounded,
              size: 12.r,
              color: AppColors.warning,
            ),
            Gap(6.w),
          ],
          Text(
            '${ingredient.adjustedQty} ${ingredient.unit}',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: isAdjusted
                  ? (isDiff ? AppColors.danger : AppColors.success)
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
