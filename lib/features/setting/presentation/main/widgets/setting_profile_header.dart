import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SettingProfileHeader extends StatelessWidget {
  const SettingProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.all(2.r),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.surface,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                'https://i.pravatar.cc/150?img=47',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Icon(
                    Icons.person_rounded,
                    size: 40.r,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
        Gap(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alex Sterling',
                style: theme.textTheme.headlineSmall?.copyWith(fontSize: 22.sp),
              ),
              Gap(2.h),
              Text(
                'alex.s@verdantgallery.com',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Gap(8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'PRO MEMBER',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
