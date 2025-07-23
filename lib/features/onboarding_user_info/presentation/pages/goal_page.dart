
import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/extensions/text_theme_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/app_setup/provider/auth_database_provider.dart';
import '../../../../core/route/path.dart';
import '../../../../shared/components/custom_bottom_btn.dart';
import '../provider/body_info_provider.dart';
import '../widget/gender_card.dart';
import '../widget/progress_bar.dart';

class GoalPage extends ConsumerWidget {
   GoalPage({super.key});
  final List<String> labels = const [
    'Lose Weight',
    'Muscle Gain',
    'Maintain Weight',
    'Boost Energy',
    'Improve Nutrition',
    'Gain Weight',
  ];

  final List<String> svgPaths =  [
    OnboardingInfoIcons.scale,
    OnboardingInfoIcons.muscle,
    OnboardingInfoIcons.balance,
    OnboardingInfoIcons.boostEnergy,
    OnboardingInfoIcons.paleo,
    OnboardingInfoIcons.gainWt,
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
                context.go(PathName.genderRoute.path);
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
                  callBack:() async {
                    final db = ref.read(authDatabaseProvider);
                    await db.setOnboardingUserInfoComplete();
                    if (context.mounted) {
                      context.go(PathName.authgateRoute.path);
                    }
                  },
              ),
            ],
          )
      ),
    );
  }
}
