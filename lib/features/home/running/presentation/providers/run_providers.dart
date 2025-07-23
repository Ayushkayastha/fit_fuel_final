// lib/features/home/running/presentation/providers/run_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/data_sources/run_location_service.dart';
import '../../data/repositories/run_repository_impl.dart';
import '../../domain/entities/run_data.dart';

/// 1) The low‑level location service
final runLocationServiceProvider = Provider<RunLocationService>((ref) {
  return RunLocationService();
});

/// 2) The repository that accumulates distance/time/speed
final runRepositoryProvider = Provider<RunRepositoryImpl>((ref) {
  final svc = ref.read(runLocationServiceProvider);
  return RunRepositoryImpl(svc);
});

/// 3) Expose the live RunData stream to your UI
final runDataStreamProvider = StreamProvider<RunData>((ref) {
  return ref.read(runRepositoryProvider).stream;
});

/// 4) A flag for whether we’re currently running
final isRunningProvider = StateProvider<bool>((ref) => false);

/// 5) A simple controller with start/stop methods
class RunController {
  final Ref _ref;
  RunController(this._ref);

  Future<void> start() async {
    // initialize & start emitting
    await _ref.read(runRepositoryProvider).start();
    _ref.read(isRunningProvider.notifier).state = true;
  }

  Future<void> stop() async {
    await _ref.read(runRepositoryProvider).stop();
    _ref.read(isRunningProvider.notifier).state = false;
  }
}

/// 6) Expose the controller so UI can call start/stop
final runControllerProvider = Provider<RunController>((ref) {
  return RunController(ref);
});
