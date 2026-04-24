import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:freshcycle/features/cooking/domain/models/cooking_ingredient.dart';

class CookingIngredientRow extends StatelessWidget {
  final CookingIngredient ingredient;
  final double adjustedQty;
  final ValueChanged<double> onQtyChanged;

  const CookingIngredientRow({
    super.key,
    required this.ingredient,
    required this.adjustedQty,
    required this.onQtyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isAdjusted = adjustedQty != ingredient.qty;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isAdjusted
              ? AppColors.warning.withValues(alpha: 0.4)
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          width: isAdjusted ? 1.5 : 0.5,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ingredient.name,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (isAdjusted)
                  Text(
                    'Asli: ${ingredient.qty} ${ingredient.unit}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.warning,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
          ),
          _buildQtyController(context),
        ],
      ),
    );
  }

  Widget _buildQtyController(BuildContext context) {
    return Row(
      children: [
        _QtyButton(
          icon: Icons.remove_rounded,
          onTap: adjustedQty > 0.5
              ? () => onQtyChanged(
                  double.parse((adjustedQty - 0.5).toStringAsFixed(1)),
                )
              : null,
        ),
        SizedBox(
          width: 60.w,
          child: Text(
            '$adjustedQty ${ingredient.unit}',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        _QtyButton(
          icon: Icons.add_rounded,
          onTap: () => onQtyChanged(
            double.parse((adjustedQty + 0.5).toStringAsFixed(1)),
          ),
        ),
      ],
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.all(6.w),
          child: Icon(
            icon,
            size: 16.r,
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
