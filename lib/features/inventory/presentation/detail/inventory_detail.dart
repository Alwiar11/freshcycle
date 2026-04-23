import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:freshcycle/features/inventory/domain/models/inventory_item.dart';
import 'package:gap/gap.dart';

import 'widgets/detail_actions.dart';
import 'widgets/detail_freshness_section.dart';
import 'widgets/detail_header.dart';
import 'widgets/detail_info_section.dart';

class InventoryDetail extends StatelessWidget {
  const InventoryDetail({super.key, required this.item});

  final InventoryItem item;

  static void show(BuildContext context, InventoryItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (_) => InventoryDetail(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isFresh = item.status == 'fresh';
    final bool isWarn = item.status == 'warn';
    final double progress = item.daysLeft / item.maxDays;

    final Color statusColor = isFresh
        ? Theme.of(context).colorScheme.primary
        : isWarn
        ? AppColors.warning
        : Theme.of(context).colorScheme.error;

    final Color statusBg = isFresh
        ? const Color(0xFFEAF3DE)
        : isWarn
        ? const Color(0xFFFFF3CD)
        : const Color(0xFFFFEBEB);

    final Color statusText = isFresh
        ? const Color(0xFF3B6D11)
        : isWarn
        ? const Color(0xFF856404)
        : const Color(0xFFA32D2D);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
            child: Column(
              children: [
                DetailHeader(
                  item: item,
                  statusBg: statusBg,
                  statusText: statusText,
                ),
                Gap(24.h),
                DetailFreshnessSection(
                  daysLeft: item.daysLeft,
                  maxDays: item.maxDays,
                  progress: progress,
                  statusColor: statusColor,
                  isFresh: isFresh,
                  isWarn: isWarn,
                ),
                Gap(20.h),
                DetailInfoSection(item: item),
                Gap(24.h),
                DetailActions(item: item),
                Gap(16.h),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
