class NutritionData {
  final double calories;
  final double protein;
  final double carbs;
  final double fats;
  final double fiber;

  NutritionData({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.fiber,
  });

  factory NutritionData.fromJson(Map<String, dynamic> json) {
    return NutritionData(
      calories: json['calories'].toDouble(),
      protein: json['protein'].toDouble(),
      carbs: json['carbs'].toDouble(),
      fats: json['fats'].toDouble(),
      fiber: json['fiber'].toDouble(),
    );
  }
}
