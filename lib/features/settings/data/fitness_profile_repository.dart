import 'package:dio/dio.dart';
import '../../../../config/network/dio_client.dart';
import '../domain/fitness_profile_model.dart';

class FitnessProfileRepository {
  final Dio _dio = DioClient.client;

  Future<FitnessProfile> getFitnessProfile(String userId) async {
    final response = await _dio.get('Users/$userId/fitness-profile');
    return FitnessProfile.fromJson(response.data);
  }
}
