
import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/extensions/text_theme_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_setup/provider/auth_database_provider.dart';
import '../../../../core/route/path.dart';
import '../../../../shared/components/custom_bottom_btn.dart';
import '../painter/backdrop_painter.dart';

class OnboardingSecond extends ConsumerWidget {
  final PageController controller;
  const OnboardingSecond({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 521.h,),
        Text(
          'Snap a Pic, Count Calories',
          style: context.textTheme.headlineSmallEmphasized,
        ),
        SizedBox(height: 30.h,),
        SizedBox(
          width: 384.w,
          height: 92.h,
          child: Text(
            'Use your camera to scan meals in real-time and get instant calorie estimates. No more guesswork!',
            style: context.textTheme.bodyLarge!.copyWith(
              height: 24/16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 121.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () async{
                final db = ref.read(authDatabaseProvider);
                await db.setOnboardingComplete();
                context.go(PathName.authgateRoute.path);
              },
              child: Container(
                width:190.w,
                height: 48.h,
                decoration: BoxDecoration(
                    color:Colors.transparent,
                    borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(
                    color: context.colorScheme.outlineVariant, // Border color
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                     'Skip',
                      style: context.textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ),
            CustomBottomBtn(
              context: context,
              name:'Next' ,
              width: 190,
              callBack:(){
                controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: Icons.arrow_forward,
            ),
          ],
        )
      ],
    );
  }
}
