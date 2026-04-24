import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InventoryFilterChips extends StatelessWidget {
  final int selectedIndex;
  final List<String> filters;
  final ValueChanged<int> onSelected;

  const InventoryFilterChips({
    super.key,
    required this.selectedIndex,
    required this.filters,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (_, index) {
          final bool isActive = selectedIndex == index;

          return Container(
            decoration: BoxDecoration(
              gradient: isActive
                  ? LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    )
                  : null,
              color: isActive
                  ? null
                  : Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(20.r),
              border: isActive
                  ? null
                  : Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.5,
                    ),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
              child: InkWell(
                onTap: () => onSelected(index),
                borderRadius: BorderRadius.circular(20.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Center(
                    child: Text(
                      filters[index],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isActive
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
