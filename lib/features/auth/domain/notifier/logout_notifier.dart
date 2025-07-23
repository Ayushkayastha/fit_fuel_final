import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_fuel_final/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../provider/auth_repository_provider.dart';

part 'logout_notifier.g.dart';

@riverpod
class LogoutNotifier extends _$LogoutNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> logout() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.logout();
  }
}
