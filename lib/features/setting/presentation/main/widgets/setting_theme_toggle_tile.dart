import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_theme_notifier.dart';
import 'package:gap/gap.dart';

class SettingThemeToggleTile extends StatelessWidget {
  const SettingThemeToggleTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppThemeNotifier.instance,
      builder: (context, mode, _) {
        final isDark = mode == ThemeMode.dark;

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
                  isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20.r,
                ),
              ),
              Gap(14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dark Mode',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(fontSize: 14.sp),
                    ),
                    Text(
                      isDark ? 'On' : 'Off',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: isDark,
                onChanged: (_) => AppThemeNotifier.instance.toggle(),
                activeThumbColor: Colors.white,
                activeTrackColor: Theme.of(context).colorScheme.primary,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainer,
              ),
            ],
          ),
        );
      },
    );
  }
}
