
import 'package:fit_fuel_final/core/route/path.dart';
import 'package:fit_fuel_final/features/meals/presentation/afternoon_snack.dart';
import 'package:fit_fuel_final/features/meals/presentation/dinner.dart';
import 'package:fit_fuel_final/features/meals/presentation/evening_snack.dart';
import 'package:fit_fuel_final/features/meals/presentation/lunch.dart';
import 'package:fit_fuel_final/features/meals/presentation/morning_snack.dart';
import 'package:fit_fuel_final/features/onboarding_user_info/presentation/pages/goal_weight.dart';
import 'package:fit_fuel_final/features/splash/presentation/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/password_reset/all_set.dart';
import '../../features/auth/presentation/password_reset/forgot_password.dart';
import '../../features/auth/presentation/password_reset/new_password.dart';
import '../../features/auth/presentation/signup_page.dart';
import '../../features/auth/presentation/verify_acc_page.dart';
import '../../features/landing/presentation/landing_page.dart';
import '../../features/meals/domain/food_detail_args.dart';
import '../../features/meals/presentation/breakfast.dart';
import '../../features/meals/presentation/food_detail/food_detail.dart';
import '../../features/onboarding/presentation/onboarding_page.dart';
import '../../features/onboarding_user_info/presentation/pages/gender_page.dart';
import '../../features/onboarding_user_info/presentation/pages/goal_page.dart';
import '../../features/onboarding_user_info/presentation/pages/height_page.dart';
import '../../features/onboarding_user_info/presentation/pages/weight_page.dart';
import '../../shared/pages/loader_page.dart';
import '../app_setup/auth_gate.dart';
class AppRouter{
  static final key = GlobalKey<NavigatorState>();
  static final router =GoRouter(
    initialLocation: PathName.splashPageRoute.path,
    navigatorKey: key,
      routes:[
        GoRoute(
          path :PathName.splashPageRoute.path,
          name: PathName.splashPageRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child: SplashPage(),
          ),
        ),
        GoRoute(
          path :PathName.authgateRoute.path,
          name: PathName.authgateRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child: AuthGate(),
          ),
        ),
        GoRoute(
          path: PathName.onboardingPageRoute.path,
          name: PathName.onboardingPageRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
              key: state.pageKey,
              child: OnboardingPage(),
          ),
        ),
        GoRoute(
          path: PathName.loginPageRoute.path,
          name: PathName.loginPageRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child: LoginPage(),
          ),
        ),
        GoRoute(
          path: PathName.signupPageRoute.path,
          name: PathName.signupPageRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child: SignupPage(),
          ),
        ),
        GoRoute(
          path: PathName.forgotpasswordPageRoute.path,
          name: PathName.forgotpasswordPageRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child: ForgotPassword(),
          ),
        ),
        GoRoute(
          path: PathName.newpasswordPageRoute.path,
          name: PathName.newpasswordPageRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child: NewPassword(),
          ),
        ),
        GoRoute(
          path: PathName.allsetPageRoute.path,
          name: PathName.allsetPageRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child: AllSet(),
          ),
        ),
        GoRoute(
          path: PathName.loaderPageRoute.path,
          name: PathName.loaderPageRoute.routeName,
          pageBuilder: (context, state) {
            final message = state.extra is String ? state.extra as String : '';
            return FadeTransitionPage(
              key: state.pageKey,
              child: LoaderPage(message: message),
            );
          },
        ),

        GoRoute(
          path: PathName.landingpageRoute.path,
          name: PathName.landingpageRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child: LandingPage(),
          ),
        ),
        GoRoute(
          path: PathName.verifyaccpageRoute.path,
          name: PathName.verifyaccpageRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child: VerifyAccPage(),
          ),
        ),
        GoRoute(
          path: PathName.genderRoute.path,
          name: PathName.genderRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child: GenderPage(),
          ),
        ),
        GoRoute(
          path: PathName.goalRoute.path,
          name: PathName.goalRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child:GoalPage(),
          ),
        ),
        GoRoute(
          path: PathName.heightRoute.path,
          name: PathName.heightRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child:HeightPage(),
          ),
        ),
        GoRoute(
          path: PathName.weightRoute.path,
          name: PathName.weightRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child:WeightPage(),
          ),
        ),
        GoRoute(
          path: PathName.goalweightRoute.path,
          name: PathName.goalweightRoute.routeName,
          pageBuilder: (context,state)=>FadeTransitionPage(
            key: state.pageKey,
            child:GoalWeight(),
          ),
        ),
        GoRoute(
            path:PathName.breakfastpageRoute.path,
            name: PathName.breakfastpageRoute.routeName,
            pageBuilder: (context, state)=>FadeTransitionPage(
              key: state.pageKey,
              child:  Breakfast(),
            )
        ),
        GoRoute(
            path:PathName.lunchpageRoute.path,
            name: PathName.lunchpageRoute.routeName,
            pageBuilder: (context, state)=>FadeTransitionPage(
              key: state.pageKey,
              child:Lunch(),
            )
        ),
        GoRoute(
            path:PathName.dinnerpageRoute.path,
            name: PathName.dinnerpageRoute.routeName,
            pageBuilder: (context, state)=>FadeTransitionPage(
              key: state.pageKey,
              child:  Dinner(),
            )
        ),
        GoRoute(
            path:PathName.eveningsnackpageRoute.path,
            name: PathName.eveningsnackpageRoute.routeName,
            pageBuilder: (context, state)=>FadeTransitionPage(
              key: state.pageKey,
              child: EveningSnack(),
            )
        ),
        GoRoute(
            path:PathName.afternoonpageRoute.path,
            name: PathName.afternoonpageRoute.routeName,
            pageBuilder: (context, state)=>FadeTransitionPage(
              key: state.pageKey,
              child:  AfternoonSnack(),
            )
        ),
        GoRoute(
            path:PathName.moriningsnackpageRoute.path,
            name: PathName.moriningsnackpageRoute.routeName,
            pageBuilder: (context, state)=>FadeTransitionPage(
              key: state.pageKey,
              child:  MoriningSnack(),
            )
        ),
        GoRoute(
          path: PathName.fooddetailpageRoute.path,  // e.g. '/food-detail'
          name: PathName.fooddetailpageRoute.routeName,
          pageBuilder: (context, state) {
            final args = state.extra as FoodDetailArgs;
            return FadeTransitionPage(
              key: state.pageKey,
              child: FoodDetailPage(
                food: args.food,
                mealType: args.mealType,
              ),
            );
          },
        ),



      ] ,
  );

}


/// The `FadeTransitionPage` class is a custom transition page that applies a fade animation to its
/// child widget.
class FadeTransitionPage extends CustomTransitionPage {
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
    transitionsBuilder: (c, animation, a2, child) => FadeTransition(
      opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
      child: child,
    ),
  );
}