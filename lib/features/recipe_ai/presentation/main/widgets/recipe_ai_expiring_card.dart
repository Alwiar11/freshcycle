import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:gap/gap.dart';

class RecipeAiExpiringItem {
  final String name;
  final String label;
  final bool urgent;

  const RecipeAiExpiringItem({
    required this.name,
    required this.label,
    required this.urgent,
  });
}

class RecipeAiExpiringCard extends StatelessWidget {
  final List<RecipeAiExpiringItem> items;
  final VoidCallback? onTap;

  const RecipeAiExpiringCard({super.key, required this.items, this.onTap});

  int get _urgentCount => items.where((e) => e.urgent).length;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.5),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: AppColors.danger.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header gradient banner ──
              _HeaderBanner(urgentCount: _urgentCount),

              // ── Item list ──
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 14.h),
                child: Column(
                  children: items
                      .map((item) => _ExpiringRow(item: item))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderBanner extends StatelessWidget {
  final int urgentCount;

  const _HeaderBanner({required this.urgentCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: urgentCount > 0
              ? [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)]
              : [const Color(0xFFFFB347), const Color(0xFFFFCC70)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          // Frosted icon circle
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                urgentCount > 0 ? '🔥' : '⏰',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ),
          Gap(10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Segera Habis',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  urgentCount > 0
                      ? '$urgentCount item butuh perhatian segera'
                      : 'Semua masih aman untuk sekarang',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            size: 18.r,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ],
      ),
    );
  }
}

class _ExpiringRow extends StatelessWidget {
  final RecipeAiExpiringItem item;

  const _ExpiringRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final color = item.urgent ? AppColors.danger : AppColors.warning;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          // Status dot
          Container(
            width: 7.r,
            height: 7.r,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          Gap(10.w),
          Expanded(
            child: Text(
              item.name,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Gap(8.w),
          // Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: color.withValues(alpha: 0.3),
                width: 0.8,
              ),
            ),
            child: Text(
              item.label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
                fontSize: 10.sp,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
