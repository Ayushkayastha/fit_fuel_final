import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/step_entry_provider.dart';
import '../domain/user_provider.dart';
import 'step_calorie_provider.dart';
import 'step_counter_provider.dart';

class StepCounterSection extends ConsumerWidget {
  const StepCounterSection({super.key});

  double stepCalorieBurnt(double weight, int steps) {
    double basalCalPerStep = 0.05;
    double calPerStep = basalCalPerStep * (weight / 70);
    return steps * calPerStep;
  }

  double bmr(double height, double weight, int age, String gender) {
    if (gender.toLowerCase() == 'male') {
      return (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      return (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionAsync = ref.watch(stepPermissionProvider);
    final userAsync = ref.watch(userProvider);

    return Column(
      children: [
        permissionAsync.when(
          loading: () => _buildContainer("Checking permission..."),
          error: (e, _) => _buildContainer("Permission error"),
          data: (granted) {
            if (!granted) {
              return _buildContainer("Permission denied");
            }

            final stepAsync = ref.watch(stepCountProvider);

            return stepAsync.when(
              data: (steps) {
                final entryAsync = ref.watch(stepEntryProvider(steps));
                ref.listen<AsyncValue<void>>(
                  stepEntryProvider(steps),
                      (prev, next) {
                    next.when(
                      data: (_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Steps saved successfully!"))
                        );
                      },
                      loading: () {},
                      error: (err, _) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error saving steps: $err"))
                        );
                      },
                    );
                  },
                );

                // Default values
                double height = 170;
                double weight = 65;
                int age = 25;
                String gender = 'male';

                if (userAsync is AsyncData) {
                  final user = userAsync.value;
                  height = user?.heightCm ?? height;
                  weight = user?.weightKg ?? weight;
                  age = user?.age ?? age;
                  gender = user?.gender ?? gender;
                }

                final bmrValue = bmr(height, weight, age, gender);
                final calValue = stepCalorieBurnt(weight, steps);

                // Update state safely after build
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(stepCalorieProvider.notifier).state = calValue;
                });

                return Column(
                  children: [
                    _buildContainer("Steps Today: $steps"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildMetricContainer("BMR", bmrValue.toStringAsFixed(2)),
                        const SizedBox(width: 8),
                        _buildMetricContainer("Calories", calValue.toStringAsFixed(2)),
                      ],
                    ),
                  ],
                );
              },
              loading: () => _buildContainer("Loading steps..."),
              error: (e, _) => _buildContainer("Step count error: $e"),
            );
          },
        ),
      ],
    );
  }
  Widget _buildContainer(String text) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFB77B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFB8C00),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }


  Widget _buildMetricContainer(String label, String value) {
    return Container(
      height: 56,
      width: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFFB8C00),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text("$label = $value", style: const TextStyle(color: Colors.white)),
    );
  }
}
