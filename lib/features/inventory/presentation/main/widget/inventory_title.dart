import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class InventoryTitle extends StatelessWidget {
  final int totalItems;

  const InventoryTitle({super.key, required this.totalItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stok Kamu',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(height: 1.1),
        ),
        Gap(4.h),
        Text(
          '$totalItems bahan tersimpan',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
