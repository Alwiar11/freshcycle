import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_dropdown.dart';
import 'package:freshcycle/core/widgets/app_textfield.dart';
import 'package:gap/gap.dart';

class AddQuantitySection extends StatelessWidget {
  final TextEditingController quantityController;
  final String? selectedUnit;
  final List<String> units;
  final ValueChanged<String?> onUnitChanged;

  const AddQuantitySection({
    super.key,
    required this.quantityController,
    required this.selectedUnit,
    required this.units,
    required this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildQuantityField(context)),
        Gap(12.w),
        Expanded(
          flex: 2,
          child: AppDropdown<String>(
            label: 'Satuan',
            value: selectedUnit,
            hint: 'Satuan',
            validator: (v) => v == null ? 'Wajib dipilih' : null,
            onChanged: onUnitChanged,
            items: units
                .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityField(BuildContext context) {
    return AppTextField(
      controller: quantityController,
      label: 'Jumlah',
      hint: '0',
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
      ],
      validator: (v) {
        if (v == null || v.isEmpty) return 'Wajib diisi';
        if (double.tryParse(v) == null) return 'Angka tidak valid';
        return null;
      },
    );
  }
}
