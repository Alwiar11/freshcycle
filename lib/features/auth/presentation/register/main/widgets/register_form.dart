import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_textfield.dart';

import '../../../../../../core/widgets/app_primary_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: connect to Supabase auth
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            controller: _nameController,
            label: 'Nama Lengkap',
            hint: 'Masukkan nama kamu',
            prefixIcon: const Icon(Icons.person_outline),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama tidak boleh kosong';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'contoh@email.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              if (!value.contains('@')) return 'Format email tidak valid';
              return null;
            },
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: _passwordController,
            label: 'Password',
            hint: '••••••••',
            obscureText: _obscurePassword,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              if (value.length < 8) return 'Password minimal 8 karakter';
              return null;
            },
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: _confirmPasswordController,
            label: 'Konfirmasi Password',
            hint: '••••••••',
            obscureText: _obscureConfirmPassword,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Konfirmasi password tidak boleh kosong';
              }
              if (value != _passwordController.text) {
                return 'Password tidak cocok';
              }
              return null;
            },
          ),
          SizedBox(height: 32.h),
          AppPrimaryButton(label: 'Daftar', onPressed: _onSubmit),
        ],
      ),
    );
  }
}
