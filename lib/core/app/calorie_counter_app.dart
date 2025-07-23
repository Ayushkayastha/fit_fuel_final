
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_theme/theme.dart';
import '../route/router.dart';

class CalorieCounterApp extends StatelessWidget {
  const CalorieCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(440, 956),
      builder: (context,child)=>MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppTheme.getTheme(isDark: false ),
        darkTheme: AppTheme.getTheme(isDark: true),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
