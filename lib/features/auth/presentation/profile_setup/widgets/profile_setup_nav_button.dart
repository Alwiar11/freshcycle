import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_primary_button.dart';
import 'package:gap/gap.dart';

class ProfileSetupNavButton extends StatefulWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback? onSkip;
  final bool isNextEnabled;

  const ProfileSetupNavButton({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onNext,
    required this.onBack,
    this.onSkip,
    this.isNextEnabled = true,
  });

  @override
  State<ProfileSetupNavButton> createState() => _ProfileSetupNavButtonState();
}

class _ProfileSetupNavButtonState extends State<ProfileSetupNavButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _handleNextTap() {
    widget.onNext();
    if (!widget.isNextEnabled) {
      _shakeController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final showBack = widget.currentStep > 1;
    final isLast = widget.currentStep == widget.totalSteps;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            if (showBack) ...[
              SizedBox(
                width: 48.w,
                height: 48.h,
                child: OutlinedButton(
                  onPressed: widget.onBack,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: cs.outline.withValues(alpha: 0.4)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 20.r,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
              Gap(12.w),
            ],
            Expanded(
              child: AnimatedBuilder(
                animation: _shakeController,
                builder: (context, child) {
                  final offset =
                      sin(_shakeController.value * pi * 6) *
                      6 *
                      (1 - _shakeController.value);
                  return Transform.translate(
                    offset: Offset(offset, 0),
                    child: child,
                  );
                },
                child: AppPrimaryButton(
                  label: isLast ? 'Selesai' : 'Lanjut',
                  icon: isLast
                      ? Icons.check_rounded
                      : Icons.arrow_forward_rounded,
                  onPressed: _handleNextTap,
                ),
              ),
            ),
          ],
        ),
        if (isLast && widget.onSkip != null) ...[
          Gap(12.h),
          TextButton(
            onPressed: widget.onSkip,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Lewati untuk sekarang',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
