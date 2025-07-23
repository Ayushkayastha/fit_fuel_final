import 'dart:math';

import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/extensions/text_theme_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/route/path.dart';
import '../../../../shared/components/custom_bottom_btn.dart';
import '../provider/body_info_provider.dart';
import '../widget/custom_triangle.dart';
import '../widget/number_picker.dart';
import '../widget/progress_bar.dart';

class AgePage extends ConsumerWidget {
  const AgePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final selectedValue = ref.watch(ageProvider);

    return Scaffold(
      body: SafeArea(
          child:Center(
            child: Column(
              children: [
                ProgressBar(onPressed: (){
                  context.go(PathName.authgateRoute.path);
                }, number: 1),
                SizedBox(height: 34.h,),
                Text(
                  'What is your current age?',
                style: context.textTheme.headlineSmallEmphasized,
                ),
                SizedBox(height: 63.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: pi,
                      child: CustomPaint(
                        size: Size(40, 44),
                        painter: RPSCustomTriangle(),
                      ),
                    ) ,
                    SizedBox(width: 16.w,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: context.colorScheme.onInverseSurface
                      ),
                      child: NumberPicker(
                        itemHeight: 76,
                        itemWidth: 124,
                        minValue: 0,
                        maxValue: 99,
                        value: selectedValue,
                        onChanged: (newValue) {
                          ref.read(ageProvider.notifier).state = newValue;
                        },
                        axis: Axis.vertical,          // or Axis.horizontal
                        itemCount: 5,                 // how many visible items
                        infiniteLoop: true,           // allows infinite scroll
                        haptics: true,                // enables vibration
                        zeroPad: true,                // shows 001, 002, etc.
                        textStyle:context.textTheme.displaySmall!.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        selectedTextStyle:context.textTheme.displayMedium,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: context.colorScheme.primaryContainer,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16.r), // 🎯 Rounded corners
                        ),

                      ),
                    ),
                    SizedBox(width: 16.w,),
                    CustomPaint(
                      size: Size(40, 44),
                      painter: RPSCustomTriangle(),
                    ) ,
                  ],
                ),
                Spacer(),
                CustomBottomBtn(
                    context: context,
                    name: 'Next',
                    callBack:(){
                      context.go(PathName.genderRoute.path);
                    },
                  icon: Icons.arrow_forward,
                ),
              ],
            ),
          )
      ),
    );
  }
}
