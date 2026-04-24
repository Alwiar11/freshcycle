import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:freshcycle/features/cooking/domain/models/cooking_ingredient.dart';
import 'package:freshcycle/features/cooking/domain/models/cooking_step.dart';
import 'package:freshcycle/features/cooking/presentation/widgets/cooking_ingredient_row.dart';
import 'package:freshcycle/features/cooking/presentation/widgets/cooking_navigation_bar.dart';
import 'package:freshcycle/features/cooking/presentation/widgets/cooking_progress_header.dart';
import 'package:freshcycle/features/cooking/presentation/widgets/cooking_timer.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CookingSessionScreen extends StatefulWidget {
  const CookingSessionScreen({super.key});

  @override
  State<CookingSessionScreen> createState() => _CookingSessionScreenState();
}

class _CookingSessionScreenState extends State<CookingSessionScreen> {
  // Dummy data
  static const String _recipeTitle = 'Tumis Ayam Brokoli';
  static const String _recipeEmoji = '🍳';

  static const List<CookingStep> _steps = [
    CookingStep(
      instruction:
          'Potong ayam fillet menjadi ukuran kecil dan cuci bersih. Pastikan tidak ada sisa tulang atau lemak berlebih.',
      durationMinutes: 5,
      ingredients: [
        CookingIngredient(name: 'Ayam Fillet', qty: 300, unit: 'gram'),
      ],
    ),
    CookingStep(
      instruction:
          'Potong brokoli menjadi kuntum-kuntum kecil, lalu rendam dalam air garam selama beberapa menit untuk membersihkan kotoran.',
      ingredients: [CookingIngredient(name: 'Brokoli', qty: 150, unit: 'gram')],
    ),
    CookingStep(
      instruction:
          'Panaskan minyak dalam wajan, tumis bawang putih yang sudah dicincang halus hingga harum dan kekuningan.',
      durationMinutes: 3,
      ingredients: [
        CookingIngredient(name: 'Bawang Putih', qty: 3, unit: 'siung'),
        CookingIngredient(name: 'Minyak Goreng', qty: 2, unit: 'sdm'),
      ],
    ),
    CookingStep(
      instruction:
          'Masukkan potongan ayam fillet ke dalam wajan. Tumis hingga berubah warna menjadi putih kecokelatan di semua sisi.',
      durationMinutes: 7,
      ingredients: [],
    ),
    CookingStep(
      instruction:
          'Tambahkan brokoli dan kecap manis, aduk rata hingga semua bahan tercampur. Tambahkan sedikit air jika terlalu kering.',
      durationMinutes: 5,
      ingredients: [
        CookingIngredient(name: 'Kecap Manis', qty: 2, unit: 'sdm'),
        CookingIngredient(name: 'Air', qty: 50, unit: 'ml'),
      ],
    ),
    CookingStep(
      instruction:
          'Tambahkan garam dan lada secukupnya. Masak hingga semua bahan matang sempurna dan bumbu meresap. Angkat dan sajikan.',
      ingredients: [
        CookingIngredient(name: 'Garam', qty: 0.5, unit: 'sdt'),
        CookingIngredient(name: 'Lada', qty: 0.25, unit: 'sdt'),
      ],
    ),
  ];

  int _currentStepIndex = 0;

  // Timer state
  bool _isTimerRunning = false;
  int _timerRemaining = 0;
  int _timerTotal = 0;
  Timer? _timer;

  // Adjusted qty per step per ingredient
  // Map<stepIndex, Map<ingredientName, adjustedQty>>
  late Map<int, Map<String, double>> _adjustedQty;

  @override
  void initState() {
    super.initState();
    _initAdjustedQty();
  }

