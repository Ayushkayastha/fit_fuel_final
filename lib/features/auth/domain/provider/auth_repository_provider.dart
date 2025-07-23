import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fit_fuel_final/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fit_fuel_final/features/auth/domain/repositories/auth_repository.dart';

import '../../../../config/storage/secure_storage_service.dart';

part 'auth_repository_provider.g.dart';

@riverpod
SecureStorageService secureStorageService(Ref ref) => SecureStorageService();

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(secureStorageServiceProvider));
}
