import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DetailFreshnessSection extends StatelessWidget {
  const DetailFreshnessSection({
    super.key,
    required this.daysLeft,
    required this.maxDays,
    required this.progress,
    required this.statusColor,
    required this.isFresh,
    required this.isWarn,
  });

  final int daysLeft;
  final int maxDays;
  final double progress;
  final Color statusColor;
  final bool isFresh;
  final bool isWarn;

  String get _message {
    if (isFresh) {
      return 'Bahan masih segar, simpan di tempat yang tepat untuk menjaga kualitas.';
    }
    if (isWarn) return 'Segera gunakan bahan ini sebelum kadaluarsa!';
    return 'Bahan ini sudah kadaluarsa, sebaiknya jangan dikonsumsi.';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sisa Kesegaran',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '$daysLeft dari $maxDays hari',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: statusColor,
                ),
              ),
            ],
          ),
          Gap(12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8.h,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
          ),
          Gap(12.h),
          Row(
            children: [
              Icon(
                isFresh
                    ? Icons.eco_rounded
                    : isWarn
                    ? Icons.warning_amber_rounded
                    : Icons.dangerous_rounded,
                size: 30.sp,
                color: statusColor,
              ),
              Gap(6.w),
              Expanded(
                child: Text(
                  _message,
                  style: theme.textTheme.bodySmall?.copyWith(
                    height: 1.4,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
