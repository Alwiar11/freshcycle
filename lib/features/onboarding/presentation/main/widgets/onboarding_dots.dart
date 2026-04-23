import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingDots extends StatelessWidget {
  final int count;
  final int current;
  final Color activeColor;

  const OnboardingDots({
    super.key,
    required this.count,
    required this.current,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final bool active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: active ? 28.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: active
                ? activeColor
                : Theme.of(
                    context,
                  ).colorScheme.outlineVariant.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20.r),
          ),
        );
      }),
    );
  }
}
