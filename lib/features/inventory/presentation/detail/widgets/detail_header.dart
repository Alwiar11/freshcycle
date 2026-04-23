import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/inventory/domain/models/inventory_item.dart';
import 'package:gap/gap.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({
    super.key,
    required this.item,
    required this.statusBg,
    required this.statusText,
  });

  final InventoryItem item;
  final Color statusBg;
  final Color statusText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 68.w,
          height: 68.h,
          decoration: BoxDecoration(
            color: item.bgColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: item.bgColor.withValues(alpha: 0.5),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(item.emoji, style: TextStyle(fontSize: 34.sp)),
          ),
        ),
        Gap(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name, style: theme.textTheme.titleLarge),
              Gap(4.h),
              Row(
                children: [
                  _StatusChip(
                    label: item.category,
                    bg: Theme.of(context).colorScheme.surfaceContainer,
                    textColor: Theme.of(context).colorScheme.onSurface,
                  ),
                  Gap(8.w),
                  _StatusChip(
                    label: item.label,
                    bg: statusBg,
                    textColor: statusText,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.bg,
    required this.textColor,
    this.fontWeight = FontWeight.w500,
  });

  final String label;
  final Color bg;
  final Color textColor;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: textColor),
      ),
    );
  }
}
