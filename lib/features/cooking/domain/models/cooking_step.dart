import 'package:freshcycle/features/cooking/domain/models/cooking_ingredient.dart';

class CookingStep {
  final String instruction;
  final int? durationMinutes;
  final List<CookingIngredient> ingredients;

  const CookingStep({
    required this.instruction,
    this.durationMinutes,
    required this.ingredients,
  });
}
