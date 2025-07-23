
import 'package:fit_fuel_final/core/app_assets/app_assets.dart';
import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/extensions/text_theme_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/components/custom_bottom_btn.dart';

class OnboardingFirst extends StatelessWidget {
  final PageController controller;
  const OnboardingFirst({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 521.h,),

        Text(
            'Track Calories, Eat Smarter!',
          style: context.textTheme.headlineSmallEmphasized,
        ),
        SizedBox(height: 30.h,),
        SizedBox(
          width: 384.w,
          height: 92.h,
          child: Text(
            'Start your journey towards healthier habits. Easily scan or log your meals and take control of your nutrition',
            style: context.textTheme.bodyLarge!.copyWith(
              height: 24/16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 121.h,),
        CustomBottomBtn(
          height: 48,
            context: context,
            name:'Next' ,
            callBack:(){
              controller.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            icon: Icons.arrow_forward,
        ),
      ],
    );
  }
}
