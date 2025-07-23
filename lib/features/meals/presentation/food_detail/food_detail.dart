import 'package:fit_fuel_final/core/route/path.dart';
import 'package:fit_fuel_final/features/meals/presentation/food_detail/provider/nutrition_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/storage/secure_storage_providers.dart';
import '../../domain/calorie_entry_service.dart';


class FoodDetailPage extends ConsumerStatefulWidget {
  final String food;
  final String mealType;

  const FoodDetailPage({
    super.key,
    required this.food,
    required this.mealType,
  });

  @override
  ConsumerState<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends ConsumerState<FoodDetailPage> {
  late TextEditingController weightController;
  String? userId;
  final _calorieService = CalorieEntryService();


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(foodItemProvider.notifier).state = widget.food;
      ref.read(weightProvider.notifier).state = 100;
      weightController.text = '100';
    });

    weightController = TextEditingController(text: '100');
    _loadUserId();
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }
  Future<void> _loadUserId() async {
    final id = await ref.read(userIdProvider.future);
    setState(() {
      userId = id;
    });
    print('User ID loaded: $userId');
  }

  int mapMealTypeToInt(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return 0;
      case 'lunch':
        return 2;
      case 'dinner':
        return 4;
      case 'morningSnack':
        return 1;
      case 'afternoonSnack':
        return 3;
      case 'eveningSnack':
        return 5;
      default:
        throw Exception('Invalid meal type');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nutritionAsync = ref.watch(nutritionProvider);

    return Scaffold(
      appBar: AppBar(title: Text(widget.food)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter weight in grams',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                final parsed = double.tryParse(value);
                if (parsed != null) {
                  ref.read(weightProvider.notifier).state = parsed;
                }
              },
            ),
            const SizedBox(height: 20),
            nutritionAsync.when(
              data: (nutrition) => Column(
                children: [
                  _buildNutrient("Calories", nutrition.calories),
                  _buildNutrient("Protein", nutrition.protein),
                  _buildNutrient("Carbs", nutrition.carbs),
                  _buildNutrient("Fats", nutrition.fats),
                  _buildNutrient("Fiber", nutrition.fiber),
                  const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final foodName = widget.food;
                  final meal = mapMealTypeToInt(widget.mealType);
                  final weight = int.tryParse(weightController.text.trim()) ?? 100;

                  final success = await _calorieService.logCalorieEntry(
                    foodItem: foodName,
                    weightInGrams: weight,
                    meal: meal,
                  );

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Entry logged successfully!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to log entry')),
                    );
                  }
                  context.go(PathName.landingpageRoute.path);
                },
                child: Text("Add to ${widget.mealType[0].toUpperCase()}${widget.mealType.substring(1)}"),
              ),

                ],
              ),
              loading: () => const CircularProgressIndicator(),
              error: (err, _) => Text('Error: $err'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrient(String name, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(value.toStringAsFixed(2)),
        ],
      ),
    );
  }
}
