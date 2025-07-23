import 'package:fit_fuel_final/features/calorie/presentation/calorie_page.dart';
import 'package:fit_fuel_final/features/landing/presentation/provider/nav_bar_provider.dart';
import 'package:fit_fuel_final/features/settings/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {

  final _pages = [
    Center(child: Text('Home Page')),
    CaloriePage(),
    Center(child: Text('Workout Page')),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavBarIndexProvider);

    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (i) {
            final icons = [Icons.home, Icons.local_fire_department_outlined,Icons.fitness_center ,Icons.settings];
            final labels = ['Home', 'Calorie','Workout', 'Settings'];
            final isActive = i == currentIndex;

            return GestureDetector(
              onTap: () {
                // update via the provider’s notifier
                ref
                    .read(bottomNavBarIndexProvider.notifier)
                    .setIndex(i);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icons[i],
                    size: isActive ? 28 : 24,
                    color: isActive
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                  SizedBox(height: 4),
                  Text(
                    labels[i],
                    style: TextStyle(
                      fontSize: 12,
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
