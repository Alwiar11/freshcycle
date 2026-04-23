import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SettingAppBar extends StatelessWidget {
  const SettingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.04),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 24.r,
        ),
        onPressed: () => context.pop(),
      ),
      title: Text(
        'Settings',
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontSize: 18.sp),
      ),
    );
  }
}
