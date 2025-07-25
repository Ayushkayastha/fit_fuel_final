import 'package:fit_fuel_final/features/calorie/presentation/provider/nutrition_goal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/route/path.dart';
import 'package:fit_fuel_final/features/calorie/presentation/provider/date_provider.dart';
import 'package:fit_fuel_final/features/calorie/presentation/provider/total_calorie_summary_provider.dart';
import 'package:fit_fuel_final/features/calorie/presentation/widget/dashboard_widget.dart';
import 'package:fit_fuel_final/core/app_assets/calorie_page_asset.dart';
import 'package:fit_fuel_final/config/network/dio_client.dart';
import 'package:fit_fuel_final/config/storage/secure_storage_providers.dart';

class CaloriePage extends ConsumerStatefulWidget {
  const CaloriePage({super.key});

  @override
  ConsumerState<CaloriePage> createState() => _CaloriePageState();
}

class _CaloriePageState extends ConsumerState<CaloriePage> {
  @override
  void initState() {
    super.initState();

    // Invalidate these providers so they refetch data on each page entry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(calorieSummaryProvider);
      ref.invalidate(nutritionGoalProvider);
      // If you want to re-fetch other data on page entry, invalidate those providers here as well.
    });
  }

  Future<Map<String, dynamic>?> fetchStepEntry(
      WidgetRef ref, DateTime date) async {
    try {
      final userId = await ref.read(userIdProvider.future);
      if (userId == null) return null;

      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final response = await DioClient.client.get(
        'stepentry/user/$userId',
        queryParameters: {'date': formattedDate},
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        debugPrint('Failed to load step entry: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching step entry: $e');
    }
    return null;
  }

  Future<void> _selectDate(
      BuildContext context, WidgetRef ref, DateTime initialDate) async {
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
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(dateProvider);
    final formattedDate = DateFormat.yMMMMd().format(selectedDate);
    final dateNotifier = ref.read(dateProvider.notifier);
    final summaryAsync = ref.watch(calorieSummaryProvider);
    final nutritionAsync = ref.watch(nutritionGoalProvider);

    final nutrition = nutritionAsync.asData?.value;

    final caloriesKcal = nutrition?.caloriesKcal;
    final proteinG = nutrition?.proteinG;
    final proteinKcal = nutrition?.proteinKcal;
    final proteinPct = nutrition?.proteinPctOfTotalKcal;
    final fatG = nutrition?.fatG;
    final fatKcal = nutrition?.fatKcal;
    final fatPct = nutrition?.fatPctOfTotalKcal;
    final carbG = nutrition?.carbohydrateG;
    final carbKcal = nutrition?.carbKcal;
    final carbPct = nutrition?.carbPctOfTotalKcal;
    final totalKcalFromMacros = nutrition?.totalKcalFromMacros;

    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchStepEntry(ref, selectedDate),
      builder: (context, snapshot) {
        final stepEntry = snapshot.data;
        final stepCaloriesBurnt = (stepEntry?['stepCaloriesBurnt'] is num)
            ? (stepEntry?['stepCaloriesBurnt'] as num).toDouble()
            : 0.0;
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
                        fontWeight: FontWeight.w500,
                      ),
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
                summaryAsync.when(
                  data: (summary) => DashboardWidget(
                    totalKcalSupplied: summary.totalCalories,
                    totalKcalBurned: stepCaloriesBurnt,
                    totalKcalDaily: (caloriesKcal ?? 0).toDouble(),
                    totalKcalLeft: ((caloriesKcal ?? 0) - summary.totalCalories).toDouble(),
                    totalCarbsIntake: summary.totalCarbs,
                    totalFatsIntake: summary.totalFats,
                    totalProteinsIntake: summary.totalProtein,
                    totalCarbsGoal: (carbG ?? 0).toDouble(),
                    totalFatsGoal: (fatG ?? 0).toDouble(),
                    totalProteinsGoal: (proteinG ?? 0).toDouble(),
                  ),
                  loading: () => DashboardWidget(
                    totalKcalSupplied: 0,
                    totalKcalBurned: 0,
                    totalKcalDaily: 0,
                    totalKcalLeft: (caloriesKcal ?? 0).toDouble(),
                    totalCarbsIntake: 0,
                    totalFatsIntake: 0,
                    totalProteinsIntake: 0,
                    totalCarbsGoal: 0,
                    totalFatsGoal: 0,
                    totalProteinsGoal: 0,
                  ),
                  error: (err, _) => Center(child: Text('Error: $err')),
                ),
                const SizedBox(height: 20),
                _buildMealButtons(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMealButtons(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _mealButton(
              context,
              title: 'Breakfast',
              icon: CaloriePageIcon.breakfast,
              route: PathName.breakfastpageRoute.path,
            ),
            _mealButton(
              context,
              title: 'Lunch',
              icon: CaloriePageIcon.lunch,
              route: PathName.lunchpageRoute.path,
            ),
            _mealButton(
              context,
              title: 'Dinner',
              icon: CaloriePageIcon.dinner,
              route: PathName.dinnerpageRoute.path,
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _mealButton(
              context,
              title: 'Morning\nSnack',
              icon: CaloriePageIcon.snacks,
              route: PathName.moriningsnackpageRoute.path,
            ),
            _mealButton(
              context,
              title: 'Afternoon\nSnack',
              icon: CaloriePageIcon.snacks,
              route: PathName.afternoonpageRoute.path,
            ),
            _mealButton(
              context,
              title: 'Evening\nSnack',
              icon: CaloriePageIcon.snacks,
              route: PathName.eveningsnackpageRoute.path,
            ),
          ],
        ),
      ],
    );
  }

  Widget _mealButton(
      BuildContext context, {
        required String title,
        required String icon,
        required String route,
      }) {
    return InkWell(
      onTap: () => context.push(route),
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
                color: context.colorScheme.primaryFixedDim,
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  height: 50.h,
                  width: 50.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium?.copyWith(
                height: 1,  // Increase this number to add more spacing between lines
              ),
            ),
          ],
        ),
      ),
    );
  }
}
