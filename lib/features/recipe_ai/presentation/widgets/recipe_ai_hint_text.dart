import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/recipe_ai/domain/enums/recipe_priority.dart';
import 'package:gap/gap.dart';

class RecipeAiHintText extends StatelessWidget {
  final RecipePriority priority;

  const RecipeAiHintText({super.key, required this.priority});

  String get _message {
    switch (priority) {
      case RecipePriority.expiring:
        return 'Mengutamakan bahan yang akan segera expired';
      case RecipePriority.fresh:
        return 'Mengutamakan bahan yang masih segar';
      case RecipePriority.all:
        return 'Menggunakan semua bahan yang tersedia';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.tips_and_updates_rounded,
          size: 14.r,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        Gap(6.w),
        Text(
          _message,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
