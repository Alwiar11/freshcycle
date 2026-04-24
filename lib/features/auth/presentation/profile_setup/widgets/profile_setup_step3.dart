import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProfileSetupStep3 extends StatefulWidget {
  final bool hasPhoto;
  final VoidCallback onPickPhoto;
  final VoidCallback onSkip;
  final VoidCallback onFinish;

  const ProfileSetupStep3({
    super.key,
    required this.hasPhoto,
    required this.onPickPhoto,
    required this.onSkip,
    required this.onFinish,
  });

  @override
  State<ProfileSetupStep3> createState() => _ProfileSetupStep3State();
}

class _ProfileSetupStep3State extends State<ProfileSetupStep3>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ──
        Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    cs.primary.withValues(alpha: 0.15),
                    cs.secondary.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 22.r,
                color: cs.primary,
              ),
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Foto Profil',
                    style: tt.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Gap(2.h),
                  Text(
                    'Tambahkan foto agar profilmu lebih lengkap.',
                    style: tt.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        Gap(40.h),

        // ── Avatar ──
        Center(
          child: Column(
            children: [
              // Avatar with gradient ring and camera badge
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: widget.hasPhoto ? 1.0 : _pulseAnimation.value,
                    child: child,
                  );
                },
                child: GestureDetector(
                  onTap: widget.onPickPhoto,
                  child: SizedBox(
                    width: 140.w,
                    height: 140.w,
                    child: Stack(
                      children: [
                        // Gradient ring
                        Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            width: 132.w,
                            height: 132.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: widget.hasPhoto
                                    ? [cs.primary, cs.secondary]
                                    : [
                                        cs.outline.withValues(alpha: 0.4),
                                        cs.outline.withValues(alpha: 0.2),
                                      ],
                              ),
                              boxShadow: widget.hasPhoto
                                  ? [
                                      BoxShadow(
                                        color:
                                            cs.primary.withValues(alpha: 0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 6),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Container(
                                width: 124.w,
                                height: 124.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: cs.surfaceContainerHighest,
                                ),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: widget.hasPhoto
                                      ? Icon(
                                          Icons.person_rounded,
                                          key: const ValueKey('person'),
                                          size: 52.r,
                                          color: cs.primary,
                                        )
                                      : Icon(
                                          Icons.add_photo_alternate_outlined,
                                          key: const ValueKey('add'),
                                          size: 42.r,
                                          color: cs.onSurfaceVariant
                                              .withValues(alpha: 0.4),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Camera badge
                        Positioned(
                          right: 6.w,
                          bottom: 6.w,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 38.w,
                            height: 38.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [cs.primary, cs.secondary],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: cs.primary.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 18.r,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Gap(24.h),

              // Pick photo button
              SizedBox(
                width: 200.w,
                height: 48.h,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onPickPhoto,
                    borderRadius: BorderRadius.circular(14.r),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: cs.primary, width: 1.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_library_outlined,
                            size: 20.r,
                            color: cs.primary,
                          ),
                          Gap(8.w),
                          Text(
                            widget.hasPhoto ? 'Ganti Foto' : 'Pilih Foto',
                            style: tt.labelLarge?.copyWith(
                              color: cs.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Gap(16.h),

              // Skip link (subtle)
              TextButton(
                onPressed: widget.onSkip,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 8.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Lewati untuk sekarang',
                  style: tt.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
