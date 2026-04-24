import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'widgets/onboarding_dots.dart';
import 'widgets/onboarding_nav_button.dart';
import 'widgets/onboarding_page_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _contentAnimController;
  int _currentPage = 0;

  final List<OnboardingData> pages = [
    const OnboardingData(
      emoji: '🥦',
      title: 'Pantau Kesegaran\nBahanmu',
      subtitle:
          'Lacak semua bahan makanan di rumahmu dan ketahui mana yang hampir kedaluwarsa.',
      bgColor: Color(0xFFEAF3DE),
      accentColor: Color(0xFF3B6D11),
    ),
    const OnboardingData(
      emoji: '🤖',
      title: 'Resep Cerdas\ndari AI',
      subtitle:
          'Dapatkan rekomendasi resep otomatis berdasarkan bahan yang kamu punya.',
      bgColor: Color(0xFFE8F4FD),
      accentColor: Color(0xFF1565C0),
    ),
    const OnboardingData(
      emoji: '💰',
      title: 'Kurangi Sampah,\nHemat Lebih',
      subtitle:
          'Estimasi harga dan kurangi pemborosan dengan manajemen stok yang cerdas.',
      bgColor: Color(0xFFFFF3E0),
      accentColor: Color(0xFF854F0B),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _contentAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _contentAnimController.forward();
  }

  @override
  void dispose() {
    _contentAnimController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      setState(() => _currentPage++);
      _playContentAnim();
    } else {
      context.go('/login');
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
      _playContentAnim();
    }
  }

  void _playContentAnim() {
    _contentAnimController.reset();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _contentAnimController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final page = pages[_currentPage];
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w, top: 12.h),
                child: TextButton(
                  onPressed: () => context.go('/login'),
                  child: Text('Lewati', style: tt.labelMedium),
                ),
              ),
            ),

            // Content
            Flexible(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(0.08, 0),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                      child: child,
                    ),
                  );
                },
                child: SizedBox.expand(
                  key: ValueKey(_currentPage),
                  child: OnboardingPageContent(
                    data: pages[_currentPage],
                    animController: _contentAnimController,
                  ),
                ),
              ),
            ),

            // Bottom nav
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 40.h),
              child: Column(
                children: [
                  OnboardingDots(
                    count: pages.length,
                    current: _currentPage,
                    activeColor: page.accentColor,
                  ),
                  Gap(28.h),
                  Row(
                    children: [
                      // Back button
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: _currentPage > 0
                            ? Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: SizedBox(
                                  height: 56.h,
                                  width: 56.h,
                                  child: ElevatedButton(
                                    onPressed: _prevPage,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: cs.surfaceContainer,
                                      foregroundColor: cs.onSurface,
                                      elevation: 0,
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_rounded,
                                      size: 22.sp,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),

                      // Next / Mulai button
                      Expanded(
                        child: OnboardingNavButton(
                          isLast: _currentPage == pages.length - 1,
                          accentColor: page.accentColor,
                          onPressed: _nextPage,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
