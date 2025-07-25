import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/storage/secure_storage_providers.dart';
import 'fitness_profile_model.dart';
import 'fitness_profile_repository_provider.dart';

final fitnessProfileProvider = FutureProvider<FitnessProfile>((ref) async {
  final userId = await ref.watch(userIdProvider.future);
  if (userId == null) {
    throw Exception("User ID not found");
  }

  final repo = ref.watch(fitnessProfileRepositoryProvider);
  return await repo.getFitnessProfile(userId);
});
