import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/network/dio_client.dart';
import '../../../../config/storage/secure_storage_providers.dart';
import '../../domain/nutrition_goal.dart';


final nutritionGoalProvider = FutureProvider<NutritionGoal?>((ref) async {
  final userId = await ref.watch(userIdProvider.future);
  if (userId == null) return null;

  final response = await DioClient.client.post('Nutrition/generate-nutrition-goal/$userId');

  if (response.statusCode == 200) {
    return NutritionGoal.fromJson(response.data);
  } else {
    throw Exception('Failed to load nutrition goal');
  }
});
