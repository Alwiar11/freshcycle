import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/recipe_ai/domain/enums/recipe_priority.dart';
import 'package:gap/gap.dart';

class RecipeAiPriorityToggle extends StatelessWidget {
  final RecipePriority selected;
  final ValueChanged<RecipePriority> onSelected;

  const RecipeAiPriorityToggle({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Prioritaskan:', style: Theme.of(context).textTheme.labelSmall),
          Gap(8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _PriorityChip(
                priority: RecipePriority.expiring,
                emoji: '🔴',
                label: 'Hampir Expired',
                isSelected: selected == RecipePriority.expiring,
                onTap: () => onSelected(RecipePriority.expiring),
              ),

              _PriorityChip(
                priority: RecipePriority.all,
                emoji: '🔀',
                label: 'Semua Bahan',
                isSelected: selected == RecipePriority.all,
                onTap: () => onSelected(RecipePriority.all),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  final RecipePriority priority;
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PriorityChip({
    required this.priority,
    required this.emoji,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(20.r),
        border: isSelected
            ? null
            : Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji, style: TextStyle(fontSize: 14.sp)),
                Gap(4.w),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
