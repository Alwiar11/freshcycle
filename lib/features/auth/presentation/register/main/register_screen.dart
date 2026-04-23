import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/register_footer.dart';
import 'widgets/register_form.dart';
import 'widgets/register_header.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RegisterHeader(),
              SizedBox(height: 40.h),
              const RegisterForm(),
              SizedBox(height: 24.h),
              const RegisterFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
