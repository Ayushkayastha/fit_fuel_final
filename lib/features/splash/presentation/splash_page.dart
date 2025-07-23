// features/splash/presentation/splash_page.dart
import 'package:fit_fuel_final/shared/pages/loader_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/app_setup/provider/auth_database_provider.dart';
import '../../../core/route/path.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initNavigation();
  }

  Future<void> _initNavigation() async {
    await Future.delayed(const Duration(seconds: 2));

    final hasCompletedOnboarding =
    await ref.read(authDatabaseProvider).getOnboardingStatus();

    if (!mounted) return;

    if (hasCompletedOnboarding) {
      context.go(PathName.authgateRoute.path);
    } else {
      context.go(PathName.onboardingPageRoute.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderPage(message: 'Welcome',);
  }
}
