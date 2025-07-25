class FitnessProfile {
  final String fitnessLevel;
  final int availability;
  final String equipment;
  final String activityLevel;

  FitnessProfile({
    required this.fitnessLevel,
    required this.availability,
    required this.equipment,
    required this.activityLevel,
  });

  factory FitnessProfile.fromJson(Map<String, dynamic> json) {
    return FitnessProfile(
      fitnessLevel: json['fitnessLevel'],
      availability: json['availability'],
      equipment: json['equipment'],
      activityLevel: json['activityLevel'],
    );
  }
}
