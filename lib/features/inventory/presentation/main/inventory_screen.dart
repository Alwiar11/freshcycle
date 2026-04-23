import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/inventory/domain/models/inventory_item.dart';
import 'package:freshcycle/features/inventory/presentation/main/widget/inventory_add_button.dart';
import 'package:freshcycle/features/inventory/presentation/main/widget/inventory_filter_chips.dart';
import 'package:freshcycle/features/inventory/presentation/main/widget/inventory_header.dart';
import 'package:freshcycle/features/inventory/presentation/main/widget/inventory_item_card.dart';
import 'package:freshcycle/features/inventory/presentation/main/widget/inventory_title.dart';
import 'package:gap/gap.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  int _selectedFilter = 0;

  final List<String> _filters = [
    'Semua',
    'Sayuran Hijau',
    'Sayuran',
    'Buah',
    'Daging',
    'Ikan',
    'Bumbu',
    'Minuman',
    'Susu',
    'Lainnya',
  ];

  static final List<InventoryItem> _items = [
    InventoryItem(
      name: 'Brokoli',
      category: 'Sayuran Hijau',
      quantity: 250,
      unit: 'gram',
      entryDate: DateTime(2026, 4, 14),
      expiryDate: DateTime(2026, 4, 21),
    ),
    InventoryItem(
      name: 'Tomat Cherry',
      category: 'Sayuran',
      quantity: 500,
      unit: 'gram',
      entryDate: DateTime(2026, 4, 13),
      expiryDate: DateTime(2026, 4, 24),
    ),
    InventoryItem(
      name: 'Ayam Fillet',
      category: 'Protein',
      quantity: 1,
      unit: 'kg',
      entryDate: DateTime(2026, 4, 15),
      expiryDate: DateTime(2026, 4, 25),
    ),
    InventoryItem(
      name: 'Wortel',
      category: 'Sayuran',
      quantity: 300,
      unit: 'gram',
      entryDate: DateTime(2026, 4, 10),
      expiryDate: DateTime(2026, 4, 26),
    ),
    InventoryItem(
      name: 'Susu Full Cream',
      category: 'Dairy',
      quantity: 1,
      unit: 'liter',
      entryDate: DateTime(2026, 4, 13),
      expiryDate: DateTime(2026, 4, 28),
    ),
  ];

  List<InventoryItem> get _filteredItems {
    if (_selectedFilter == 0) return _items;
    return _items
        .where((item) => item.category == _filters[_selectedFilter])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const InventoryHeader(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  Gap(24.h),
                  InventoryTitle(totalItems: _filteredItems.length),
                  Gap(20.h),
                  InventoryFilterChips(
                    selectedIndex: _selectedFilter,
                    filters: _filters,
                    onSelected: (value) =>
                        setState(() => _selectedFilter = value),
                  ),
                  Gap(20.h),
                  ..._filteredItems.map(
                    (item) => InventoryItemCard(item: item),
                  ),
                  Gap(12.h),
                  const InventoryAddButton(),
                  Gap(80.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
