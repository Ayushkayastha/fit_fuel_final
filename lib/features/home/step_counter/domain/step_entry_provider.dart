import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../config/network/dio_client.dart';
import '../../../../config/storage/secure_storage_providers.dart';
import '../../../calorie/presentation/provider/date_provider.dart';

part 'step_entry_provider.g.dart';
/// A FutureProvider.family that posts a StepEntry whenever you `watch` it.
@riverpod
Future<void> stepEntry(Ref ref, int steps) async {
  // 1. get the userId from secure storage
  final userId = await ref.watch(userIdProvider.future);
  if (userId == null) {
    throw Exception("No userId found in secure storage");
  }

  // 2. get the currently selected date
  final date = ref.read(dateProvider);
  final formatted = DateFormat('yyyy-MM-dd').format(date);

  // 3. perform the POST
  final response = await DioClient.client.post(
    'StepEntry',
    data: {
      "userId": userId,
      "date": formatted,
      "stepCount": steps,
    },
  );

  // 4. check for non‑200
  if (response.statusCode != 200) {
    throw Exception("Failed to save step entry: ${response.statusCode}");
  }
}
