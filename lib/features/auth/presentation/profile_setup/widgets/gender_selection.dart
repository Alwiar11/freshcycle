import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:gap/gap.dart';

class GenderSelection extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onChanged;

  const GenderSelection({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return FormField<String>(
      initialValue: selectedGender,
      validator: (_) => selectedGender == null ? 'Pilih jenis kelamin' : null,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis Kelamin',
              style: tt.labelMedium?.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8.h),
            Row(
              children: [
                _GenderChip(
                  label: 'Laki-laki',
                  icon: Icons.male_rounded,
                  isSelected: selectedGender == 'Laki-laki',
                  hasError: state.hasError,
                  onTap: () {
                    onChanged('Laki-laki');
                    state.didChange('Laki-laki');
                  },
                ),
                Gap(12.w),
                _GenderChip(
                  label: 'Perempuan',
                  icon: Icons.female_rounded,
                  isSelected: selectedGender == 'Perempuan',
                  hasError: state.hasError,
                  onTap: () {
                    onChanged('Perempuan');
                    state.didChange('Perempuan');
                  },
                ),
              ],
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

class _GenderChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool hasError;
  final VoidCallback onTap;

  const _GenderChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.hasError,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            height: 52.h,
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [cs.primary, AppColors.secondary],
                    )
                  : null,
              color: isSelected ? null : cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14.r),
              border: isSelected
                  ? null
                  : Border.all(
                      color: hasError
                          ? cs.error
                          : cs.outline.withValues(alpha: 0.3),
                      width: hasError ? 1.5 : 1.0,
                    ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: cs.primary.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20.r,
                  color: isSelected ? Colors.white : cs.onSurfaceVariant,
                ),
                Gap(8.w),
                Text(
                  label,
                  style: tt.labelMedium?.copyWith(
                    color: isSelected ? Colors.white : cs.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
