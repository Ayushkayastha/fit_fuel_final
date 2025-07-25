import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/fitness_profile_repository.dart';

final fitnessProfileRepositoryProvider = Provider<FitnessProfileRepository>((ref) {
  return FitnessProfileRepository();
});
