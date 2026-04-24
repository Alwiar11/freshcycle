import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/setting/presentation/main/widgets/setting_misc_widgets.dart';
import 'package:freshcycle/features/setting/presentation/main/widgets/setting_profile_header.dart';
import 'package:freshcycle/features/setting/presentation/main/widgets/setting_section.dart';
import 'package:freshcycle/features/setting/presentation/main/widgets/setting_theme_toggle_tile.dart';
import 'package:freshcycle/features/setting/presentation/main/widgets/setting_tile.dart';
import 'package:freshcycle/features/setting/presentation/main/widgets/settting_toggle_tile.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: 18.sp),
        ),
        leadingWidth: 60.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            child: InkWell(
              onTap: () => context.pop(),
              borderRadius: BorderRadius.circular(10.r),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 18.r,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 120.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10.h),
            const SettingProfileHeader(),
            Gap(32.h),
            SettingSection(
              label: 'Account',
              children: [
                SettingTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Profile Settings',
                  onTap: () => context.push('/setting/profile'),
                ),
                const SettingDivider(),
                SettingTile(
                  icon: Icons.lock_outline_rounded,
                  title: 'Password & Security',
                  onTap: () => context.push('/setting/password-security'),
                ),
              ],
            ),
            Gap(24.h),
            SettingSection(
              label: 'Preferences',
              children: [
                const SettingToggleTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                ),
                const SettingDivider(),
                const SettingThemeToggleTile(),
              ],
            ),
            Gap(24.h),
            SettingSection(
              label: 'Support',
              children: [
                SettingTile(
                  icon: Icons.support_agent_outlined,
                  title: 'Contact Us',
                  onTap: () {},
                ),
                const SettingDivider(),
                SettingTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Help Center',
                  onTap: () {},
                ),
              ],
            ),
            Gap(24.h),
            SettingSection(
              label: 'About',
              children: [
                SettingTile(
                  icon: Icons.description_outlined,
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
                const SettingDivider(),
                const SettingVersionTile(),
              ],
            ),
            Gap(24.h),
            SettingSignOutButton(onTap: () {}), // TODO: sign out logic
          ],
        ),
      ),
    );
  }
}
