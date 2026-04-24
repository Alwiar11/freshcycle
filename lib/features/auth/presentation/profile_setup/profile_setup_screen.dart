import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/auth/presentation/profile_setup/widgets/profile_setup_nav_button.dart';
import 'package:freshcycle/features/auth/presentation/profile_setup/widgets/profile_setup_progress.dart';
import 'package:freshcycle/features/auth/presentation/profile_setup/widgets/profile_setup_step1.dart';
import 'package:freshcycle/features/auth/presentation/profile_setup/widgets/profile_setup_step2.dart';
import 'package:freshcycle/features/auth/presentation/profile_setup/widgets/profile_setup_step3.dart';
import 'package:gap/gap.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _phoneController = TextEditingController();

  // Form keys for validation per step
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  int _currentStep = 1;
  int _previousStep = 1;
  String? _selectedGender;
  DateTime? _selectedBirthDate;
  String? _selectedProvince;
  String? _selectedCity;
  bool _hasPhoto = false;

  static const int _totalSteps = 3;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    if (step < 1 || step > _totalSteps) return;
    setState(() {
      _previousStep = _currentStep;
      _currentStep = step;
    });
  }

  void _next() {
    if (_currentStep == 1) {
      if (!(_formKey1.currentState?.validate() ?? false)) return;
    } else if (_currentStep == 2) {
      if (!(_formKey2.currentState?.validate() ?? false)) return;
    }

    if (_currentStep < _totalSteps) {
      _goToStep(_currentStep + 1);
    } else {
      _finish();
    }
  }

  void _back() {
    if (_currentStep > 1) {
      _goToStep(_currentStep - 1);
    }
  }

  void _finish() {
    Navigator.of(context).pop();
  }

  bool get _isStepValid {
    switch (_currentStep) {
      case 1:
        return _phoneController.text.trim().length >= 10 &&
            _selectedGender != null &&
            _selectedBirthDate != null;
      case 2:
        return _selectedProvince != null && _selectedCity != null;
      case 3:
        return true;
      default:
        return false;
    }
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate ?? DateTime(now.year - 20),
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: Theme.of(context).colorScheme),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedBirthDate = picked);
    }
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      default:
        return _buildStep1();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final goingForward = _currentStep >= _previousStep;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header + Progress ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(cs, tt),
                  Gap(24.h),
                  ProfileSetupProgress(
                    currentStep: _currentStep,
                    totalSteps: _totalSteps,
                  ),
                ],
              ),
            ),

            // ── Step Content ──
            Expanded(
              flex: 0,
              child: ClipRect(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    final isIncoming = child.key == ValueKey(_currentStep);
                    final slideBegin = isIncoming
                        ? Offset(goingForward ? 0.15 : -0.15, 0)
                        : Offset(goingForward ? -0.15 : 0.15, 0);
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: slideBegin,
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey(_currentStep),
                    child: _buildCurrentStep(),
                  ),
                ),
              ),
            ),

            // ── Nav Buttons ──
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
              child: ProfileSetupNavButton(
                currentStep: _currentStep,
                totalSteps: _totalSteps,
                isNextEnabled: _isStepValid,
                onNext: _next,
                onBack: _back,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme cs, TextTheme tt) {
    return Row(
      children: [
        Gap(14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lengkapi Profil',
                style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              Gap(2.h),
              Text(
                'Langkah $_currentStep dari $_totalSteps',
                style: tt.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ProfileSetupStep1(
        formKey: _formKey1,
        phoneController: _phoneController,
        selectedGender: _selectedGender,
        selectedBirthDate: _selectedBirthDate,
        onGenderChanged: (v) => setState(() => _selectedGender = v),
        onPickBirthDate: _pickBirthDate,
        onPhoneChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ProfileSetupStep2(
        formKey: _formKey2,
        selectedProvince: _selectedProvince,
        selectedCity: _selectedCity,
        onProvinceChanged: (v) => setState(() => _selectedProvince = v),
        onCityChanged: (v) => setState(() => _selectedCity = v),
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ProfileSetupStep3(
        hasPhoto: _hasPhoto,
        onPickPhoto: () => setState(() => _hasPhoto = !_hasPhoto),
        onSkip: _finish,
        onFinish: _finish,
      ),
    );
  }
}
