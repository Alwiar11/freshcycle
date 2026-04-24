import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RecipeAiHeader extends StatelessWidget {
  const RecipeAiHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Recipe',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(height: 1.1),
          ),
          Gap(4.h),
          Text(
            'Rekomendasi resep dari stok kamu',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
