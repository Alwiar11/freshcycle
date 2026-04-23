class RecipeModel {
  final String id;
  final String title;
  final String description;
  final int cookingMinutes;
  final List<String> expiringIngredients;
  final List<String> otherIngredients;
  final String emoji;

  const RecipeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.cookingMinutes,
    required this.expiringIngredients,
    required this.otherIngredients,
    required this.emoji,
  });
}
