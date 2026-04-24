import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class InventoryHeader extends StatelessWidget {
  const InventoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildLogo(context), _buildProfileIcon(context)],
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(Icons.eco_rounded, color: Colors.white, size: 18.r),
        ),
        Gap(8.w),
        Text('Fresh Cycle', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  Widget _buildProfileIcon(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/setting'),
      child: Container(
        width: 38.w,
        height: 38.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
        ),
        child: Icon(
          Icons.person_rounded,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          size: 20.r,
        ),
      ),
    );
  }
}
