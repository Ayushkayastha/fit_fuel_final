import 'package:dio/dio.dart';
import 'package:fit_fuel_final/features/auth/data/models/login_response_model.dart';
import 'package:fit_fuel_final/features/auth/data/models/login_request_model.dart';
import '../../../../config/network/dio_client.dart';
import '../../../../config/storage/secure_storage_service.dart';
import '../../data/models/register_request_model.dart';
import '../../data/models/register_response_model.dart';
import '../../data/repositories/auth_repository_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SecureStorageService _storage;

  AuthRepositoryImpl(this._storage);

  @override
  Future<void> login(String email, String password) async {
    final response = await DioClient.client.post(
      'auth/login',
      data: LoginRequestModel(email: email, password: password).toJson(),
    );

    final loginResponse = LoginResponseModel.fromJson(response.data);

    await _storage.saveAuthToken(loginResponse.token);
    await _storage.saveUserId(loginResponse.userId);
  }

  @override
  Future<void> logout() async {
    await _storage.clear();
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _storage.getAuthToken();
    return token != null;
  }
  final Dio _dio = DioClient.client;

  @override
  Future<RegisterResponseModel> registerUser(RegisterRequestModel request) async {
    try {
      final response = await _dio.post('auth/register', data: request.toJson());
      return RegisterResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }
}
