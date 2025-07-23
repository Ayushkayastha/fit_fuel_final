// repository/user_repository.dart
import 'package:dio/dio.dart';
import 'package:fit_fuel_final/features/home/step_counter/domain/user_info_model.dart';

import '../../../../config/network/dio_client.dart';


class UserRepository {
  final Dio _dio = DioClient.client;

  Future<UserModel> getUser(String userId) async {
    final response = await _dio.get('Users/$userId');
    return UserModel.fromJson(response.data);
  }
}
