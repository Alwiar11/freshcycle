import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'step_header.dart';

class ProfileSetupStep2 extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String? selectedProvince;
  final String? selectedCity;
  final ValueChanged<String?> onProvinceChanged;
  final ValueChanged<String?> onCityChanged;

  const ProfileSetupStep2({
    super.key,
    required this.formKey,
    required this.selectedProvince,
    required this.selectedCity,
    required this.onProvinceChanged,
    required this.onCityChanged,
  });

  static const Map<String, List<String>> _cities = {
    'DKI Jakarta': [
      'Jakarta Pusat',
      'Jakarta Selatan',
      'Jakarta Barat',
      'Jakarta Timur',
      'Jakarta Utara',
    ],
    'Jawa Barat': ['Bandung', 'Bogor', 'Depok', 'Bekasi', 'Tasikmalaya'],
    'Jawa Tengah': [
      'Semarang',
      'Surakarta',
      'Yogyakarta',
      'Magelang',
      'Pekalongan',
    ],
    'Jawa Timur': ['Surabaya', 'Malang', 'Kediri', 'Madiun', 'Blitar'],
    'Banten': ['Tangerang', 'Serang', 'Cilegon', 'Pandeglang', 'Lebak'],
  };

  static const List<String> _provinces = [
    'DKI Jakarta',
    'Jawa Barat',
    'Jawa Tengah',
    'Jawa Timur',
    'Banten',
  ];

  List<String> get _availableCities {
    if (selectedProvince == null) return [];
    return _cities[selectedProvince] ?? [];
  }

  InputDecoration _dropdownDecoration(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: cs.outline.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: cs.outline.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: cs.primary, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepHeader(
              icon: Icons.location_on_outlined,
              title: 'Lokasi',
              subtitle: 'Bantu kami menyesuaikan konten dan layanan terdekat.',
            ),
            Gap(28.h),
            Text(
              'Provinsi',
              style: tt.labelMedium?.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8.h),
            DropdownButtonFormField<String>(
              initialValue: selectedProvince,
              hint: Text(
                'Pilih provinsi',
                style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
              ),
              isExpanded: true,
              style: tt.bodyMedium,
              dropdownColor: cs.surface,
              borderRadius: BorderRadius.circular(16.r),
              decoration: _dropdownDecoration(context),
              items: _provinces.map((p) {
                return DropdownMenuItem(value: p, child: Text(p));
              }).toList(),
              onChanged: (v) {
                onProvinceChanged(v);
                onCityChanged(null);
              },
              validator: (value) {
                if (value == null) return 'Pilih provinsi';
                return null;
              },
            ),
            Gap(20.h),
            Text(
              'Kota / Kabupaten',
              style: tt.labelMedium?.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8.h),
            DropdownButtonFormField<String>(
              initialValue: selectedCity,
              hint: Text(
                selectedProvince == null
                    ? 'Pilih provinsi terlebih dahulu'
                    : 'Pilih kota',
                style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
              ),
              isExpanded: true,
              style: tt.bodyMedium,
              dropdownColor: cs.surface,
              borderRadius: BorderRadius.circular(16.r),
              decoration: _dropdownDecoration(context),
              items: _availableCities.map((c) {
                return DropdownMenuItem(value: c, child: Text(c));
              }).toList(),
              onChanged: selectedProvince == null ? null : onCityChanged,
              validator: (value) {
                if (value == null) return 'Pilih kota';
                return null;
              },
            ),
            Gap(24.h),
            Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: cs.primary.withValues(alpha: 0.12)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18.r,
                    color: cs.primary,
                  ),
                  Gap(10.w),
                  Expanded(
                    child: Text(
                      'Data lokasi digunakan untuk rekomendasi layanan dan konten di daerahmu.',
                      style: tt.bodySmall?.copyWith(
                        color: cs.primary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(16.h),
          ],
        ),
      ),
    );
  }
}
