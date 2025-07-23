import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/extensions/text_theme_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/route/path.dart';
import '../../../../shared/components/custom_bottom_btn.dart';
import '../provider/body_info_provider.dart';
import '../widget/gender_card.dart';
import '../widget/progress_bar.dart';

class GenderPage extends ConsumerWidget {
   GenderPage({super.key});
  final List<String> labels = const [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];

  final List<String> svgPaths =  [
    OnboardingInfoIcons.male,
    OnboardingInfoIcons.female,
    OnboardingInfoIcons.others,
    OnboardingInfoIcons.none,
  ];
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final selectedGender = ref.watch(genderSelectionProvider);
    print(selectedGender);

    return Scaffold(
      body: SafeArea(
          child:Column(
            children: [
              ProgressBar(onPressed: (){
                context.go(PathName.authgateRoute.path);
              }, number: 2),

              SizedBox(height: 34.h,),
              Text(
                'Select your Gender',
                style: context.textTheme.headlineSmallEmphasized,
              ),
              SizedBox(height: 29.h,),

              ...List.generate(labels.length, (index) {
                final label = labels[index];
                final svg = svgPaths[index];
                return OptionCard(
                  label: label,
                  svgAssetPath: svg,
                  isSelected: label == selectedGender,
                  onTap: () => ref
                      .read(genderSelectionProvider.notifier)
                      .select(label),
                );
              }),
              Spacer(),
              CustomBottomBtn(context: context,
                  name: 'Next',
                  icon:Icons.arrow_forward,
                  callBack: (){
                    if (selectedGender == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a gender option.')),
                      );
                    } else {
                      context.go(PathName.goalRoute.path);
                      print('Selected gender: $selectedGender');
                    }
                  }
              ),
            ],
          )
      ),
    );
  }
}





