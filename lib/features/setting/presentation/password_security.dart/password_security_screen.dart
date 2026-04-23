import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'widgets/password_form.dart';

class PasswordSecurityScreen extends StatelessWidget {
  const PasswordSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 24.r,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Password & Security',
          style: theme.textTheme.titleMedium?.copyWith(fontSize: 18.sp),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info banner
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20.r,
                  ),
                  Gap(12.w),
                  Expanded(
                    child: Text(
                      'Use a strong password with at least 8 characters, including numbers and symbols.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: Theme.of(context).colorScheme.primary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(32.h),
            const PasswordForm(),
          ],
        ),
      ),
    );
  }
}
