// providers/user_provider.dart
import 'package:fit_fuel_final/features/home/step_counter/domain/user_info_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/storage/secure_storage_providers.dart';

import 'user_repository_provider.dart';

final userProvider = FutureProvider<UserModel>((ref) async {
  final userId = await ref.watch(userIdProvider.future);

  if (userId == null) {
    throw Exception('User ID not found in secure storage');
  }

  final repository = ref.watch(userRepositoryProvider);
  return await repository.getUser(userId);
});
