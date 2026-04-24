import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppDatePicker extends StatelessWidget {
  const AppDatePicker({
    super.key,
    required this.label,
    required this.onTap,
    this.date,
    this.hint = 'Pilih tanggal',
    this.validator,
    this.disabled = false,
    this.icon = Icons.calendar_month_rounded,
  });

  final String label;
  final DateTime? date;
  final VoidCallback onTap;
  final String hint;
  final String? Function(DateTime?)? validator;
  final bool disabled;
  final IconData icon;

  static String _formatDate(DateTime date) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return FormField<DateTime>(
      initialValue: date,
      validator: validator != null ? (_) => validator!(date) : null,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: tt.labelMedium?.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8.h),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.r),
              child: InkWell(
                onTap: disabled ? null : onTap,
                borderRadius: BorderRadius.circular(16.r),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 52.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: disabled
                        ? cs.onSurfaceVariant.withValues(alpha: 0.08)
                        : cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: state.hasError
                          ? cs.error
                          : date != null
                          ? cs.primary.withValues(alpha: 0.5)
                          : cs.outline.withValues(alpha: 0.3),
                      width: state.hasError ? 1.5 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: 20.r,
                        color: disabled
                            ? cs.onSurfaceVariant
                            : date != null
                            ? cs.primary
                            : cs.onSurfaceVariant,
                      ),
                      Gap(12.w),
                      Expanded(
                        child: Text(
                          date == null ? hint : _formatDate(date!),
                          style: tt.bodyMedium?.copyWith(
                            color: date == null
                                ? cs.onSurfaceVariant.withValues(alpha: 0.5)
                                : cs.onSurface,
                          ),
                        ),
                      ),
                      if (disabled)
                        Icon(
                          Icons.lock_outline_rounded,
                          size: 16.r,
                          color: cs.onSurfaceVariant,
                        )
                      else
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 24.r,
                          color: cs.onSurfaceVariant,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (state.hasError) ...[
              Gap(6.h),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Text(
                  state.errorText!,
                  style: tt.bodySmall?.copyWith(
                    color: cs.error,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
