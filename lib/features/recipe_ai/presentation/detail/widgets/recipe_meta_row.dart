import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:freshcycle/features/recipe_ai/domain/models/recipe_model.dart';
import 'package:gap/gap.dart';

class RecipeMetaRow extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeMetaRow({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MetaChip(
          icon: Icons.timer_rounded,
          label: '${recipe.cookingMinutes} menit',
          color: AppColors.warning,
        ),
        Gap(10.w),
        _MetaChip(
          icon: Icons.people_rounded,
          label: '${recipe.servings} porsi',
          color: AppColors.info,
        ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 14.r, color: color),
          ),
          Gap(8.w),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
