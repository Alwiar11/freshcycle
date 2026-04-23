import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:freshcycle/features/inventory/domain/models/inventory_item.dart';
import 'package:freshcycle/features/inventory/presentation/detail/inventory_detail.dart';

class InventoryItemCard extends StatelessWidget {
  final InventoryItem item;

  const InventoryItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isWarn = item.status == 'warn';
    final isFresh = item.status == 'fresh';
    final double progress = item.progress;

    final Color badgeBg = isFresh
        ? const Color(0xFFEAF3DE)
        : isWarn
        ? const Color(0xFFFFF3E0) // orange bg
        : const Color(0xFFFFEBEB); // red bg (expired)

    final Color badgeText = isFresh
        ? const Color(0xFF3B6D11)
        : isWarn
        ? const Color(0xFF8B5000) // orange text
        : const Color(0xFFA32D2D); // red text (expired)

    final Color progressColor = isFresh
        ? Theme.of(context).colorScheme.primary
        : isWarn
        ? AppColors.warning
        : Theme.of(context).colorScheme.error;

    return InkWell(
      onTap: () => InventoryDetail.show(context, item),
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildCardBody(
              isFresh,
              progress,
              badgeBg,
              badgeText,
              progressColor,
              context,
            ),
            _buildEmojiCircle(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardBody(
    bool isFresh,
    double progress,
    Color badgeBg,
    Color badgeText,
    Color progressColor,
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 28.w),
      padding: EdgeInsets.fromLTRB(44.w, 16.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(badgeBg, badgeText, context),
          Gap(12.h),
          _buildProgressBar(progress, progressColor, context),
        ],
      ),
    );
  }

  Widget _buildCardHeader(
    Color badgeBg,
    Color badgeText,
    BuildContext context,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Gap(2.h),
              Text(
                item.category,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        _buildBadge(badgeBg, badgeText, context),
      ],
    );
  }

  Widget _buildBadge(Color badgeBg, Color badgeText, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: badgeBg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        item.label,
        style: Theme.of(
          context,
        ).textTheme.labelSmall!.copyWith(color: badgeText),
      ),
    );
  }

  Widget _buildProgressBar(
    double progress,
    Color progressColor,
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
        ),
        Gap(10.w),
        Text(
          '${item.daysLeft}/${item.maxDays} hari',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildEmojiCircle() {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      child: Center(
        child: Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            color: item.bgColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(item.emoji, style: TextStyle(fontSize: 26.sp)),
          ),
        ),
      ),
    );
  }
}
