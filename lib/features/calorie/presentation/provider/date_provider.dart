import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateNotifier extends StateNotifier<DateTime> {
  DateNotifier() : super(_todayWithoutTime());

  static DateTime _todayWithoutTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  void nextDay() {
    state = DateTime(state.year, state.month, state.day + 1);
  }

  void previousDay() {
    state = DateTime(state.year, state.month, state.day - 1);
  }

  void setDate(DateTime newDate) {
    state = DateTime(newDate.year, newDate.month, newDate.day);
  }
}

final dateProvider = StateNotifierProvider<DateNotifier, DateTime>((ref) {
  return DateNotifier();
});
