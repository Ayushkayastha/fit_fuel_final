import 'package:flutter/material.dart';
import '../../../config/network/dio_client.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fitnessLevelController = TextEditingController(text: "Beginner");
  final TextEditingController _goalController = TextEditingController(text: "fatloss");
  final TextEditingController _availabilityController = TextEditingController(text: "3");
  final TextEditingController _equipmentController = TextEditingController(text: "Dumbbell");
  final TextEditingController _ageController = TextEditingController(text: "25");
  final TextEditingController _genderController = TextEditingController(text: "Male");
  final TextEditingController _heightController = TextEditingController(text: "175.0");
  final TextEditingController _weightController = TextEditingController(text: "70.0");

  Map<String, List<Map<String, dynamic>>> _workoutPlan = {};
  bool _loading = false;

  Future<void> _fetchWorkoutPlan() async {
    setState(() => _loading = true);
    try {
      final response = await DioClient.client.post(
        'workout/workout-plan',
        data: {
          "fitness_level": _fitnessLevelController.text,
          "goal": _goalController.text,
          "availability": int.tryParse(_availabilityController.text),
          "equipment_str": _equipmentController.text,
          "age": int.tryParse(_ageController.text),
          "gender": _genderController.text,
          "height": double.tryParse(_heightController.text),
          "weight": double.tryParse(_weightController.text),
        },
      );

      setState(() {
        _workoutPlan = Map<String, List<Map<String, dynamic>>>.from(
          response.data['workoutPlan'].map((day, exercises) =>
              MapEntry(day, List<Map<String, dynamic>>.from(exercises))),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    } finally {
      setState(() => _loading = false);
    }
  }

  Widget _buildWorkoutList() {
    if (_workoutPlan.isEmpty) {
      return const Text('No workout plan fetched yet.');
    }

    return Column(
      children: _workoutPlan.entries.map((entry) {
        final day = entry.key;
        final exercises = entry.value;

        final TextEditingController durationController = TextEditingController();
        final TextEditingController heartRateController = TextEditingController();
        final TextEditingController temperatureController = TextEditingController();

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ExpansionTile(
            title: Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              ...exercises.map((exercise) {
                return ListTile(
                  title: Text(exercise['exercise_name']),
                  subtitle: Text(
                    '${exercise['primary_muscle']} - ${exercise['sets']} sets x ${exercise['reps']} reps',
                  ),
                );
              }),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const Text("Daily Summary", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),

                    TextFormField(
                      controller: durationController,
                      decoration: const InputDecoration(
                        labelText: 'Duration (minutes)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),

                    TextFormField(
                      controller: heartRateController,
                      decoration: const InputDecoration(
                        labelText: 'Heart Rate (bpm)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),

                    TextFormField(
                      controller: temperatureController,
                      decoration: const InputDecoration(
                        labelText: 'Temperature (°C)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: () {
                        final duration = durationController.text;
                        final heartRate = heartRateController.text;
                        final temperature = temperatureController.text;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Day: $day\nDuration: $duration min\nHeart Rate: $heartRate bpm\nTemperature: $temperature °C',
                            ),
                          ),
                        );
                      },
                      child: const Text('Submit Summary'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchWorkoutPlan(); // Auto fetch on load
  }

  @override
  void dispose() {
    _fitnessLevelController.dispose();
    _goalController.dispose();
    _availabilityController.dispose();
    _equipmentController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout Plan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          _buildWorkoutList(),
          const Divider(height: 40),
          Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _fitnessLevelController,
                decoration: const InputDecoration(labelText: 'Fitness Level'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _goalController,
                decoration: const InputDecoration(labelText: 'Goal'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _availabilityController,
                decoration: const InputDecoration(labelText: 'Availability (days)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (int.tryParse(value) == null) return 'Must be a number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _equipmentController,
                decoration: const InputDecoration(labelText: 'Equipment'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (int.tryParse(value) == null) return 'Must be a number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Must be a number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Must be a number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loading
                    ? null
                    : () {
                  if (_formKey.currentState!.validate()) {
                    _fetchWorkoutPlan();
                  }
                },
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Generate Workout Plan'),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
