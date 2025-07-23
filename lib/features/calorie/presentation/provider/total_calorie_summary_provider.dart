import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../config/storage/secure_storage_providers.dart';
import '../../domain/total_calorie_service_provider.dart';
import '../../domain/total_calorie_summary.dart';
import 'date_provider.dart';



part 'total_calorie_summary_provider.g.dart';

@riverpod
Future<TotalCalorieSummary> calorieSummary(Ref ref) async {
  final date = ref.watch(dateProvider);
  final formattedDate = DateFormat('yyyy-MM-dd').format(date);

  final userId = await ref.watch(userIdProvider.future);

  if (userId == null) throw Exception('User ID not found');

  final service = CalorieSummaryService();
  return await service.fetchCalorieSummary(userId, formattedDate);
}
