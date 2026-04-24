import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:gap/gap.dart';

class CookingTimerWidget extends StatelessWidget {
  final int remainingSeconds;
  final int totalSeconds;
  final bool isRunning;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onReset;
  final VoidCallback onSetTimer;

  const CookingTimerWidget({
    super.key,
    required this.remainingSeconds,
    required this.totalSeconds,
    required this.isRunning,
    required this.onStart,
    required this.onPause,
    required this.onReset,
    required this.onSetTimer,
  });

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final hasTimer = totalSeconds > 0;
    final progress = hasTimer ? remainingSeconds / totalSeconds : 0.0;
    final isFinished = hasTimer && remainingSeconds == 0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isFinished
            ? AppColors.success.withValues(alpha: 0.08)
            : Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isFinished
              ? AppColors.success.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.timer_rounded,
                size: 16.r,
                color: Theme.of(context).colorScheme.primary,
              ),
              Gap(6.w),
              Text(
                'Timer',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              if (isFinished)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '✅ Selesai!',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          Gap(12.h),
          if (!hasTimer)
            _buildSetTimerButton(context)
          else ...[
            _buildTimerDisplay(context, progress),
            Gap(12.h),
            _buildTimerControls(context, isFinished),
          ],
        ],
      ),
    );
  }

  Widget _buildSetTimerButton(BuildContext context) {
    return InkWell(
      onTap: onSetTimer,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_rounded,
              size: 16.r,
              color: Theme.of(context).colorScheme.primary,
            ),
            Gap(4.w),
            Text(
              'Set Durasi Timer',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerDisplay(BuildContext context, double progress) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                progress > 0.3
                    ? Theme.of(context).colorScheme.primary
                    : AppColors.danger,
              ),
            ),
          ),
        ),
        Gap(12.w),
        Text(
          _formatTime(remainingSeconds),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: remainingSeconds < 30 && remainingSeconds > 0
                ? AppColors.danger
                : Theme.of(context).colorScheme.onSurface,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }

  Widget _buildTimerControls(BuildContext context, bool isFinished) {
    return Row(
      children: [
        Expanded(
          child: _TimerControlButton(
            icon: isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
            label: isRunning ? 'Pause' : (isFinished ? 'Mulai Lagi' : 'Mulai'),
            onTap: isRunning ? onPause : onStart,
            isPrimary: true,
          ),
        ),
        Gap(8.w),
        _TimerControlButton(
          icon: Icons.refresh_rounded,
          label: 'Reset',
          onTap: onReset,
          isPrimary: false,
        ),
        Gap(8.w),
        _TimerControlButton(
          icon: Icons.edit_rounded,
          label: 'Ubah',
          onTap: onSetTimer,
          isPrimary: false,
        ),
      ],
    );
  }
}

class _TimerControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _TimerControlButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isPrimary
          ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
          : Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 14.r,
                color: isPrimary
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              Gap(4.w),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isPrimary
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
