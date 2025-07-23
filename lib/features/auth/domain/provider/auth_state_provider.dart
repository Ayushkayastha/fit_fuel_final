import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fit_fuel_final/features/auth/domain/repositories/auth_repository.dart';
import 'auth_repository_provider.dart';

part 'auth_state_provider.g.dart';

@riverpod
Future<bool> authState(Ref ref) async {
  final repo = ref.watch(authRepositoryProvider);
  return await repo.isLoggedIn();
}
