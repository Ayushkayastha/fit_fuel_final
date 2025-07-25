// lib/features/steps/domain/step_entry.dart

class StepEntry {
  final bool hasEntry;
  final DateTime date;
  final int stepCount;
  final double stepCaloriesBurnt;

  StepEntry({
    required this.hasEntry,
    required this.date,
    required this.stepCount,
    required this.stepCaloriesBurnt,
  });

  factory StepEntry.fromJson(Map<String, dynamic> json) {
    return StepEntry(
      hasEntry: json['hasEntry'] as bool? ?? false,
      date: DateTime.parse(json['date'] as String? ?? ''),
      stepCount: (json['stepCount'] as num?)?.toInt() ?? 0,
      stepCaloriesBurnt: (json['stepCaloriesBurnt'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
