import 'package:flutter_riverpod/legacy.dart';

enum RecipeAiState { idle, loading, result }

final recipeAiStateProvider = StateProvider<RecipeAiState>(
  (_) => RecipeAiState.idle,
);
