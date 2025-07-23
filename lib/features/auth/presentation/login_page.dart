
import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/extensions/text_theme_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/app_assets/app_assets.dart';
import '../../../core/route/path.dart';
import '../../../shared/components/custom_bottom_btn.dart';
import '../domain/notifier/login_notifier.dart';
import '../domain/provider/auth_state_provider.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _pwdController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _pwdController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 64.h),
             Container(
               height: 100.h,
               width: 100.w,
               decoration: BoxDecoration(
                 color: context.colorScheme.primaryContainer,
                 borderRadius: BorderRadius.circular(100.r),
               ),
             ),
              SizedBox(height: 32.h),
              Text(
                'Let’s Get Started!',
                style: context.textTheme.headlineLargeEmphasized.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 21.h),
              Text(
                'Lets dive into your account',
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              ),
              SizedBox(height: 42.h,),
              Row(
                children: [
                  Text(
                      'Email Address',
                      style: context.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  ),
                ],
              ),
              SizedBox(height: 11.h,),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined,size: 16.sp,),
                  hintText: 'Enter Email Adderess',
                ),
              ),
              SizedBox(height: 21.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Password',
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  InkWell(
                      onTap: (){
                        context.go(PathName.forgotpasswordPageRoute.path);
                      },
                      child: Text('Forgot Password?',style: context.textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),)
                  ),
                ],
              ),
              SizedBox(height: 11.h,),
              TextFormField(
                controller: _pwdController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: SizedBox(
                    height: 48.h,
                    width: 48.w,
                    child: Center(
                      child: SvgPicture.asset(
                        AuthpageIcons.lock,
                        height: 16.h,
                        width: 16.w,
                      ),
                    ),
                  ),
                  hintText: 'Enter Password',
                ),
              ),
              SizedBox(height: 32.h,),


              Padding(
                padding:  EdgeInsets.symmetric(vertical: 37.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account?',
                      style: context.textTheme.titleMedium,
                    ),
                    SizedBox(width: 8.w,),
                    InkWell(
                        onTap: (){
                          context.go(PathName.signupPageRoute.path);
                        },
                        child: Text('Sign up',style: context.textTheme.titleMediumEmphasized.copyWith(
                          color: context.colorScheme.secondaryContainer,
                        ),)
                    ),
                  ],
                ),
              ),

              CustomBottomBtn(
                context: context,
                name: 'Sign In',
                callBack: () async {
                  final String email = _emailController.text.trim();
                  final String password = _pwdController.text.trim();

                  // Show loader
                  context.pushNamed(
                    PathName.loaderPageRoute.routeName,
                    extra: 'Signing you in...',
                  );

                  final loginResult = await ref.read(loginNotifierProvider.notifier)
                      .loginWithEmailPassword(email, password);

                  context.pop(); // Close loader

                  if (loginResult && context.mounted) {
                    ref.invalidate(authStateProvider);
                    context.go(PathName.authgateRoute.path); // or LandingPage directly
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login failed')),
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
