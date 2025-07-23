import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_providers.g.dart';

final _storage = const FlutterSecureStorage();

@riverpod
Future<String?> authToken(Ref ref) async {
  return await _storage.read(key: 'auth_token');
}

@riverpod
Future<String?> userId(UserIdRef ref) async {
  return await _storage.read(key: 'user_id');
}
