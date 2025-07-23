import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'auth_table.dart';


part 'auth_database.g.dart';


LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'auth_database.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables:[AuthTable])
class AuthDatabase extends _$AuthDatabase{
  AuthDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<bool> getOnboardingUserInfoStatus() async {
    final row = await (select(authTable)
      ..limit(1)
    ).getSingleOrNull();
    return row?.onboardingUserInfoComplete ?? false;
  }

  Stream<bool> watchOnboardingUserInfoStatus() {
    return select(authTable)
        .watchSingleOrNull()
        .map((row) => row?.onboardingUserInfoComplete ?? false);
  }
  Future<void> setOnboardingUserInfoComplete() async {
    final updated = await (update(authTable)
      ..where((t) => t.id.equals(1)))
        .write(
      AuthTableCompanion(onboardingUserInfoComplete: Value(true)),
    );

    if (updated == 0) {
      await into(authTable).insert(
        AuthTableCompanion(onboardingUserInfoComplete: const Value(true)),
      );
    }
  }

  Future<bool> getOnboardingStatus() async {
    final row = await (select(authTable)..limit(1)).getSingleOrNull();
    return row?.onboardingComplete ?? false;
  }

  Future<void> setOnboardingComplete() async {
    // Try to update row with id = 1:
    final updated = await (update(authTable)
      ..where((t) => t.id.equals(1)))
        .write(AuthTableCompanion(onboardingComplete: Value(true)));

    // If nothing was updated, insert it (id defaults to 1):
    if (updated == 0) {
      await into(authTable).insert(
        AuthTableCompanion(onboardingComplete: const Value(true)),
      );
    }
  }





}