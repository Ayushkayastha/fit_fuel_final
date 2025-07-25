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
import '../widget/progress_bar.dart';
import '../widget/simple_ruler_picker.dart';

class WeightPage extends ConsumerWidget {
  const WeightPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final selected = ref.watch(weightUnitSelectionProvider);//yesma kun select gareko aaucha cm ft or inch
    final notifier = ref.read(weightUnitSelectionProvider.notifier);

    final units = WeightUnit.values;

    String getLabel(WeightUnit unit) {
      switch (unit) {
        case WeightUnit.kilogram:
          return 'kilogram';
        case WeightUnit.pound:
          return 'pound';
      }
    }

    return Scaffold(
      body: SafeArea(
          child:Column(
            children: [
              ProgressBar(onPressed: (){
                context.go(PathName.heightRoute.path);
              }, number: 5),

              SizedBox(height: 34.h,),
              Text(
                'What is your weight?',
                style: context.textTheme.headlineSmallEmphasized,
              ),
              SizedBox(height: 29.h,),

              Container(
                height: 44.h,
                decoration: BoxDecoration(
                  color: context.colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: units.map((unit) {
                    final isSelected = selected == unit;

                    return GestureDetector(
                      onTap: () => notifier.select(unit),
                      child: AnimatedContainer(
                        height: 44.h,
                        width: 204.w,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding:  EdgeInsets.symmetric(horizontal: 16.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? context.colorScheme.primaryContainer : Colors.transparent,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          getLabel(unit),
                          style: context.textTheme.bodyLarge!.copyWith(
                              color:  isSelected ?
                              context.colorScheme.onPrimary:
                              context.colorScheme.onSurface
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 48.h,),
              SvgPicture.asset(
                OnboardingInfoImages.weight,
              ),
              SizedBox(height: 48.h,),
              Container(
                width: 408.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  border: Border.all(
                    color: context.colorScheme.outlineVariant, // 🟤 Border color
                    width: 2,             // Border width
                  ),
                  borderRadius: BorderRadius.circular(16), // 🎯 Rounded corners
                ),
                child: SimpleRulerPicker(
                  height: 100,
                  minValue: 30,
                  maxValue: 200,
                  initialValue: 60,
                  axis: Axis.horizontal,
                  onValueChanged: (value){
                    print('value:$value');
                    ref.read(weightValueProvider.notifier).set(value.toDouble());
                  },
                ),
              ),
              Spacer(),
              CustomBottomBtn(context: context,
                  name: 'Next',
                  icon:Icons.arrow_forward,
                  callBack: (){
                context.go(PathName.goalweightRoute.path);
                  }
              ),
            ],
          )
      ),
    );
  }
}
