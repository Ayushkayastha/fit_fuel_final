// lib/features/home/step_counter/presentation/step_counter_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/step_counter_local_data_source.dart';
import '../data/step_counter_repository_impl.dart';
import '../domain/step_counter_repository.dart';

/// PROVIDER: the Hive‐backed LocalDataSource for storing per‐day totals
final stepCounterLocalDataSourceProvider =
Provider<StepCounterLocalDataSource>((ref) {
  return StepCounterLocalDataSourceImpl();
});

/// PROVIDER: the repository (depends on the data source)
final stepCounterRepositoryProvider =
Provider<StepCounterRepository>((ref) {
  final dataSource = ref.watch(stepCounterLocalDataSourceProvider);
  return StepCounterRepositoryImpl(localDataSource: dataSource);
});

/// PROVIDER: to request permission (we just return true here)
final stepPermissionProvider = FutureProvider<bool>((ref) async {
  return ref.watch(stepCounterRepositoryProvider).requestPermission();
});

/// STREAMPROVIDER<int>: emits “steps today” for the current date
final stepCountProvider = StreamProvider<int>((ref) {
  return ref.watch(stepCounterRepositoryProvider).getStepCountStream();
});