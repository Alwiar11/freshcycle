class RecipeModel {
  final String id;
  final String title;
  final String description;
  final int cookingMinutes;
  final int servings;
  final List<String> expiringIngredients;
  final List<String> otherIngredients;
  final List<String> steps;
  final String emoji;

  const RecipeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.cookingMinutes,
    this.servings = 2,
    required this.expiringIngredients,
    required this.otherIngredients,
    required this.steps,
    required this.emoji,
  });
}
