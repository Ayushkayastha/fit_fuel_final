// core/app_setup/auth_gate.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/domain/provider/auth_state_provider.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/landing/presentation/landing_page.dart';
import '../../features/onboarding_user_info/presentation/pages/age_page.dart';
import 'provider/auth_database_provider.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authStateProvider);

    return authAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Auth error: $e'))),
      data: (isLoggedIn) {
        if (isLoggedIn==false) {
          return const LoginPage();
        }

        final onboardingAsync = ref.watch(onboardingUserInfotatusProvider);
        return onboardingAsync.when(
          loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (e, _) => Scaffold(body: Center(child: Text('Onboarding error: $e'))),
          data: (didOnboard) {
            return didOnboard ? const LandingPage() : const AgePage();
          },
        );
      },
    );
  }
}
