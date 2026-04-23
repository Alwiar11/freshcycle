import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_dropdown.dart';
import 'package:freshcycle/core/widgets/app_textfield.dart';
import 'package:gap/gap.dart';

class AddInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final String? selectedCategory;
  final List<String> categories;
  final ValueChanged<String?> onCategoryChanged;

  const AddInfoSection({
    super.key,
    required this.nameController,
    required this.selectedCategory,
    required this.categories,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: nameController,
          label: 'Nama Item',
          hint: 'contoh: Brokoli, Ayam Fillet',
          validator: (v) => (v == null || v.trim().isEmpty)
              ? 'Nama tidak boleh kosong'
              : null,
        ),
        Gap(12.h),
        AppDropdown<String>(
          label: 'Kategori',
          value: selectedCategory,
          hint: 'Pilih kategori',
          validator: (v) => v == null ? 'Wajib dipilih' : null,
          onChanged: onCategoryChanged,
          items: categories
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
        ),
      ],
    );
  }
}
