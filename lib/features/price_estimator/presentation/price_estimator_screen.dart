import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/theme/app_colors.dart';
import 'package:freshcycle/core/widgets/app_primary_button.dart';
import 'package:freshcycle/features/price_estimator/domain/models/price_trend.dart';
import 'package:freshcycle/features/price_estimator/presentation/widgets/price_category_section.dart';
import 'package:freshcycle/features/price_estimator/presentation/widgets/price_disclaimer.dart';
import 'package:freshcycle/features/price_estimator/presentation/widgets/price_header.dart';
import 'package:freshcycle/features/price_estimator/presentation/widgets/price_search_bar.dart';

import 'package:gap/gap.dart';

class PriceEstimatorScreen extends StatefulWidget {
  const PriceEstimatorScreen({super.key});

  @override
  State<PriceEstimatorScreen> createState() => _PriceEstimatorScreenState();
}

class _PriceEstimatorScreenState extends State<PriceEstimatorScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isLoading = false;
  Timer? _searchDebounce;

  static const List<PriceItem> _dummyItems = [
    // Daging & Protein
    PriceItem(
      name: 'Ayam Fillet',
      emoji: '🍗',
      pricePerUnit: 38000,
      unit: 'kg',
      category: 'Daging & Protein',
      trend: PriceTrend.up,
      note: 'Supermarket rata-rata',
    ),
    PriceItem(
      name: 'Telur Ayam',
      emoji: '🥚',
      pricePerUnit: 28000,
      unit: 'kg',
      category: 'Daging & Protein',
      trend: PriceTrend.stable,
      note: 'Sekitar 16 butir/kg',
    ),
    PriceItem(
      name: 'Daging Sapi',
      emoji: '🥩',
      pricePerUnit: 130000,
      unit: 'kg',
      category: 'Daging & Protein',
      trend: PriceTrend.up,
      note: 'Has dalam / tenderloin',
    ),
    PriceItem(
      name: 'Tahu Putih',
      emoji: '🍱',
      pricePerUnit: 3000,
      unit: 'biji',
      category: 'Daging & Protein',
      trend: PriceTrend.stable,
      note: 'Ukuran sedang',
    ),
    // Sayuran
    PriceItem(
      name: 'Brokoli',
      emoji: '🥦',
      pricePerUnit: 15000,
      unit: 'kg',
      category: 'Sayuran',
      trend: PriceTrend.down,
      note: 'Musim panen melimpah',
    ),
    PriceItem(
      name: 'Bayam',
      emoji: '🌿',
      pricePerUnit: 5000,
      unit: 'ikat',
      category: 'Sayuran',
      trend: PriceTrend.stable,
      note: 'Pasar tradisional',
    ),
    PriceItem(
      name: 'Wortel',
      emoji: '🥕',
      pricePerUnit: 12000,
      unit: 'kg',
      category: 'Sayuran',
      trend: PriceTrend.stable,
      note: 'Kualitas medium',
    ),
    PriceItem(
      name: 'Bawang Putih',
      emoji: '🧄',
      pricePerUnit: 40000,
      unit: 'kg',
      category: 'Sayuran',
      trend: PriceTrend.up,
      note: 'Impor China',
    ),
    // Buah
    PriceItem(
      name: 'Pisang Cavendish',
      emoji: '🍌',
      pricePerUnit: 18000,
      unit: 'kg',
      category: 'Buah',
      trend: PriceTrend.stable,
      note: 'Supermarket',
    ),
    PriceItem(
      name: 'Anggur Hijau',
      emoji: '🍇',
      pricePerUnit: 45000,
      unit: 'kg',
      category: 'Buah',
      trend: PriceTrend.down,
      note: 'Impor, harga turun',
    ),
    PriceItem(
      name: 'Lemon',
      emoji: '🍋',
      pricePerUnit: 5000,
      unit: 'biji',
      category: 'Buah',
      trend: PriceTrend.stable,
      note: 'Ukuran sedang',
    ),
    // Dairy & Minuman
    PriceItem(
      name: 'Susu Full Cream',
      emoji: '🥛',
      pricePerUnit: 18000,
      unit: 'liter',
      category: 'Dairy & Minuman',
      trend: PriceTrend.stable,
      note: 'UHT 1L',
    ),
    PriceItem(
      name: 'Madu Murni',
      emoji: '🍯',
      pricePerUnit: 85000,
      unit: '500ml',
      category: 'Dairy & Minuman',
      trend: PriceTrend.up,
      note: 'Madu hutan asli',
    ),
    // Bumbu & Minyak
    PriceItem(
      name: 'Minyak Goreng',
      emoji: '🫙',
      pricePerUnit: 21000,
      unit: 'liter',
      category: 'Bumbu & Minyak',
      trend: PriceTrend.stable,
      note: 'Kemasan 2L',
    ),
    PriceItem(
      name: 'Kecap Manis',
      emoji: '🍶',
      pricePerUnit: 12000,
      unit: 'botol',
      category: 'Bumbu & Minyak',
      trend: PriceTrend.stable,
      note: 'Botol 135ml',
    ),
    PriceItem(
      name: 'Olive Oil',
      emoji: '🫒',
      pricePerUnit: 65000,
      unit: '250ml',
      category: 'Bumbu & Minyak',
      trend: PriceTrend.up,
      note: 'Extra virgin',
    ),
  ];

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      setState(() => _searchQuery = value);
    });
  }

  List<PriceItem> get _filteredItems {
    if (_searchQuery.isEmpty) return _dummyItems;
    return _dummyItems
        .where(
          (item) =>
              item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              item.category.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  static Map<String, List<PriceItem>> _groupByCategory(List<PriceItem> items) {
    final grouped = <String, List<PriceItem>>{};
    for (final item in items) {
      grouped.putIfAbsent(item.category, () => []).add(item);
    }
    return grouped;
  }

  static Map<PriceTrend, int> _computeTrendSummary(List<PriceItem> items) {
    return {
      PriceTrend.up: items.where((e) => e.trend == PriceTrend.up).length,
      PriceTrend.down: items.where((e) => e.trend == PriceTrend.down).length,
      PriceTrend.stable: items
          .where((e) => e.trend == PriceTrend.stable)
          .length,
    };
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredItems;
    final grouped = _groupByCategory(filtered);
    final entries = grouped.entries.toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: PriceHeader()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                child: PriceSearchBar(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                child: _buildTrendSummary(filtered),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                child: AppPrimaryButton(
                  label: 'Perbarui Estimasi AI',
                  icon: Icons.auto_awesome_rounded,
                  isLoading: _isLoading,
                  loadingLabel: 'AI sedang menganalisa...',
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() => _isLoading = false);
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                child: const PriceDisclaimer(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index == entries.length) return Gap(40.h);
                  final entry = entries[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: PriceCategorySection(
                      category: entry.key,
                      items: entry.value,
                    ),
                  );
                }, childCount: entries.length + 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendSummary(List<PriceItem> items) {
    final summary = _computeTrendSummary(items);

    return Row(
      children: [
        _TrendChip(
          icon: Icons.trending_up_rounded,
          label: '${summary[PriceTrend.up]} naik',
          color: AppColors.danger,
        ),
        Gap(8.w),
        _TrendChip(
          icon: Icons.trending_down_rounded,
          label: '${summary[PriceTrend.down]} turun',
          color: AppColors.success,
        ),
        Gap(8.w),
        _TrendChip(
          icon: Icons.trending_flat_rounded,
          label: '${summary[PriceTrend.stable]} stabil',
          color: AppColors.warning,
        ),
      ],
    );
  }
}

class _TrendChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _TrendChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.r, color: color),
          Gap(4.w),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
