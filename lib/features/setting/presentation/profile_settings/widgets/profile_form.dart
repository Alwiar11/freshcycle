import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_primary_button.dart';
import 'package:freshcycle/core/widgets/app_textfield.dart';

import 'package:gap/gap.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Alex Sterling');
  final _emailController = TextEditingController(
    text: 'alex.s@verdantgallery.com',
  );
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: update profile to Supabase
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
            label: 'Full Name',
            hint: 'Your full name',
            prefixIcon: const Icon(Icons.person_outline_rounded),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Name cannot be empty';
              return null;
            },
          ),
          Gap(16.h),
          AppTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'your@email.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Email cannot be empty';
              if (!value.contains('@')) return 'Invalid email format';
              return null;
            },
          ),
          Gap(16.h),
          AppTextField(
            controller: _phoneController,
            label: 'Phone Number',
            hint: '+62 812 xxxx xxxx',
            keyboardType: TextInputType.phone,
            prefixIcon: const Icon(Icons.phone_outlined),
          ),
          Gap(32.h),
          AppPrimaryButton(label: 'Save Changes', onPressed: _onSave),
        ],
      ),
    );
  }
}
