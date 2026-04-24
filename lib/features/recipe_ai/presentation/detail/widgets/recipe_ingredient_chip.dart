import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RecipeIngredientChip extends StatelessWidget {
  final String name;
  final bool isUrgent;

  const RecipeIngredientChip({
    super.key,
    required this.name,
    required this.isUrgent,
  });

  @override
  Widget build(BuildContext context) {
    final color = isUrgent
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUrgent ? Icons.warning_amber_rounded : Icons.check_circle_rounded,
            size: 14.r,
            color: color,
          ),
          Gap(6.w),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: isUrgent ? FontWeight.w700 : FontWeight.w500,
              color: isUrgent
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
