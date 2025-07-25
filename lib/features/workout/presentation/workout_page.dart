import 'package:fit_fuel_final/shared/components/custom_bottom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/network/dio_client.dart';
import '../../../config/storage/secure_storage_providers.dart';

/// StateNotifier to manage predicted calories state and API call
class PredictedCaloriesNotifier extends StateNotifier<double?> {
  PredictedCaloriesNotifier() : super(null);

  Future<void> fetchPredictedCalories({
    required String userId,
    required int duration,
    required int heartRate,
    required double bodyTemp,
  }) async {
    try {
      final response = await DioClient.client.post(
        'workout/predict-calories',
        data: {
          'userId': userId,
          'duration': duration,
          'heartRate': heartRate,
          'bodyTemp': bodyTemp,
        },
      );

      if (response.statusCode == 200) {
        final predictedCalories = (response.data['predicted_Calories'] as num).toDouble();
        state = predictedCalories;
      } else {
        throw Exception('Failed to fetch predicted calories. Status: ${response.statusCode}');
      }
    } catch (e) {
      // You can handle/log errors here
      state = null;
      rethrow;
    }
  }
}

final predictedCaloriesProvider =
StateNotifierProvider<PredictedCaloriesNotifier, double?>(
        (ref) => PredictedCaloriesNotifier());

class WorkoutPage extends ConsumerStatefulWidget {
  const WorkoutPage({super.key});

  @override
  ConsumerState<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends ConsumerState<WorkoutPage> {
  Map<String, List<Map<String, dynamic>>> _workoutPlan = {};
  bool _loading = false;

  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _bodyTempController = TextEditingController();

  Future<void> _fetchWorkoutPlan(String userId) async {
    setState(() => _loading = true);
    try {
      final response = await DioClient.client.post(
        'workout/workout-plan',
        data: {'userId': userId},
      );

      setState(() {
        _workoutPlan = Map<String, List<Map<String, dynamic>>>.from(
          response.data['workoutPlan'].map(
                (day, exercises) => MapEntry(
              day,
              List<Map<String, dynamic>>.from(exercises),
            ),
          ),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching workout: ${e.toString()}")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    ref.read(userIdProvider.future).then((userId) {
      if (userId != null) {
        _fetchWorkoutPlan(userId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User ID not found")),
        );
      }
    });
  }

  @override
  void dispose() {
    _durationController.dispose();
    _heartRateController.dispose();
    _bodyTempController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final duration = int.tryParse(_durationController.text);
    final heartRate = int.tryParse(_heartRateController.text);
    final bodyTemp = double.tryParse(_bodyTempController.text);

    if (duration == null || heartRate == null || bodyTemp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid values in all fields')),
      );
      return;
    }

    final userId = await ref.read(userIdProvider.future);
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID not found')),
      );
      return;
    }

    try {
      await ref.read(predictedCaloriesProvider.notifier).fetchPredictedCalories(
        userId: userId,
        duration: duration,
        heartRate: heartRate,
        bodyTemp: bodyTemp,
      );
      final predictedCalories = ref.watch(predictedCaloriesProvider);

      if (predictedCalories != null) {
        print("Predicted calories: $predictedCalories");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Calories prediction fetched!')),
      );

      _durationController.clear();
      _heartRateController.clear();
      _bodyTempController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch calories: $e')),
      );
    }
  }

  Widget _buildWorkoutList() {
    if (_workoutPlan.isEmpty) {
      return const Center(
        child: Text(
          'No workout plan available.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: _workoutPlan.entries.map((entry) {
        final day = entry.key;
        final exercises = entry.value;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ExpansionTile(
            title: Text(
              day,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: Colors.black87,
              ),
            ),
            children: exercises.map((exercise) {
              return ListTile(
                title: Text(
                  exercise['exercise_name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '${exercise['primary_muscle']} - '
                        '${exercise['sets']} sets x ${exercise['reps']} reps\n'
                        'Rest: ${exercise['rest']} | Intensity: ${exercise['intensity']}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.3,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final predictedCalories = ref.watch(predictedCaloriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Workout Plan')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildWorkoutList(),
            SizedBox(height: 24),
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Duration (minutes)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _heartRateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Heart Rate (bpm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bodyTempController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Body Temperature (°C)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            CustomBottomBtn(
                context: context,
                name: 'Submit Data',
                callBack: _onSubmit
            ),
            const SizedBox(height: 24),
            if (predictedCalories != null)
              Text(
                'Predicted Calories: ${predictedCalories.toStringAsFixed(1)} kcal',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
