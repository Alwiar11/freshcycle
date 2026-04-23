import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
    this.validator,
    this.isExpanded = true,
  });

  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? hint;
  final String? Function(T?)? validator;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
        DropdownButtonFormField<T>(
          isExpanded: isExpanded,
          initialValue: value,
          hint: hint != null
              ? Text(
                  hint!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                )
              : null,
          onChanged: onChanged,
          validator: validator,
          style: theme.textTheme.bodyMedium,
          decoration: const InputDecoration(),
          dropdownColor: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          items: items,
        ),
      ],
    );
  }
}
