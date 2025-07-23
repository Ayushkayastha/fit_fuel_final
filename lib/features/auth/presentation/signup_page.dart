
import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/extensions/text_theme_extention.dart';
import 'package:fit_fuel_final/features/auth/presentation/provider/checkbox_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_assets/app_assets.dart';
import '../../../core/route/path.dart';
import '../../../shared/components/custom_bottom_btn.dart';
import '../data/models/register_request_model.dart';
import '../domain/provider/auth_repository_provider.dart';


class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  TextEditingController _nameController=TextEditingController();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _pwdController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    _nameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final isboxChecked=ref.watch(checkboxProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            context.go(PathName.loginPageRoute.path);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                style: context.textTheme.headlineLargeEmphasized,
              ),
              SizedBox(height: 21.h),
              Text(
                'Join App name Today',
                style: context.textTheme.titleMedium,
              ),
              SizedBox(height: 32.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: context.textTheme.titleMedium,
                  ),

                ],
              ),
              SizedBox(height: 11.h,),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon:Icon(Icons.person) ,
                  hintText: 'Enter Name',
                ),
              ),
              SizedBox(height: 21.h,),
              Row(
                children: [
                  Text(
                    'Email Address',
                    style: context.textTheme.titleMedium,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: context.textTheme.titleMedium,
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
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 32.h),
                child: Row(
                  children: [
                    Checkbox(
                        value: isboxChecked,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        onChanged:(value){
                          ref.read(checkboxProvider.notifier).state=value!;
                        }
                    ),
                    Text(
                      'I agree to app Name',
                      style: context.textTheme.bodyLarge,
                    ),

                    InkWell(
                        onTap: (){},
                        child: Text('Terms & Condition',style: context.textTheme.bodyLarge!.copyWith(
                          color: context.colorScheme.secondaryContainer,
                        ),)
                    ),
                  ],
                ),
              ),


              Padding(
                padding:  EdgeInsets.symmetric(vertical: 32.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account?',
                      style: context.textTheme.titleMedium,
                    ),

                    InkWell(

                        onTap: (){
                          context.go(PathName.loginPageRoute.path);
                        },
                        child: Text('Sign in',style: context.textTheme.titleMediumEmphasized.copyWith(
                          color: context.colorScheme.secondaryContainer,
                        ),)
                    ),
                  ],
                ),
              ),

              CustomBottomBtn(
                context: context,
                name: 'Sign Up',
                callBack: () async {
                  final authRepo = ref.read(authRepositoryProvider);
                  final name = _nameController.text.trim();
                  final email = _emailController.text.trim();
                  final password = _pwdController.text;

                  if (name.isEmpty || email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }

                  try {
                    context.pushNamed(
                      PathName.loaderPageRoute.routeName,
                      extra: 'Signing you Up...',
                    );
                    final response = await authRepo.registerUser(
                      RegisterRequestModel(name: name, email: email, password: password),
                    );
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(response.message)),
                    );

                    context.go(PathName.verifyaccpageRoute.path);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                    context.pop();

                  }
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
