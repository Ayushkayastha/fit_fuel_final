// user_model.dart
class CalorieEntry {
  final String entryId;
  final String foodItem;
  final double weightInGrams;
  final int meal;
  final DateTime entryTime;
  final double calories;
  final double protein;
  final double carbs;
  final double fats;
  final double fiber;

  CalorieEntry({
    required this.entryId,
    required this.foodItem,
    required this.weightInGrams,
    required this.meal,
    required this.entryTime,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.fiber,
  });

  factory CalorieEntry.fromJson(Map<String, dynamic> json) {
    return CalorieEntry(
      entryId: json['entryId'],
      foodItem: json['foodItem'],
      weightInGrams: (json['weightInGrams'] as num).toDouble(),
      meal: json['meal'],
      entryTime: DateTime.parse(json['entryTime']),
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      fiber: (json['fiber'] as num).toDouble(),
    );
  }
}

class UserModel {
  final String userId;
  final String name;
  final String email;
  final DateTime createdAt;
  final int age;
  final String gender;
  final double heightCm;
  final double weightKg;
  final double targetWeightKg;
  final String goal;
  final List<CalorieEntry> calorieEntries;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.age,
    required this.gender,
    required this.heightCm,
    required this.weightKg,
    required this.targetWeightKg,
    required this.goal,
    required this.calorieEntries,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      age: json['age'],
      gender: json['gender'],
      heightCm: (json['heightCm'] as num).toDouble(),
      weightKg: (json['weightKg'] as num).toDouble(),
      targetWeightKg: (json['targetWeightKg'] as num).toDouble(),
      goal: json['goal'],
      calorieEntries: (json['calorieEntries'] as List)
          .map((e) => CalorieEntry.fromJson(e))
          .toList(),
    );
  }
}
