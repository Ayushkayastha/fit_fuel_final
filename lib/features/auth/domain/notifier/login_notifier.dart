import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_fuel_final/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../provider/auth_repository_provider.dart';

part 'login_notifier.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  FutureOr<void> build() {}

  Future<bool> loginWithEmailPassword(String email, String password) async {
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.login(email, password);
      return true;
    } catch (e) {
      return false;
    }
  }
}
