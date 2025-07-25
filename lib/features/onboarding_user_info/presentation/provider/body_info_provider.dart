import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'body_info_provider.g.dart';

// Age provider
@Riverpod(keepAlive: true)
class Age extends _$Age {
  @override
  int build() => 23;
  void setAge(int newAge) => state = newAge;
}

// Gender provider
@Riverpod(keepAlive: true)
class GenderSelection extends _$GenderSelection {
  @override
  String? build() => null;
  void select(String gender) => state = gender;
}

// Goal provider
@Riverpod(keepAlive: true)
class GoalSelection extends _$GoalSelection {
  @override
  String? build() => null;
  void select(String goal) => state = goal;
}

// Height unit
enum HeightUnit { centimeter, feet, inch }

@Riverpod(keepAlive: true)
class HeightUnitSelection extends _$HeightUnitSelection {
  @override
  HeightUnit build() => HeightUnit.centimeter;
  void select(HeightUnit unit) => state = unit;
}

// Weight unit
enum WeightUnit { kilogram, pound }

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

// Add these HERE
@Riverpod(keepAlive: true)
class HeightValue extends _$HeightValue {
  @override
  double build() => 175;
  void set(double val) => state = val;
}

@Riverpod(keepAlive: true)
class WeightValue extends _$WeightValue {
  @override
  double build() => 70;
  void set(double val) => state = val;
}

@Riverpod(keepAlive: true)
class GoalWeightValue extends _$GoalWeightValue {
  @override
  double build() => 65;
  void set(double val) => state = val;
}
