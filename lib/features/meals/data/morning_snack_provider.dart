import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/network/dio_client.dart';
import '../../../config/storage/secure_storage_providers.dart';
import '../../calorie/presentation/provider/date_provider.dart';

final morningSnackProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final userId = await ref.watch(userIdProvider.future);
    final selectedDate = ref.watch(dateProvider);
    final today = selectedDate.toIso8601String().split('T').first;

    print('Fetching morningSnack for userId: $userId, date: $today'); // Debug log

    final dio = DioClient.client;

    final response = await dio.get(
      'CalorieEntries/summary/$userId',
      queryParameters: {'date': today},
    );

    if (response.statusCode == 200) {
      final data = response.data as List;

      final morningSnack = data.firstWhere(
            (entry) => entry['mealType'] == 'MorningSnack',
        orElse: () => null,
      );

      if (morningSnack != null) {
        final entries = morningSnack['entries'] as List;
        print('Found ${entries.length} morningSnack entries'); // Debug log
        return entries;
      } else {
        print('No morningSnack entries found'); // Debug log
        return [];
      }
    } else {
      print('API request failed with status: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error fetching morningSnack data: $e');
    return [];
  }
});