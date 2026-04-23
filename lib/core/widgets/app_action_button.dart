import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  Widget build(BuildContext context) {
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
}
