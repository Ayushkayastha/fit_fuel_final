
import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/extensions/text_theme_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/storage/secure_storage_providers.dart';
import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/app_setup/provider/auth_database_provider.dart';
import '../../../../core/route/path.dart';
import '../../../../shared/components/custom_bottom_btn.dart';
import '../../domain/onboarding_service.dart';
import '../provider/body_info_provider.dart';
import '../widget/gender_card.dart';
import '../widget/progress_bar.dart';

class GoalPage extends ConsumerWidget {
   GoalPage({super.key});
  final List<String> labels = const [
    'Fat Loss',
    'Muscle Gain',
    'Strength',
    'Endurance',
  ];

  final List<String> svgPaths =  [
    OnboardingInfoIcons.scale,
    OnboardingInfoIcons.muscle,
    OnboardingInfoIcons.balance,
    OnboardingInfoIcons.boostEnergy,
  ];
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final selectedGoal = ref.watch(goalSelectionProvider);
    print(selectedGoal);

    return Scaffold(
      body: SafeArea(
          child:Column(
            children: [
              ProgressBar(onPressed: (){
                context.go(PathName.goalweightRoute.path);
              }, number: 3),

              SizedBox(height: 34.h,),
              Text(
                'What is your main goal?',
                style: context.textTheme.headlineSmallEmphasized,
              ),
              SizedBox(height: 29.h,),

              ...List.generate(labels.length, (index) {
                final label = labels[index];
                final svg = svgPaths[index];
                return OptionCard(
                  label: label,
                  svgAssetPath: svg,
                  isSelected: label == selectedGoal,
                  onTap: () => ref
                      .read(goalSelectionProvider.notifier)
                      .select(label),
                );
              }),
              Spacer(),
              CustomBottomBtn(context: context,
                  name: 'Next',
                  icon:Icons.arrow_forward,
                  callBack: () async {
                    final userId = await ref.read(userIdProvider.future); // Get user ID
                    final age = ref.read(ageProvider);
                    final gender = ref.read(genderSelectionProvider);
                    final goal = ref.read(goalSelectionProvider);
                    final heightUnit = ref.read(heightUnitSelectionProvider);
                    final weightUnit = ref.read(weightUnitSelectionProvider);
                    final goalWeightUnit = ref.read(goalWeightUnitSelectionProvider);

                    // You'll need to store or retrieve the actual values of height, weight, and target weight
                    // Assuming you stored them in separate providers like heightProvider, weightProvider, goalWeightProvider
                    final height = ref.read(heightValueProvider); // double
                    final weight = ref.read(weightValueProvider); // double
                    final targetWeight = ref.read(goalWeightValueProvider); // double

                    // Convert units if needed (currently assuming already in cm/kg)
                    try {
                      await OnboardingService.completeProfile(
                        userId: userId!,
                        age: age,
                        gender: gender ?? '',
                        heightCm: height,
                        weightKg: weight,
                        targetWeightKg: targetWeight,
                        goal: goal ?? '',
                      );

                      final db = ref.read(authDatabaseProvider);
                      await db.setOnboardingUserInfoComplete();

                      if (context.mounted) {
                        context.go(PathName.authgateRoute.path);
                      }
                    } catch (e) {
                      print('Profile update failed: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to complete profile')),
                      );
                    }
                  }

              ),
            ],
          )
      ),
    );
  }
}
