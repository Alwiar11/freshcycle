import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_primary_button.dart';
import 'package:freshcycle/core/widgets/app_textfield.dart';
import 'package:gap/gap.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({super.key});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: update password via Supabase
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            controller: _currentPasswordController,
            label: 'Current Password',
            hint: '••••••••',
            obscureText: _obscureCurrent,
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureCurrent
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () =>
                  setState(() => _obscureCurrent = !_obscureCurrent),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Current password cannot be empty';
              }
              return null;
            },
          ),
          Gap(24.h),
          AppTextField(
            controller: _newPasswordController,
            label: 'New Password',
            hint: '••••••••',
            obscureText: _obscureNew,
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureNew
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () => setState(() => _obscureNew = !_obscureNew),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'New password cannot be empty';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              if (value == _currentPasswordController.text) {
                return 'New password must be different from current';
              }
              return null;
            },
          ),
          Gap(16.h),
          AppTextField(
            controller: _confirmPasswordController,
            label: 'Confirm New Password',
            hint: '••••••••',
            obscureText: _obscureConfirm,
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirm
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your new password';
              }
              if (value != _newPasswordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          Gap(32.h),
          AppPrimaryButton(label: 'Update Password', onPressed: _onSave),
        ],
      ),
    );
  }
}
