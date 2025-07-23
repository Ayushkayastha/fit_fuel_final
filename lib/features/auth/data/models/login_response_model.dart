class LoginResponseModel {
  final String message;
  final String userId;
  final String token;

  LoginResponseModel({
    required this.message,
    required this.userId,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'] ?? 'Login success',
      userId: json['userId'] ?? json['id'],
      token: json['token'] ?? json['accessToken'],
    );
  }
}
