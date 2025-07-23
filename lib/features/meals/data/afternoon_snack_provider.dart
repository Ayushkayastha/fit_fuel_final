import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/network/dio_client.dart';
import '../../../config/storage/secure_storage_providers.dart';
import '../../calorie/presentation/provider/date_provider.dart';

final afternoonSnackProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final userId = await ref.watch(userIdProvider.future);
    final selectedDate = ref.watch(dateProvider);
    final today = selectedDate.toIso8601String().split('T').first;

    print('Fetching afternoonSnack for userId: $userId, date: $today'); // Debug log

    final dio = DioClient.client;

    final response = await dio.get(
      'CalorieEntries/summary/$userId',
      queryParameters: {'date': today},
    );

    if (response.statusCode == 200) {
      final data = response.data as List;

      final afternoonSnack = data.firstWhere(
            (entry) => entry['mealType'] == 'AfternoonSnack',
        orElse: () => null,
      );

      if (afternoonSnack != null) {
        final entries = afternoonSnack['entries'] as List;
        print('Found ${entries.length} afternoonSnack entries'); // Debug log
        return entries;
      } else {
        print('No afternoonSnack entries found'); // Debug log
        return [];
      }
    } else {
      print('API request failed with status: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error fetching afternoonSnack data: $e');
    return [];
  }
});