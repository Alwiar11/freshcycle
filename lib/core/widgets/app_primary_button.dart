import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconSize,
    this.textStyle,
    this.height,
    this.borderRadius,
    this.isLoading = false,
    this.loadingLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? iconSize;
  final TextStyle? textStyle;
  final double? height;
  final double? borderRadius;
  final bool isLoading;
  final String? loadingLabel;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius?.r ?? 16.r;

    return SizedBox(
      width: double.infinity,
      height: height?.h ?? 52.h,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLoading
                ? [
                    Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.6),
                    AppColors.secondary.withValues(alpha: 0.6),
                  ]
                : [Theme.of(context).colorScheme.primary, AppColors.secondary],
          ),
          borderRadius: BorderRadius.circular(effectiveRadius),
          boxShadow: isLoading
              ? []
              : [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(effectiveRadius),
          child: InkWell(
            onTap: isLoading ? null : onPressed,
            borderRadius: BorderRadius.circular(effectiveRadius),
            child: Center(child: _buildLabel(context)),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    final defaultTextStyle =
        textStyle ??
        Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        );

    if (isLoading && loadingLabel != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: (iconSize ?? 18).sp,
            height: (iconSize ?? 18).sp,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8.w),
          Text(loadingLabel!, style: defaultTextStyle),
        ],
      );
    }

    if (isLoading) {
      return SizedBox(
        width: (iconSize ?? 20).sp,
        height: (iconSize ?? 20).sp,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: (iconSize ?? 20).sp),
          SizedBox(width: 8.w),
          Text(label, style: defaultTextStyle),
        ],
      );
    }

    return Text(label, style: defaultTextStyle);
  }
}
