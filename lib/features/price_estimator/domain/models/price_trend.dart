enum PriceTrend { up, down, stable }

class PriceItem {
  final String name;
  final String emoji;
  final int pricePerUnit;
  final String unit;
  final String category;
  final PriceTrend trend;
  final String note;

  const PriceItem({
    required this.name,
    required this.emoji,
    required this.pricePerUnit,
    required this.unit,
    required this.category,
    required this.trend,
    required this.note,
  });
}
