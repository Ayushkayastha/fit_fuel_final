// lib/features/home/step_counter/data/step_counter_repository_impl.dart

import 'package:pedometer/pedometer.dart';
import '../domain/step_counter_repository.dart';
import 'step_counter_local_data_source.dart';

class StepCounterRepositoryImpl implements StepCounterRepository {
  final StepCounterLocalDataSource localDataSource;

  /// The raw sensor value at the start of the current day’s session.
  int? _initialRawStepsForToday;

  /// The previously‐saved total for the current date (loaded from Hive once).
  int _previousTotalForToday = 0;

  /// The ISO date string (e.g. "2025-06-09") of the last processed event.
  String? _lastProcessedDateKey;

  StepCounterRepositoryImpl({required this.localDataSource}) {
    // Nothing to do in constructor; we will load per‐day values lazily on first event.
  }

  @override
  Stream<int> getStepCountStream() async* {
    await for (final event in Pedometer.stepCountStream) {
      // 1) Format the event's timestamp into "yyyy-MM-dd"
      final eventDate = event.timeStamp.toLocal();
      final dateKey = _formatDateKey(eventDate);

      // 2) If this is the first event ever, or the date has changed since last event:
      if (_lastProcessedDateKey == null || _lastProcessedDateKey != dateKey) {
        // a) New day (or first ever event): set raw offset to current event.steps
        _initialRawStepsForToday = event.steps;

        // b) Load whatever was stored in Hive for this date (0 if none)
        _previousTotalForToday = await localDataSource.getStoredSteps(dateKey);

        // c) Remember the current dateKey
        _lastProcessedDateKey = dateKey;
      }

      // 3) Now that _initialRawStepsForToday and _previousTotalForToday are set,
      //    compute how many steps since midnight (or since first event of this date).
      final rawOffset = _initialRawStepsForToday!;
      final stepsSinceOffset = event.steps - rawOffset;

      // 4) New total for this date = previously‐saved + stepsSinceOffset
      final newTotalForToday = _previousTotalForToday + stepsSinceOffset;

      // ▼ 5) Persist `newTotalForToday` under key = dateKey
      await localDataSource.storeSteps(dateKey, newTotalForToday);
      // ▲

      // 6) Yield it so the UI can display “Steps Today: newTotalForToday”
      yield newTotalForToday;
    }
  }

  @override
  Future<bool> requestPermission() async {
    // iOS: Pedometer.stepCountStream shows a dialog automatically.
    // Android: you might need ACTIVITY_RECOGNITION. For now, return true.
    return true;
  }

  String _formatDateKey(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}