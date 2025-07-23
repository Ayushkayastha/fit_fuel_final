import '../models/register_request_model.dart';
import '../models/register_response_model.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<RegisterResponseModel> registerUser(RegisterRequestModel request);

}