  void _initAdjustedQty() {
    _adjustedQty = {};
    for (int i = 0; i < _steps.length; i++) {
      _adjustedQty[i] = {};
      for (final ing in _steps[i].ingredients) {
        _adjustedQty[i]![ing.name] = ing.qty;
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Timer logic
  void _startTimer() {
    if (_timerRemaining == 0) return;
    setState(() => _isTimerRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timerRemaining <= 1) {
        _timer?.cancel();
        setState(() {
          _timerRemaining = 0;
          _isTimerRunning = false;
        });
        _onTimerFinished();
      } else {
        setState(() => _timerRemaining--);
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isTimerRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isTimerRunning = false;
      _timerRemaining = _timerTotal;
    });
  }

  void _onTimerFinished() {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: const Text('⏰ Timer Selesai!'),
        content: Text(
          'Waktu untuk step ini sudah habis. Periksa masakan kamu!',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Oke',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSetTimerDialog() {
    final defaultMinutes =
        _steps[_currentStepIndex].durationMinutes?.toString() ?? '5';
    final controller = TextEditingController(text: defaultMinutes);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Set Durasi Timer',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Menit',
                suffixText: 'menit',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Batal',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final minutes = int.tryParse(controller.text) ?? 0;
              if (minutes > 0) {
                _timer?.cancel();
                setState(() {
                  _timerTotal = minutes * 60;
                  _timerRemaining = minutes * 60;
                  _isTimerRunning = false;
                });
              }
              Navigator.pop(context);
            },
            child: Text(
              'Set',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToNextStep() {
    if (_currentStepIndex < _steps.length - 1) {
      _timer?.cancel();
      setState(() {
        _currentStepIndex++;
        _isTimerRunning = false;
        _timerRemaining = 0;
        _timerTotal = 0;
      });
    } else {
      _goToSummary();
    }
  }

  void _goToPreviousStep() {
    if (_currentStepIndex > 0) {
      _timer?.cancel();
      setState(() {
        _currentStepIndex--;
        _isTimerRunning = false;
        _timerRemaining = 0;
        _timerTotal = 0;
      });
    }
  }

  void _goToSummary() {
    _timer?.cancel();
    context.push(
      '/cooking-summary',
      extra: {
        'recipeTitle': _recipeTitle,
        'recipeEmoji': _recipeEmoji,
        'adjustedQty': _adjustedQty,
        'steps': _steps,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStepIndex];
    final stepQty = _adjustedQty[_currentStepIndex]!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            CookingProgressHeader(
              recipeTitle: _recipeTitle,
              currentStep: _currentStepIndex,
              totalSteps: _steps.length,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEmojiHeader(),
                    Gap(20.h),
                    _buildStepInstruction(context, step),
                    Gap(20.h),
                    CookingTimerWidget(
                      remainingSeconds: _timerRemaining,
                      totalSeconds: _timerTotal,
                      isRunning: _isTimerRunning,
                      onStart: _startTimer,
                      onPause: _pauseTimer,
                      onReset: _resetTimer,
                      onSetTimer: _showSetTimerDialog,
                    ),
                    if (step.ingredients.isNotEmpty) ...[
                      Gap(20.h),
                      _buildIngredientsSection(context, step, stepQty),
                    ],
                    Gap(20.h),
                  ],
                ),
              ),
            ),
            CookingNavigationBar(
              isFirstStep: _currentStepIndex == 0,
              isLastStep: _currentStepIndex == _steps.length - 1,
              onPrevious: _goToPreviousStep,
              onNext: _goToNextStep,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiHeader() {
    return Center(
      child: Container(
        width: 80.w,
        height: 80.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(_recipeEmoji, style: TextStyle(fontSize: 40.sp)),
        ),
      ),
    );
  }

  Widget _buildStepInstruction(BuildContext context, CookingStep step) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
            AppColors.secondary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      AppColors.secondary,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${_currentStepIndex + 1}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Gap(8.w),
              Text(
                'Langkah ${_currentStepIndex + 1}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          Gap(12.h),
          Text(
            step.instruction,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsSection(
    BuildContext context,
    CookingStep step,
    Map<String, double> stepQty,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.shopping_basket_rounded,
              size: 16.r,
              color: Theme.of(context).colorScheme.primary,
            ),
            Gap(6.w),
            Text(
              'Bahan di step ini',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        Gap(10.h),
        ...step.ingredients.map(
          (ing) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: CookingIngredientRow(
              ingredient: ing,
              adjustedQty: stepQty[ing.name] ?? ing.qty,
              onQtyChanged: (newQty) {
                setState(() {
                  _adjustedQty[_currentStepIndex]![ing.name] = newQty;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
