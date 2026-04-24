import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/inventory/domain/models/inventory_item.dart';
import 'package:freshcycle/features/inventory/presentation/edit/widgets/edit_actions.dart';
import 'package:freshcycle/features/inventory/presentation/edit/widgets/edit_date_section.dart';
import 'package:freshcycle/features/inventory/presentation/edit/widgets/edit_header.dart';
import 'package:freshcycle/features/inventory/presentation/edit/widgets/edit_info_section.dart';
import 'package:freshcycle/features/inventory/presentation/edit/widgets/edit_quantity_section.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class InventoryEditScreen extends StatefulWidget {
  final InventoryItem item;

  const InventoryEditScreen({super.key, required this.item});

  @override
  State<InventoryEditScreen> createState() => _InventoryEditScreenState();
}

class _InventoryEditScreenState extends State<InventoryEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _quantityController;
  late TextEditingController _daysLeftController;
  late TextEditingController _maxDaysController;

  String _selectedUnit = 'gram';
  late DateTime _entryDate;
  late DateTime _expiryDate;

  final List<String> _units = ['gram', 'kg', 'liter', 'ml', 'pcs', 'buah'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _categoryController = TextEditingController(text: widget.item.category);
    _quantityController = TextEditingController(
      text: widget.item.quantity.toString(),
    );
    _daysLeftController = TextEditingController(
      text: widget.item.daysLeft.toString(),
    );
    _maxDaysController = TextEditingController(
      text: widget.item.maxDays.toString(),
    );
    _selectedUnit = widget.item.unit;
    _entryDate = widget.item.entryDate;
    _expiryDate = widget.item.expiryDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _quantityController.dispose();
    _daysLeftController.dispose();
    _maxDaysController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(bool isEntry) async {
    final initialDate = isEntry ? _entryDate : _expiryDate;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      builder: (context, child) {
        final theme = Theme.of(context);
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              surface: theme.colorScheme.surfaceContainerHighest,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isEntry) {
          _entryDate = picked;
        } else {
          _expiryDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: 18.sp),
        ),
        leadingWidth: 60.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            child: InkWell(
              onTap: () => context.pop(),
              borderRadius: BorderRadius.circular(10.r),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 18.r,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          EditHeader(bgColor: widget.item.bgColor, emoji: widget.item.emoji),
          Gap(28.h),
          EditInfoSection(
            nameController: _nameController,
            categoryController: _categoryController,
          ),
          Gap(16.h),
          EditQuantitySection(
            quantityController: _quantityController,
            selectedUnit: _selectedUnit,
            units: _units,
            onUnitChanged: (val) => setState(() => _selectedUnit = val!),
          ),
          Gap(16.h),
          EditDateSection(
            entryDate: _entryDate,
            expiryDate: _expiryDate,
            onPickEntry: () => _pickDate(true),
            onPickExpiry: () => _pickDate(false),
          ),
          Gap(32.h),
          EditActions(onSave: () {}),
        ],
      ),
    );
  }
}
