import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditHeader extends StatelessWidget {
  final Color bgColor;
  final String emoji;

  const EditHeader({super.key, required this.bgColor, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: bgColor.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(emoji, style: TextStyle(fontSize: 40.sp)),
        ),
      ),
    );
  }
}
