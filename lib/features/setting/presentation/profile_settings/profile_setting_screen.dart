import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'widgets/profile_avatar.dart';
import 'widgets/profile_form.dart';

class ProfileSettingScreen extends StatelessWidget {
  const ProfileSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceContainer,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pengaturan Profil',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: 18.sp),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          children: [const ProfileAvatar(), Gap(32.h), const ProfileForm()],
        ),
      ),
    );
  }
}
