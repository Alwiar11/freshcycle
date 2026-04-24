import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/price_estimator/domain/models/price_trend.dart';
import 'package:freshcycle/features/price_estimator/presentation/widgets/price_item_card.dart';
import 'package:gap/gap.dart';

class PriceCategorySection extends StatelessWidget {
  final String category;
  final List<PriceItem> items;

  const PriceCategorySection({
    super.key,
    required this.category,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.w,
              height: 18.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Gap(8.w),
            Text(
              category,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Gap(8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '${items.length}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        Gap(10.h),
        ...items.asMap().entries.map(
          (e) => Padding(
            padding: EdgeInsets.only(
              bottom: e.key == items.length - 1 ? 0 : 8.h,
            ),
            child: PriceItemCard(item: e.value),
          ),
        ),
      ],
    );
  }
}
