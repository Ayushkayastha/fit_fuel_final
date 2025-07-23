import 'package:dio/dio.dart' as dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../config/network/dio_client.dart';

class CalorieEntryService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> logCalorieEntry({
    required String foodItem,
    required int weightInGrams,
    required int meal,
  }) async {
    final token = await _storage.read(key: 'auth_token');
    final userId = await _storage.read(key: 'user_id');

    if (token == null || userId == null) {
      throw Exception('Missing auth token or user ID');
    }

    final body = {
      'userId': userId,
      'foodItem': foodItem,
      'weightInGrams': weightInGrams,
      'meal': meal,
    };

    try {
      final response = await DioClient.client.post(
        'CalorieEntries',
        data: body,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('❌ Error posting calorie entry: $e');
      return false;
    }
  }
}
