import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/inventory/domain/models/inventory_item.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DetailInfoSection extends StatelessWidget {
  const DetailInfoSection({super.key, required this.item});

  final InventoryItem item;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');
    final entryDate = item.entryDate as DateTime?;
    final expiryDate = item.expiryDate as DateTime?;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.category_rounded,
            label: 'Kategori',
            value: item.category,
          ),
          Divider(color: Theme.of(context).colorScheme.outline, height: 20.h),
          _InfoRow(
            icon: Icons.scale_rounded,
            label: 'Kuantitas',
            value: '${item.quantity} ${item.unit}',
          ),
          Divider(color: Theme.of(context).colorScheme.outline, height: 20.h),
          _InfoRow(
            icon: Icons.calendar_today_rounded,
            label: 'Tanggal Masuk',
            value: entryDate != null ? dateFormat.format(entryDate) : '-',
          ),
          Divider(color: Theme.of(context).colorScheme.outline, height: 20.h),
          _InfoRow(
            icon: Icons.event_busy_rounded,
            label: 'Tanggal Expired',
            value: expiryDate != null ? dateFormat.format(expiryDate) : '-',
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 34.w,
          height: 34.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            size: 18.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Gap(12.w),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 13.sp,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.labelMedium?.copyWith(
            fontSize: 13.sp,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
