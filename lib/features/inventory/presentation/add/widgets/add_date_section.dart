import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_date_picker.dart';
import 'package:gap/gap.dart';

class AddDateSection extends StatelessWidget {
  final DateTime entryDate;
  final DateTime? expiryDate;
  final VoidCallback onPickExpiry;

  const AddDateSection({
    super.key,
    required this.entryDate,
    required this.expiryDate,
    required this.onPickExpiry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppDatePicker(
          label: 'Tanggal Masuk',
          date: entryDate,
          onTap: () {},
          disabled: true,
          format: 'dd/MM/yyyy',
        ),
        Gap(12.h),
        AppDatePicker(
          label: 'Tanggal Kedaluwarsa',
          date: expiryDate,
          onTap: onPickExpiry,
          error: expiryDate == null,
          format: 'dd/MM/yyyy',
        ),
      ],
    );
  }
}
