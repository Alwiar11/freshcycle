import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_textfield.dart';
import 'package:gap/gap.dart';

class EditInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController categoryController;

  const EditInfoSection({
    super.key,
    required this.nameController,
    required this.categoryController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: nameController,
          label: 'Nama Bahan',
          prefixIcon: const Icon(Icons.restaurant_rounded),
        ),
        Gap(16.h),
        AppTextField(
          controller: categoryController,
          label: 'Kategori',
          prefixIcon: const Icon(Icons.category_rounded),
        ),
      ],
    );
  }
}
