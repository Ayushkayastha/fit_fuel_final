import 'package:drift/drift.dart';

class AuthTable extends Table{
  IntColumn get id =>integer().clientDefault(() => 1)();
  BoolColumn get onboardingUserInfoComplete => boolean().withDefault(const Constant(false))();
  BoolColumn get onboardingComplete => boolean().withDefault(const Constant(false))();
}