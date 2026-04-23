import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:gap/gap.dart';

class RecipeAiPantryCard extends StatelessWidget {
  final VoidCallback? onTap;

  const RecipeAiPantryCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final summary = [
      _Category(label: 'Sayuran', count: 4, color: AppColors.primary),
      _Category(label: 'Protein', count: 2, color: AppColors.warning),
      _Category(label: 'Lainnya', count: 6, color: AppColors.onSurfaceVariant),
    ];

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Stok Tersedia',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 16.r,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              Gap(8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '12',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  Gap(4.w),
                  Text(
                    'bahan',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Gap(10.h),
              Wrap(
                spacing: 4.w,
                runSpacing: 4.h,
                children: summary.map((s) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: s.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${s.count} ${s.label}',
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: s.color),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Category {
  final String label;
  final int count;
  final Color color;

  const _Category({
    required this.label,
    required this.count,
    required this.color,
  });
}
