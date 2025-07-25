import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/route/path.dart';
import '../../config/network/dio_client.dart';
import '../../config/storage/secure_storage_providers.dart';
import '../../shared/components/custom_bottom_btn.dart';
import '../auth/domain/notifier/logout_notifier.dart';
import '../home/step_counter/domain/user_provider.dart';
import 'domain/fitness_profile_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  // User fields
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final targetWeightController = TextEditingController();
  final goalController = TextEditingController();

  // Fitness profile fields
  final fitnessLevelController = TextEditingController();
  final availabilityController = TextEditingController();
  final equipmentController = TextEditingController();
  final activityLevelController = TextEditingController();

  Future<void> updateUserProfile() async {
    final userId = await ref.read(userIdProvider.future);

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User ID not found")),
      );
      return;
    }

    final updatedUser = {
      "age": int.tryParse(ageController.text),
      "gender": genderController.text,
      "heightCm": double.tryParse(heightController.text),
      "weightKg": double.tryParse(weightController.text),
      "targetWeightKg": double.tryParse(targetWeightController.text),
      "goal": goalController.text,
      "fitnessLevel": fitnessLevelController.text,
      "availability": int.tryParse(availabilityController.text),
      "equipment": equipmentController.text,
      "activityLevel": activityLevelController.text,
    };

    try {
      final response = await DioClient.client.put(
        "users/$userId/update-profile",
        data: updatedUser,
      );

      if (response.statusCode == 200 && response.data['message'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'])),
        );
        ref.invalidate(userProvider);
        ref.invalidate(fitnessProfileProvider);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unexpected response from server.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update profile: $e")),
      );
    }
  }


  Widget _buildField(
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        bool readOnly = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: readOnly,
          fillColor: readOnly ? Colors.grey.shade200 : null,
        ),
      ),
    );
  }
  Widget _buildDropdownField({
    required String label,
    required List<String> options,
    required TextEditingController controller,
  }) {
    final currentValue = options.contains(controller.text) ? controller.text : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        decoration: InputDecoration(
          labelText: label, // Label is shown inside like a TextField
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        items: options
            .map((option) => DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            controller.text = value;
          }
        },
      ),
    );
  }


  final List<String> equipmentOptions = [
    'Parallette Bars', 'Suspension Trainer', 'Gymnastic Rings', 'Dumbbell', 'Cable', 'Barbell',
    'EZ Bar', 'Stability Ball', 'Bodyweight', 'Landmine', 'Superband', 'Kettlebell', 'Resistance Band',
    'Weight Plate', 'Macebell', 'Indian Club', 'Clubbell', 'Pull Up Bar', 'Tire', 'Trap Bar',
    'Battle Ropes', 'Sliders', 'Miniband', 'Sandbag', 'Bulgarian Bag', 'Sled', 'Heavy Sandbag',
    'Slam Ball', 'Ab Wheel', 'Medicine Ball', 'Wall Ball'
  ];


  Widget _buildMultiSelectDropdown({
    required BuildContext context,
    required String label,
    required List<String> options,
    required TextEditingController controller,
  }) {
    final selectedOptions = controller.text.isEmpty
        ? <String>{}
        : controller.text.split(',').map((e) => e.trim()).toSet();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () async {
          final tempSelected = Set<String>.from(selectedOptions);

          final result = await showModalBottomSheet<Set<String>>(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return SizedBox(
                    height: 400,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Select Equipment',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: options.map((option) {
                              final isSelected = tempSelected.contains(option);
                              return CheckboxListTile(
                                title: Text(option),
                                value: isSelected,
                                onChanged: (checked) {
                                  setState(() {
                                    if (checked == true) {
                                      tempSelected.add(option);
                                    } else {
                                      tempSelected.remove(option);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, null),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, tempSelected),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                        SizedBox(height: 12,),
                      ],
                    ),
                  );
                },
              );
            },
          );

          if (result != null) {
            controller.text = result.join(', ');
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
    final fitnessAsync = ref.watch(fitnessProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error loading user: $e")),
        data: (user) {
          if (user == null) return const Center(child: Text("No user data"));

          // Fill user controllers
          nameController.text = user.name;
          ageController.text = user.age.toString();
          genderController.text = user.gender;
          heightController.text = user.heightCm.toString();
          weightController.text = user.weightKg.toString();
          targetWeightController.text = user.targetWeightKg.toString();
          goalController.text = user.goal;

          return fitnessAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text("Error loading fitness profile: $e")),
            data: (fitness) {
              // Fill fitness controllers
              fitnessLevelController.text = fitness.fitnessLevel;
              availabilityController.text = fitness.availability.toString();
              equipmentController.text = fitness.equipment;
              activityLevelController.text = fitness.activityLevel;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: context.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                          ),
                        )
                      ],
                    ),

                    // User Profile
                    _buildField("Name", nameController, readOnly: true),
                    _buildField("Email", TextEditingController(text: user.email), readOnly: true),
                    _buildField("Age", ageController),
                    _buildDropdownField(label: genderController.text.trim() , options:["Male", "Female"], controller: genderController),
                    _buildField("Height (cm)", heightController, keyboardType: TextInputType.number),
                    _buildField("Weight (kg)", weightController, keyboardType: TextInputType.number),
                    _buildField("Target Weight (kg)", targetWeightController, keyboardType: TextInputType.number),
                    _buildDropdownField(
                        label: goalController.text.trim() ,
                        options: ["Muscle Gain", "Fat Loss", "Endurance", "Strength"],
                        controller: goalController
                    ),

                    const SizedBox(height: 20),
                    const Divider(thickness: 2),
                    const SizedBox(height: 10),

                    const Text("Fitness Profile", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    _buildDropdownField(
                        label: fitnessLevelController.text.trim() ,
                        options: ["Beginner", "Intermediate", "Advanced"],
                        controller: fitnessLevelController
                    ),

                    _buildDropdownField(
                        label: availabilityController.text.trim(),
                        options: ["3", "4", "5"],
                        controller:availabilityController
                    ),
                    _buildMultiSelectDropdown(
                      context: context,
                      label: 'Equipment',
                      options: equipmentOptions,
                      controller: equipmentController,
                    ),

                    _buildDropdownField(
                        label: activityLevelController.text.trim(),
                        options: [
                          "Sedentary","Light","Moderate","Active", "Very Active"
                        ],
                        controller:activityLevelController
                    ),
                    const SizedBox(height: 20),
                    CustomBottomBtn(
                      context: context,
                      name: 'Update Profile',
                      callBack: updateUserProfile,
                    ),
                    const SizedBox(height: 20),
                    CustomBottomBtn(
                      context: context,
                      name: 'Logout',
                      callBack: () async {
                        print('logout tapped');
                        await ref.read(logoutNotifierProvider.notifier).logout();
                        if (context.mounted) {
                          ref.invalidate(userProvider);
                          context.go(PathName.authgateRoute.path);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
