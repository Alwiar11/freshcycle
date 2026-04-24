import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_primary_button.dart';
import 'package:gap/gap.dart';

class CookingNavigationBar extends StatelessWidget {
  final bool isFirstStep;
  final bool isLastStep;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const CookingNavigationBar({
    super.key,
    required this.isFirstStep,
    required this.isLastStep,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          if (!isFirstStep) ...[_buildPreviousButton(context), Gap(12.w)],
          Expanded(
            child: AppPrimaryButton(
              label: isLastStep ? 'Selesai Memasak 🎉' : 'Step Berikutnya',
              icon: isLastStep ? null : Icons.arrow_forward_rounded,
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviousButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: onPrevious,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Icon(
              Icons.arrow_back_rounded,
              size: 20.r,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
