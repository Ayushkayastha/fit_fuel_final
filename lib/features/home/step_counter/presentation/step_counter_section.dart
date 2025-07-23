
import 'package:fit_fuel_final/features/home/step_counter/presentation/step_calorie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/user_provider.dart';
import 'step_counter_provider.dart';

class StepCounterSection extends ConsumerWidget {
  const StepCounterSection({super.key});
  double stepCalorieBurnt(
      double weight,
      int steps,
      )
  {
    double basalCalPerStep = 0.05 ;// kcal per step for a 70 kg person

    double calPerStep=basalCalPerStep*(weight/70);
    double caloriesBurnt=steps*calPerStep;
    return caloriesBurnt;
  }
  double bmr(
      double height,
      double weight,
      int steps,
      int age,
      String gender)
  {
    //Mifflin–St Jeor equation
    if(gender=='male'){
      final bmr= ((10*weight)+(6.25*height)-(5*age)+5);
      return bmr;
    }
    else{
      final bmr= ((10*weight)+(6.25*height)-(5*age)-161);
      return bmr;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionAsync = ref.watch(stepPermissionProvider);
    final userAsync = ref.watch(userProvider);
    double bmrValue=0.0;
    double calValue=0.0;

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
                userAsync.when(
                  data: (user) {
                    final double height = double.tryParse(user.heightCm as String) ?? 0.0;
                    final double weight = double.tryParse(user.weightKg as String) ?? 0.0;
                    final int age = int.tryParse(user.age as String) ?? 0;
                    final String gender = user.gender;

                    bmrValue = bmr(height, weight, steps, age, gender);
                    calValue = stepCalorieBurnt(weight, steps);

                    ref.watch(stepCalorieProvider.notifier).state = calValue;

                    return _buildContainer("Steps Today: $steps");
                  },
                  loading: () => _buildContainer("Loading user..."),
                  error: (e, _) => _buildContainer("User error"),
                );


                ref.watch(stepCalorieProvider.notifier).state=calValue;
                return _buildContainer("Steps Today: $steps");
              },
              loading: () => _buildContainer("Loading steps..."),
              error: (e, _) => _buildContainer("Step count error"),
            );
          },
        ),

        Row(
          children: [
            Container(
              height: 56,
              width: 100,
              color: Colors.deepOrangeAccent,
              child: Text(
                  'BMR =${bmrValue}'
              ),
            ),
            Container(
              height: 56,
              width: 100,
              color: Colors.deepOrangeAccent,
              child: Text(
                  'cal =${calValue}'
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildContainer(String text) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}