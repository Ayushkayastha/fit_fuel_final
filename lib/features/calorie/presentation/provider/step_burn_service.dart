// lib/features/steps/data/step_entry_service.dart

import 'package:dio/dio.dart';
import '../../../../config/network/dio_client.dart';
import '../../domain/step_calorie_summary.dart';

class StepEntryService {
  final Dio _dio = DioClient.client;

  /// GET https://…/api/stepentry/user/{userId}?date={yyyy-MM-dd}
  Future<StepEntry> fetchStepEntry(String userId, String date) async {
    try {
      final response = await _dio.get(
        'stepentry/user/$userId',
        queryParameters: {'date': date},
      );

      if (response.statusCode == 200) {
        return StepEntry.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load step entry (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error fetching step entry: $e');
    }
  }
}
