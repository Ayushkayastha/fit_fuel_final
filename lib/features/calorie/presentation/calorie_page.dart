
import 'dart:ffi';
import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/route/path.dart';
import 'package:fit_fuel_final/features/calorie/presentation/provider/date_provider.dart';
import 'package:fit_fuel_final/features/calorie/presentation/widget/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/app_assets/calorie_page_asset.dart';

class CaloriePage extends ConsumerWidget {
  const CaloriePage({super.key});

  double stepCalorieBurnt(double weight, int steps)
  {
    double basalCalPerStep = 0.05 ;// kcal per step for a 70 kg person
    double calPerStep=basalCalPerStep*(weight/70);
    double caloriesBurnt=steps*calPerStep;
    return caloriesBurnt;
  }

  Future<void> _selectDate(BuildContext context, WidgetRef ref, DateTime initialDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2034),
    );

    if (picked != null) {
      ref.read(dateProvider.notifier).setDate(picked);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(dateProvider);
    final formattedDate = DateFormat.yMMMMd().format(selectedDate);
    final dateNotifier = ref.read(dateProvider.notifier);


    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: dateNotifier.previousDay,
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            GestureDetector(
              onTap: () => _selectDate(context, ref, selectedDate),
              child: Container(
                width: 200,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.black),
                ),
                child: Text(
                  formattedDate,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            IconButton(
              onPressed: dateNotifier.nextDay,
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [

            DashboardWidget(
              totalKcalSupplied: 800,
              totalKcalBurned: 250,
              totalKcalDaily: 2900,
              totalKcalLeft: 2100 ,
              totalCarbsIntake: 50,
              totalFatsIntake: 20,
              totalProteinsIntake: 13,
              totalCarbsGoal: 200,
              totalFatsGoal: 50,
              totalProteinsGoal: 140,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    context.push(PathName.breakfastpageRoute.path);
                  },
                  child: SizedBox(
                    height: 130.h,
                    width: 130.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: context.colorScheme.primaryFixedDim
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              CaloriePageIcon.breakfast,
                              height: 50.h,
                              width: 50.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                            'Breakfast',
                          style: context.textTheme.titleMedium,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    context.push(PathName.lunchpageRoute.path);
                  },
                  child: SizedBox(
                    height: 130.h,
                    width: 130.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              color: context.colorScheme.primaryFixedDim
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              CaloriePageIcon.lunch,
                              height: 50.h,
                              width: 50.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          'Lunch',
                          style: context.textTheme.titleMedium,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    context.push(PathName.dinnerpageRoute.path);
                  },
                  child: SizedBox(
                    height: 130.h,
                    width: 130.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              color: context.colorScheme.primaryFixedDim
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              CaloriePageIcon.dinner,
                              height: 50.h,
                              width: 50.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          'Dinner',
                          style: context.textTheme.titleMedium,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    context.push(PathName.moriningsnackpageRoute.path);
                  },
                  child: SizedBox(
                    height: 153.h,
                    width: 130.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              color: context.colorScheme.primaryFixedDim
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              CaloriePageIcon.snacks,
                              height: 50.h,
                              width: 50.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          'Morning',
                          style: context.textTheme.titleMedium,
                        ),
                        Text(
                          'snack',
                          style: context.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    context.push(PathName.afternoonpageRoute.path);
                  },
                  child: SizedBox(
                    height: 153.h,
                    width: 130.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              color: context.colorScheme.primaryFixedDim
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              CaloriePageIcon.snacks,
                              height: 50.h,
                              width: 50.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          'Afternoon',
                          style: context.textTheme.titleMedium,
                        ),
                        Text(
                          'snack',
                          style: context.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    context.push(PathName.eveningsnackpageRoute.path);
                  },
                  child: SizedBox(
                    height: 153.h,
                    width: 130.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              color: context.colorScheme.primaryFixedDim
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              CaloriePageIcon.snacks,
                              height: 50.h,
                              width: 50.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          'Evening',
                          style: context.textTheme.titleMedium,
                        ),
                        Text(
                          'snack',
                          style: context.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
