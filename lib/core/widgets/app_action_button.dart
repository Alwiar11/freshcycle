import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';

class AppActionButton extends StatelessWidget {
  const AppActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.foregroundColor,
    this.borderColor,
    this.backgroundColor,
    this.height,
    this.borderRadius,
    this.iconSize,
    this.textStyle,
    this.borderWidth = 1.0,
    this.isLoading = false,
    this.loadingColor,
    this.useGradient = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? height;
  final double? borderRadius;
  final double? iconSize;
  final TextStyle? textStyle;
  final double borderWidth;
  final bool isLoading;
  final Color? loadingColor;
  final bool useGradient;

  @override
  Widget build(BuildContext context) {
    if (useGradient) {
      return _buildGradientButton(context);
    }

    final effectiveForeground =
        foregroundColor ?? Theme.of(context).colorScheme.primary;

    final buttonStyle = OutlinedButton.styleFrom(
      foregroundColor: backgroundColor == Theme.of(context).colorScheme.primary
          ? Colors.white
          : foregroundColor,
      backgroundColor: backgroundColor,
      side: BorderSide(
        color: borderColor ?? effectiveForeground.withValues(alpha: 0.3),
        width: borderWidth,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius?.r ?? 16.r),
      ),
    );

    final labelWidget = isLoading
        ? SizedBox(
            width: (iconSize ?? 20).sp,
            height: (iconSize ?? 20).sp,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: loadingColor ?? effectiveForeground,
            ),
          )
        : Text(
            label,
            style:
                textStyle ??
                Theme.of(context).textTheme.labelMedium?.copyWith(
                  color:
                      backgroundColor == Theme.of(context).colorScheme.primary
                      ? Colors.white
                      : foregroundColor,
                ),
          );

    return SizedBox(
      height: height?.h ?? 50.h,
      child: icon != null && !isLoading
          ? OutlinedButton.icon(
              onPressed: onPressed,
              style: buttonStyle,
              icon: Icon(icon, size: (iconSize ?? 20).sp),
              label: labelWidget,
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: buttonStyle,
              child: labelWidget,
            ),
    );
  }

  Widget _buildGradientButton(BuildContext context) {
    final effectiveHeight = height?.h ?? 50.h;
    final effectiveRadius = (borderRadius?.r ?? 16.r);

    final labelWidget = isLoading
        ? SizedBox(
            width: (iconSize ?? 20).sp,
            height: (iconSize ?? 20).sp,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
        : Text(
            label,
            style:
                textStyle ??
                Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
          );

    return SizedBox(
      height: effectiveHeight,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              AppColors.secondary,
            ],
          ),
          borderRadius: BorderRadius.circular(effectiveRadius),
          boxShadow: [
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
            onTap: onPressed,
            borderRadius: BorderRadius.circular(effectiveRadius),
            child: Center(
              child: icon != null && !isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: Colors.white,
                          size: (iconSize ?? 20).sp,
                        ),
                        SizedBox(width: 10.w),
                        labelWidget,
                      ],
                    )
                  : labelWidget,
            ),
          ),
        ),
      ),
    );
  }
}
