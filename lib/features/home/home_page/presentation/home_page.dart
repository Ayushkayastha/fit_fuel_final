// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../analytics/screens/analytics_view.dart';
import '../../step_counter/presentation/step_counter_section.dart';
import '../../../../config/storage/secure_storage_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userIdAsync = ref.watch(userIdProvider);

    return Scaffold(
      body:  userIdAsync.when(
        data: (uid) {
          if (uid == null) {
            return const Center(child: Text('No user ID'));
          }
          return AnalyticsView(userId: uid);
        },
        loading: () =>
        const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
