import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/auth_database.dart';

part 'auth_database_provider.g.dart';

@riverpod
AuthDatabase authDatabase(Ref ref){
final db = AuthDatabase();
ref.onDispose(db.close);
return db;
}

@riverpod
Stream<bool> onboardingUserInfotatus(Ref ref){
  final db = ref.read(authDatabaseProvider);
  return db.watchOnboardingUserInfoStatus();
}

@riverpod
Future<bool> onboardingStatus(Ref ref) async {
  final db = ref.watch(authDatabaseProvider);
  return await db.getOnboardingStatus();
}