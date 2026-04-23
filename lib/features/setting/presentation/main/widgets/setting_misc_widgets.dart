import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SettingVersionTile extends StatelessWidget {
  const SettingVersionTile({super.key, this.version = '2.0.1'});

  final String version;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 20.r,
            ),
          ),
          Gap(14.w),
          Expanded(
            child: Text(
              'Version',
              style: theme.textTheme.labelLarge?.copyWith(fontSize: 14.sp),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              version,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingSignOutButton extends StatelessWidget {
  const SettingSignOutButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 18.h),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.error.withValues(alpha: 0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.error.withValues(alpha: 0.04),
                blurRadius: 30,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_rounded,
                color: Theme.of(context).colorScheme.error,
                size: 20.r,
              ),
              Gap(8.w),
              Text(
                'Sign Out',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
