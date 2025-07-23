

import 'package:fit_fuel_final/features/calorie/domain/total_calorie_summary.dart';

import '../../../config/network/dio_client.dart';

class CalorieSummaryService {
  final dio = DioClient.client;

  Future<TotalCalorieSummary> fetchCalorieSummary(String userId, String date) async {
    try {
      final response = await dio.get(
        'CalorieEntries/summary/total/$userId',
        queryParameters: {'date': date},
      );

      if (response.statusCode == 200) {
        return TotalCalorieSummary.fromJson(response.data);
      } else {
        throw Exception('Failed to load summary');
      }
    } catch (e) {
      throw Exception('Error fetching summary: $e');
    }
  }
}
