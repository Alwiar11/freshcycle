import 'package:flutter/material.dart';

class InventoryItem {
  final String name;
  final String category;
  final double quantity;
  final String unit;
  final DateTime entryDate;
  final DateTime expiryDate;

  const InventoryItem({
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    required this.entryDate,
    required this.expiryDate,
  });

  // ── Computed Fields ──────────────────────────────────────
  int get daysLeft => expiryDate.difference(DateTime.now()).inDays;
  int get maxDays => expiryDate.difference(entryDate).inDays;
  double get progress => (daysLeft / maxDays).clamp(0.0, 1.0);

  String get status {
    if (daysLeft <= 0) return 'expired';
    if (daysLeft <= 2) return 'warn';
    return 'fresh';
  }

  String get label {
    if (daysLeft <= 0) return 'Kedaluwarsa';
    if (daysLeft <= 2) return 'Segera Gunakan';
    return 'Segar';
  }

  String get emoji {
    const map = {
      'Sayuran': '🥦',
      'Sayuran Hijau': '🥦',
      'Buah': '🍎',
      'Protein': '🍗',
      'Dairy': '🥛',
      'Bumbu': '🧄',
      'Lainnya': '🛒',
    };
    return map[category] ?? '🛒';
  }

  Color get bgColor {
    if (status == 'expired') return const Color(0xFFFFEBEB);
    if (status == 'warn') return const Color(0xFFFFF3E0);
    return const Color(0xFFEAF3DE);
  }
}
