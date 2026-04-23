import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/inventory/domain/models/inventory_item.dart';
import 'package:freshcycle/features/inventory/presentation/add/widgets/add_actions.dart';
import 'package:freshcycle/features/inventory/presentation/add/widgets/add_date_section.dart';
import 'package:freshcycle/features/inventory/presentation/add/widgets/add_info_section.dart';
import 'package:freshcycle/features/inventory/presentation/add/widgets/add_quantity_section.dart';
import 'package:freshcycle/features/inventory/presentation/add/widgets/add_section_label.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class InventoryAddScreen extends StatefulWidget {
  const InventoryAddScreen({super.key});

  @override
  State<InventoryAddScreen> createState() => _InventoryAddScreenState();
}

class _InventoryAddScreenState extends State<InventoryAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();

  String? _selectedCategory;
  String? _selectedUnit;
  final DateTime _entryDate = DateTime.now();
  DateTime? _expiryDate;

  static const _categories = [
    'Sayuran',
    'Sayuran Hijau',
    'Buah',
    'Protein',
    'Dairy',
    'Bumbu',
    'Lainnya',
  ];
  static const _units = ['gram', 'kg', 'liter', 'ml', 'pcs', 'buah', 'bungkus'];

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _expiryDate = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_expiryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Pilih tanggal kedaluwarsa terlebih dahulu'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    final newItem = InventoryItem(
      name: _nameController.text.trim(),
      category: _selectedCategory ?? '',
      quantity: double.parse(_quantityController.text),
      unit: _selectedUnit ?? '',
      entryDate: _entryDate,
      expiryDate: _expiryDate!,
    );

    context.pop(newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Theme.of(context).colorScheme.onSurface,
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Tambah Item',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 40.h),
          children: [
            const AddSectionLabel(label: 'Informasi Item'),
            Gap(12.h),
            AddInfoSection(
              nameController: _nameController,
              selectedCategory: _selectedCategory,
              categories: _categories,
              onCategoryChanged: (v) => setState(() => _selectedCategory = v),
            ),
            Gap(24.h),
            const AddSectionLabel(label: 'Jumlah'),
            Gap(12.h),
            AddQuantitySection(
              quantityController: _quantityController,
              selectedUnit: _selectedUnit,
              units: _units,
              onUnitChanged: (v) => setState(() => _selectedUnit = v),
            ),
            Gap(24.h),
            const AddSectionLabel(label: 'Tanggal'),
            Gap(12.h),
            AddDateSection(
              entryDate: _entryDate,
              expiryDate: _expiryDate,
              onPickExpiry: _pickDate,
            ),
            Gap(32.h),
            AddActions(onSubmit: _submit),
          ],
        ),
      ),
    );
  }
}
