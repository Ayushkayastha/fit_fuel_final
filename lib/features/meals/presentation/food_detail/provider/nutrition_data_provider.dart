import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/nutrition_data_repository.dart';
import '../../../domain/nutrition_data_model.dart';
final nutritionRepositoryProvider = Provider((ref) => NutritionRepository());

final foodItemProvider = StateProvider<String>((ref) => 'banana');
final weightProvider = StateProvider<double>((ref) => 100);

final nutritionProvider = FutureProvider<NutritionData>((ref) async {
  final repo = ref.read(nutritionRepositoryProvider);
  final food = ref.watch(foodItemProvider);
  final weight = ref.watch(weightProvider);
  return repo.fetchNutrition(food, weight);
});
