import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_textfield.dart';

import '../../../../../../core/widgets/app_primary_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: connect to Supabase auth
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
          SizedBox(height: 12.h),
          InkWell(
            onTap: () {}, // TODO: navigate to forgot password
            child: Text(
              'Lupa password?',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          SizedBox(height: 32.h),
          AppPrimaryButton(label: 'Masuk', onPressed: _onSubmit),
        ],
      ),
    );
  }
}
