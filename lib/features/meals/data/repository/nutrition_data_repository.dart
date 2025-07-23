import '../../../../config/network/dio_client.dart';
import '../../domain/nutrition_data_model.dart';


class NutritionRepository {
  Future<NutritionData> fetchNutrition(String foodItem, double weight) async {
    final response = await DioClient.client.get(
      'CalorieEntries/check-nutrition',
      queryParameters: {
        'foodItem': foodItem,
        'weight': weight,
      },
    );
    return NutritionData.fromJson(response.data['nutrition']);
  }
}
