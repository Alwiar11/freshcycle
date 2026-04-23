import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AppDatePicker extends StatelessWidget {
  const AppDatePicker({
    super.key,
    required this.label,
    required this.date,
    required this.onTap,
    this.hint = 'Pilih tanggal',
    this.format = 'dd MMM yyyy',
    this.disabled = false,
    this.error = false,
    this.icon = Icons.calendar_today_rounded,
  });

  final String label;
  final DateTime? date;
  final VoidCallback? onTap;
  final String hint;
  final String format;
  final bool disabled;
  final bool error;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasDate = date != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        Gap(8.h),
        GestureDetector(
          onTap: disabled ? null : onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: disabled
                  ? colorScheme.onSurfaceVariant.withValues(alpha: 0.12)
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: error && !hasDate
                    ? colorScheme.error.withValues(alpha: 0.5)
                    : colorScheme.outline.withValues(alpha: 0.3),
                width: error && !hasDate ? 1.5 : 1.0,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18.sp,
                  color: disabled
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.primary,
                ),
                Gap(8.w),
                Expanded(
                  child: Text(
                    hasDate ? DateFormat(format).format(date!) : hint,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: disabled || !hasDate
                          ? colorScheme.onSurfaceVariant
                          : colorScheme.onSurface,
                    ),
                  ),
                ),
                if (disabled) ...[
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 14.sp,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
