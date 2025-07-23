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

class OnboardingThird extends ConsumerWidget {
  final PageController controller;
  const OnboardingThird({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 521.h,),
        Text(
          'Stay On Track, Your Way',
          style: context.textTheme.headlineSmallEmphasized,
        ),
        SizedBox(height: 30.h,),
        SizedBox(
          width: 384.w,
          height: 92.h,
          child: Text(
            'Set goals, receive reminders, and log manually when needed. We’ll help you stay consistent every step of the way.',
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
          name:'Get Started' ,
          callBack:() async {
            final db = ref.read(authDatabaseProvider);
            await db.setOnboardingComplete();
            if (context.mounted) {
              context.go(PathName.authgateRoute.path);
            }
            },
          icon: Icons.arrow_forward,
        ),
      ],
    );
  }
}
