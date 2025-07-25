class NutritionGoal {
  final int caloriesKcal;
  final int proteinG;
  final int proteinKcal;
  final double proteinPctOfTotalKcal;
  final int fatG;
  final int fatKcal;
  final double fatPctOfTotalKcal;
  final int carbohydrateG;
  final int carbKcal;
  final double carbPctOfTotalKcal;
  final int totalKcalFromMacros;

  NutritionGoal({
    required this.caloriesKcal,
    required this.proteinG,
    required this.proteinKcal,
    required this.proteinPctOfTotalKcal,
    required this.fatG,
    required this.fatKcal,
    required this.fatPctOfTotalKcal,
    required this.carbohydrateG,
    required this.carbKcal,
    required this.carbPctOfTotalKcal,
    required this.totalKcalFromMacros,
  });

  factory NutritionGoal.fromJson(Map<String, dynamic> json) {
    return NutritionGoal(
      caloriesKcal: json['calories_kcal'],
      proteinG: json['protein_g'],
      proteinKcal: json['protein_kcal'],
      proteinPctOfTotalKcal: (json['protein_pct_of_total_kcal'] as num).toDouble(),
      fatG: json['fat_g'],
      fatKcal: json['fat_kcal'],
      fatPctOfTotalKcal: (json['fat_pct_of_total_kcal'] as num).toDouble(),
      carbohydrateG: json['carbohydrate_g'],
      carbKcal: json['carb_kcal'],
      carbPctOfTotalKcal: (json['carb_pct_of_total_kcal'] as num).toDouble(),
      totalKcalFromMacros: json['total_kcal_from_macros'],
    );
  }
}
