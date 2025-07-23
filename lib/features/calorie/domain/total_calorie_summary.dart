class  TotalCalorieSummary {
  final String date;
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFats;
  final double totalFiber;

  TotalCalorieSummary({
    required this.date,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFats,
    required this.totalFiber,
  });

  factory  TotalCalorieSummary.fromJson(Map<String, dynamic> json) {
    return  TotalCalorieSummary(
      date: json['date'],
      totalCalories: (json['totalCalories'] as num).toDouble(),
      totalProtein: (json['totalProtein'] as num).toDouble(),
      totalCarbs: (json['totalCarbs'] as num).toDouble(),
      totalFats: (json['totalFats'] as num).toDouble(),
      totalFiber: (json['totalFiber'] as num).toDouble(),
    );
  }
}
