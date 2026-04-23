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
          Text(
            'Prioritaskan:',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Gap(8.h),
          Wrap(
            spacing: 8.w,
            children: [
              _buildChip(
                context,
                priority: RecipePriority.expiring,
                emoji: '🔴',
                label: 'Hampir Expired',
              ),
              _buildChip(
                context,
                priority: RecipePriority.fresh,
                emoji: '🟢',
                label: 'Masih Segar',
              ),
              _buildChip(
                context,
                priority: RecipePriority.all,
                emoji: '🔀',
                label: 'Semua Bahan',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required RecipePriority priority,
    required String emoji,
    required String label,
  }) {
    final isSelected = selected == priority;

    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: TextStyle(fontSize: 14.sp)),
          Gap(4.w),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color:
                  isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(priority),
      selectedColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Colors.transparent,
      side:
          isSelected
              ? BorderSide.none
              : BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      showCheckmark: false,
    );
  }
}
