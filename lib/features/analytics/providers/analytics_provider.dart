import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/macro_entry_model.dart';
import '../models/step_entry_model.dart';
import '../services/api_service.dart';

class AnalyticsState {
  final List<MacroEntry>? macroData;
  final List<StepEntry> stepData;
  final bool isLoading;
  final String? error;

  AnalyticsState({
    this.macroData,
    this.stepData = const [],
    this.isLoading = true,
    this.error,
  });

  AnalyticsState copyWith({
    List<MacroEntry>? macroData,
    List<StepEntry>? stepData,
    bool? isLoading,
    String? error,
  }) {
    return AnalyticsState(
      macroData: macroData ?? this.macroData,
      stepData: stepData ?? this.stepData,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AnalyticsNotifier extends StateNotifier<AnalyticsState> {
  AnalyticsNotifier() : super(AnalyticsState());

  Future<void> loadData(String userId, String date) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final macroData = await ApiService.fetchMacroBreakdown(userId, date);
      final stepData = await ApiService.fetchLast7DaysSteps(userId);

      state = AnalyticsState(
        macroData: macroData,
        stepData: stepData,
        isLoading: false,
      );
    } catch (e) {
      // Show the exception message (ApiException or other)
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load analytics data: $e',
      );
    }
  }

  void clear() {
    state = AnalyticsState(isLoading: false);
  }
}

final analyticsProvider = StateNotifierProvider<AnalyticsNotifier, AnalyticsState>(
      (ref) => AnalyticsNotifier(),
);
