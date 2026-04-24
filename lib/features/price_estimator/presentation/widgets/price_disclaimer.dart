import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:gap/gap.dart';

class PriceDisclaimer extends StatelessWidget {
  const PriceDisclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 16.r, color: AppColors.info),
          Gap(10.w),
          Expanded(
            child: Text(
              'Harga merupakan estimasi berdasarkan data umum AI. Harga aktual bisa berbeda tergantung lokasi, toko, dan kondisi pasar.',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.info,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
