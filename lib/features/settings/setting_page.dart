import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/route/path.dart';
import '../auth/domain/notifier/logout_notifier.dart';
import '../auth/domain/provider/auth_state_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await ref.read(logoutNotifierProvider.notifier).logout();
            if (context.mounted) {
              ref.invalidate(authStateProvider);
              context.go(PathName.authgateRoute.path); // Or PathName.loginPageRoute.path
            }
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
