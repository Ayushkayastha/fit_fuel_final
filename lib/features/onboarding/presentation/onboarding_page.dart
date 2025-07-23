
import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/features/onboarding/presentation/painter/backdrop_painter.dart';
import 'package:fit_fuel_final/features/onboarding/presentation/screens/onboarding_first.dart';
import 'package:fit_fuel_final/features/onboarding/presentation/screens/onboarding_second.dart';
import 'package:fit_fuel_final/features/onboarding/presentation/screens/onboarding_third.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_assets/app_assets.dart';
import 'onboarding_provider/onboarding_provider.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {

  @override
  Widget build(BuildContext context) {

    final pageIndex=ref.watch(onboardingProvider);
    final controller=PageController(initialPage: pageIndex);

    final pages=[
      OnboardingFirst(controller: controller),
      OnboardingSecond(controller: controller),
      OnboardingThird(controller: controller),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 21.h,
            left: -32.w,
            child: Image.asset(
              OnboardingImages.girlWithFork,
              height: 500.h,
              width: 500.w,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              size:  Size(440.w, 515.h),
              painter: BackdropPainter(),
            ),
          ),
          PageView.builder(
            controller: controller,
            onPageChanged: (index)=>ref.read(onboardingProvider.notifier).state=index,
            // ref.read(onboardingNotifierProvider.notifier).change(1);
            itemCount: pages.length,
            itemBuilder: (_,index)=>GestureDetector(
                onTap: (){
                  controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: pages[index]
            ),
          ),
          Positioned(
            bottom: 172.h,
            right: 0.w,
            left: 0.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  height: 16.h,
                  width: pageIndex==0?40.w:16.w,
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color:
                    pageIndex==0?
                    context.colorScheme.primaryContainer:
                    context.colorScheme.surfaceVariant,
                  ),
                ),
                SizedBox(width: 7.w,),
                AnimatedContainer(
                  height: 16.h,
                  width: pageIndex==1?40.w:16.w,
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color:
                    pageIndex==1?
                    context.colorScheme.primaryContainer:
                    context.colorScheme.surfaceVariant,
                  ),
                ),
                SizedBox(width: 7.w,),
                AnimatedContainer(
                  height: 16.h,
                  width: pageIndex==2?40.w:16.w,
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color:
                    pageIndex==2?
                    context.colorScheme.primaryContainer:
                    context.colorScheme.surfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
