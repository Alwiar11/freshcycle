import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_date_picker.dart';
import 'package:gap/gap.dart';
import 'gender_selection.dart';
import 'step_header.dart';

class ProfileSetupStep1 extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final String? selectedGender;
  final DateTime? selectedBirthDate;
  final ValueChanged<String?> onGenderChanged;
  final VoidCallback onPickBirthDate;
  final ValueChanged<String>? onPhoneChanged;

  const ProfileSetupStep1({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.selectedGender,
    required this.selectedBirthDate,
    required this.onGenderChanged,
    required this.onPickBirthDate,
    this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepHeader(
              icon: Icons.person_outline_rounded,
              title: 'Informasi Dasar',
              subtitle:
                  'Lengkapi data dirimu untuk pengalaman yang lebih personal.',
            ),
            Gap(28.h),
            Text(
              'Nomor HP',
              style: tt.labelMedium?.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8.h),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              onChanged: onPhoneChanged,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(15),
              ],
              style: tt.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Contoh: 08123456789',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 14.w, right: 8.w),
                  child: Icon(
                    Icons.phone_outlined,
                    size: 20.r,
                    color: cs.primary,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: cs.outline.withValues(alpha: 0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: cs.outline.withValues(alpha: 0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: cs.primary, width: 1.5),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nomor HP wajib diisi';
                }
                if (value.trim().length < 10) {
                  return 'Nomor HP minimal 10 digit';
                }
                return null;
              },
            ),
            Gap(20.h),
            GenderSelection(
              selectedGender: selectedGender,
              onChanged: onGenderChanged,
            ),
            Gap(20.h),
            AppDatePicker(
              label: 'Tanggal Lahir',
              date: selectedBirthDate,
              onTap: onPickBirthDate,
              validator: (date) => date == null ? 'Pilih tanggal lahir' : null,
            ),

            Gap(16.h),
          ],
        ),
      ),
    );
  }
}
