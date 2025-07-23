// providers/user_repository_provider.dart
import 'package:fit_fuel_final/features/home/step_counter/domain/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});
