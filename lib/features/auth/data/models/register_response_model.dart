class RegisterResponseModel {
  final String message;
  final String userId;
  final String name;
  final String email;

  RegisterResponseModel({
    required this.message,
    required this.userId,
    required this.name,
    required this.email,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      message: json['message'],
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
    );
  }
}
