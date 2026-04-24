import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OnboardingData {
  final String emoji;
  final String title;
  final String subtitle;
  final Color bgColor;
  final Color accentColor;

  const OnboardingData({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.accentColor,
  });
}

class OnboardingPageContent extends StatefulWidget {
  final OnboardingData data;
  final AnimationController animController;

  const OnboardingPageContent({
    super.key,
    required this.data,
    required this.animController,
  });

  @override
  State<OnboardingPageContent> createState() => _OnboardingPageContentState();
}

class _OnboardingPageContentState extends State<OnboardingPageContent>
    with TickerProviderStateMixin {
  late List<AnimationController> _dotControllers;
  late List<Animation<Offset>> _dotAnimations;

  final List<_DotConfig> _dots = [
    _DotConfig(size: 16, angle: 45, radius: 130, delay: 0.0),
    _DotConfig(size: 10, angle: 135, radius: 120, delay: 0.3),
    _DotConfig(size: 14, angle: 220, radius: 125, delay: 0.6),
    _DotConfig(size: 8, angle: 320, radius: 115, delay: 0.9),
    _DotConfig(size: 12, angle: 10, radius: 140, delay: 0.15),
    _DotConfig(size: 6, angle: 260, radius: 135, delay: 0.45),
  ];

  @override
  void initState() {
    super.initState();
    _initDotAnimations();
  }

  void _initDotAnimations() {
    _dotControllers = List.generate(_dots.length, (i) {
      final ctrl = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2200 + (i * 300)),
      );
      Future.delayed(
        Duration(milliseconds: (_dots[i].delay * 1000).toInt()),
        () {
          if (mounted) ctrl.repeat(reverse: true);
        },
      );
      return ctrl;
    });

    _dotAnimations = List.generate(_dots.length, (i) {
      final dx = (i % 2 == 0) ? 0.06 : -0.06;
      final dy = (i % 3 == 0) ? -0.08 : 0.08;
      return Tween<Offset>(begin: Offset.zero, end: Offset(dx, dy)).animate(
        CurvedAnimation(parent: _dotControllers[i], curve: Curves.easeInOut),
      );
    });
  }

  @override
  void dispose() {
    for (final c in _dotControllers) {
      c.dispose();
    }
    super.dispose();
  }

  Offset _dotPosition(double angle, double radius) {
    final rad = angle * pi / 180;
    return Offset(radius * cos(rad), radius * sin(rad));
  }

  @override
  Widget build(BuildContext context) {
    final emojiAnim = CurvedAnimation(
      parent: widget.animController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    );
    final titleAnim = CurvedAnimation(
      parent: widget.animController,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
    );
    final subtitleAnim = CurvedAnimation(
      parent: widget.animController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: emojiAnim, child: _buildIllustration()),
          Gap(48.h),
          FadeTransition(
            opacity: titleAnim,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(titleAnim),
              child: Text(
                widget.data.title,
                textAlign: TextAlign.center,
                style: tt.headlineLarge?.copyWith(color: cs.onSurface),
              ),
            ),
          ),
          Gap(16.h),
          FadeTransition(
            opacity: subtitleAnim,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(subtitleAnim),
              child: Text(
                widget.data.subtitle,
                textAlign: TextAlign.center,
                style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    return SizedBox(
      width: 280.w,
      height: 280.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer ring
          Container(
            width: 240.w,
            height: 240.w,
            decoration: BoxDecoration(
              color: widget.data.bgColor.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
          ),

          // Inner circle + emoji
          Container(
            width: 200.w,
            height: 200.w,
            decoration: BoxDecoration(
              color: widget.data.bgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.data.accentColor.withValues(alpha: 0.15),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Center(
              child: Text(widget.data.emoji, style: TextStyle(fontSize: 88.sp)),
            ),
          ),

          // Floating dots
          ...List.generate(_dots.length, (i) {
            final config = _dots[i];
            final pos = _dotPosition(config.angle, config.radius.w);

            return AnimatedBuilder(
              animation: _dotControllers[i],
              builder: (_, child) {
                return Transform.translate(
                  offset: Offset(
                    pos.dx + (_dotAnimations[i].value.dx * config.radius.w),
                    pos.dy + (_dotAnimations[i].value.dy * config.radius.w),
                  ),
                  child: child,
                );
              },
              child: Container(
                width: config.size.w,
                height: config.size.w,
                decoration: BoxDecoration(
                  color: widget.data.accentColor.withValues(
                    alpha: (0.2 + (i * 0.08)).clamp(0.0, 0.6),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _DotConfig {
  final double size;
  final double angle;
  final double radius;
  final double delay;

  const _DotConfig({
    required this.size,
    required this.angle,
    required this.radius,
    required this.delay,
  });
}
