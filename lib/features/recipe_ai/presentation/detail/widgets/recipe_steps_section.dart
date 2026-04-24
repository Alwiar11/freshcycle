import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:gap/gap.dart';

class RecipeStepsSection extends StatelessWidget {
  final List<String> steps;

  const RecipeStepsSection({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.asMap().entries.map((entry) {
        return _RecipeStepItem(
          index: entry.key,
          step: entry.value,
          isLast: entry.key == steps.length - 1,
        );
      }).toList(),
    );
  }
}

class _RecipeStepItem extends StatelessWidget {
  final int index;
  final String step;
  final bool isLast;

  const _RecipeStepItem({
    required this.index,
    required this.step,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepIndicator(context),
          Gap(14.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
              child: Text(
                step,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(height: 1.55, fontSize: 15.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                AppColors.secondary,
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        if (!isLast)
          Expanded(
            child: Container(
              width: 2.w,
              margin: EdgeInsets.symmetric(vertical: 6.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.4),
                    AppColors.secondary.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(1.r),
              ),
            ),
          ),
      ],
    );
  }
}
