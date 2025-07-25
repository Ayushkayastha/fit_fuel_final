import 'package:dio/dio.dart';

import '../../../config/network/dio_client.dart';

class OnboardingService {
  static Future<void> completeProfile({
    required String userId,
    required int age,
    required String gender,
    required double heightCm,
    required double weightKg,
    required double targetWeightKg,
    required String goal,
  }) async {
    final data = {
      "age": age,
      "gender": gender,
      "heightCm": heightCm,
      "weightKg": weightKg,
      "targetWeightKg": targetWeightKg,
      "goal": goal,
    };

    await DioClient.client.put(
      'users/$userId/complete-profile',
      data: data,
    );
  }
}
