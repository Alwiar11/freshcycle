import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:freshcycle/features/price_estimator/domain/models/price_trend.dart';
import 'package:gap/gap.dart';

class PriceItemCard extends StatelessWidget {
  final PriceItem item;

  const PriceItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          _buildEmoji(context),
          Gap(12.w),
          Expanded(child: _buildInfo(context)),
          _buildPrice(context),
        ],
      ),
    );
  }

  Widget _buildEmoji(BuildContext context) {
    return Container(
      width: 46.w,
      height: 46.w,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Text(item.emoji, style: TextStyle(fontSize: 22.sp)),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        Gap(2.h),
        Text(
          item.note,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          _formatPrice(item.pricePerUnit),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Gap(2.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTrendIcon(),
            Gap(3.w),
            Text(
              '/${item.unit}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendIcon() {
    switch (item.trend) {
      case PriceTrend.up:
        return Icon(
          Icons.trending_up_rounded,
          size: 12.r,
          color: AppColors.danger,
        );
      case PriceTrend.down:
        return Icon(
          Icons.trending_down_rounded,
          size: 12.r,
          color: AppColors.success,
        );
      case PriceTrend.stable:
        return Icon(
          Icons.trending_flat_rounded,
          size: 12.r,
          color: AppColors.warning,
        );
    }
  }

  String _formatPrice(int price) {
    if (price >= 1000) {
      final formatted = price.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]}.',
      );
      return 'Rp $formatted';
    }
    return 'Rp $price';
  }
}
