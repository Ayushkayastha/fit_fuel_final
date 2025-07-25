// lib/features/steps/presentation/provider/step_entry_provider.dart

import 'package:fit_fuel_final/features/calorie/presentation/provider/step_burn_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';
import '../../../../config/storage/secure_storage_providers.dart';
import '../../domain/step_calorie_summary.dart';
import 'date_provider.dart';

part 'step_burn_provider.g.dart';

@riverpod
Future<StepEntry> stepEntry(Ref ref) async {
  // 1. read dateProvider, format to yyyy-MM-dd
  final date = ref.watch(dateProvider);
  final formatted = DateFormat('yyyy-MM-dd').format(date);

  // 2. get current userId from secure storage
  final userId = await ref.watch(userIdProvider.future);
  if (userId == null) throw Exception('User ID not found');

  // 3. fetch from network
  final svc = StepEntryService();
  return svc.fetchStepEntry(userId, formatted);
}
