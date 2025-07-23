// lib/features/home/step_counter/data/step_counter_local_data_source.dart
import 'package:hive/hive.dart';

abstract class StepCounterLocalDataSource {
  /// Returns the stored total for [dateKey] (e.g. "2025-06-09").
  /// If none exists yet, returns 0.
  Future<int> getStoredSteps(String dateKey);

  /// Persists [steps] under [dateKey].
  Future<void> storeSteps(String dateKey, int steps);
}

class StepCounterLocalDataSourceImpl implements StepCounterLocalDataSource {
  // The Hive box name
  static const String boxName = 'dailyStepsBox';

  // Convenience getter
  Box<int> get _box => Hive.box<int>(boxName);

  @override
  Future<int> getStoredSteps(String dateKey) async {
    return _box.get(dateKey, defaultValue: 0)!;
  }

  @override
  Future<void> storeSteps(String dateKey, int steps) async {
    await _box.put(dateKey, steps);
  }
}