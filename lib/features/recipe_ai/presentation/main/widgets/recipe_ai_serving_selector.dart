import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RecipeAiServingSelector extends StatelessWidget {
  final int servings;
  final ValueChanged<int> onChanged;

  const RecipeAiServingSelector({
    super.key,
    required this.servings,
    required this.onChanged,
  });

  static const int _min = 1;
  static const int _max = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jumlah Porsi:',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Gap(2.h),
              Text(
                'AI akan sesuaikan bahan',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          _buildStepper(context),
        ],
      ),
    );
  }

  Widget _buildStepper(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          _StepperButton(
            icon: Icons.remove_rounded,
            onTap: servings > _min ? () => onChanged(servings - 1) : null,
          ),
          Container(
            width: 1,
            height: 20.h,
            color: Theme.of(context).colorScheme.outline,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              '$servings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 20.h,
            color: Theme.of(context).colorScheme.outline,
          ),
          _StepperButton(
            icon: Icons.add_rounded,
            onTap: servings < _max ? () => onChanged(servings + 1) : null,
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _StepperButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Icon(
            icon,
            size: 18.r,
            color: isDisabled
                ? Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.3)
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
