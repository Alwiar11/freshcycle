import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_date_picker.dart';
import 'package:gap/gap.dart';

class EditDateSection extends StatelessWidget {
  final DateTime entryDate;
  final DateTime expiryDate;
  final VoidCallback onPickEntry;
  final VoidCallback onPickExpiry;

  const EditDateSection({
    super.key,
    required this.entryDate,
    required this.expiryDate,
    required this.onPickEntry,
    required this.onPickExpiry,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppDatePicker(
            label: 'Tanggal Masuk',
            date: entryDate,
            onTap: onPickEntry,
          ),
        ),
        Gap(12.w),
        Expanded(
          child: AppDatePicker(
            label: 'Tanggal Expired',
            date: expiryDate,
            onTap: onPickExpiry,
          ),
        ),
      ],
    );
  }
}
