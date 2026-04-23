import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_dropdown.dart';
import 'package:freshcycle/core/widgets/app_textfield.dart';
import 'package:gap/gap.dart';

class EditQuantitySection extends StatelessWidget {
  final TextEditingController quantityController;
  final String selectedUnit;
  final List<String> units;
  final ValueChanged<String?> onUnitChanged;

  const EditQuantitySection({
    super.key,
    required this.quantityController,
    required this.selectedUnit,
    required this.units,
    required this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: _buildTextField(context)),
        Gap(12.w),
        Expanded(
          child: AppDropdown<String>(
            label: 'Satuan',
            value: selectedUnit,
            onChanged: onUnitChanged,
            items: units
                .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context) {
    return AppTextField(
      controller: quantityController,
      label: 'Kuantitas',
      keyboardType: TextInputType.number,
      prefixIcon: Icon(
        Icons.scale_rounded,
        size: 20.sp,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
