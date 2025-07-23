import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'body_info_provider.g.dart';

@Riverpod(keepAlive: true) // 🔁 allows persistent + writable state
class Age extends _$Age {
  @override
  int build() => 23;

  void setAge(int newAge) => state = newAge;
}

@Riverpod(keepAlive: true)
class GenderSelection extends _$GenderSelection {
  @override
  String? build() => null;

  void select(String gender) => state = gender;
}

@Riverpod(keepAlive: true)
class GoalSelection extends _$GoalSelection {
  @override
  String? build() => null;

  void select(String gender) => state = gender;
}

enum HeightUnit { centimeter, feet, inch }

@Riverpod(keepAlive: true)
class HeightUnitSelection extends _$HeightUnitSelection {
  @override
  HeightUnit build() => HeightUnit.centimeter;

  void select(HeightUnit unit) => state = unit;
}

enum WeightUnit { kilogram,pound }

@Riverpod(keepAlive: true)
class WeightUnitSelection extends _$WeightUnitSelection {
  @override
  WeightUnit build() => WeightUnit.kilogram;

  void select(WeightUnit unit) => state = unit;
}

@Riverpod(keepAlive: true)
class GoalWeightUnitSelection extends _$GoalWeightUnitSelection {
  @override
  WeightUnit build() => WeightUnit.kilogram;

  void select(WeightUnit unit) => state = unit;
}