
import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/extensions/text_theme_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/route/path.dart';
import '../../../../shared/components/custom_bottom_btn.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,size: 32.sp,),
          onPressed: (){
            context.go(PathName.loginPageRoute.path);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 22.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Forgot Password ?',
                    style: context.textTheme.headlineLargeEmphasized.copyWith(
                      letterSpacing: -1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h,),
              Text(
                AuthpageText.forgotText,
                style: context.textTheme.bodyLarge!.copyWith(
                  height: 24/16,
                ),
              ),
              SizedBox(height: 32.h,),
              Row(
                children: [
                  Text(
                    'Associated Email Address',
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined,size: 16.sp,),
                  hintText: 'Enter Email Adderess',
                ),
              ),


              Spacer(),
              CustomBottomBtn(
                  context: context,
                  name:'Recover Password',
                  callBack:(){
                    context.go(PathName.newpasswordPageRoute.path);
                  }
              ),
            ],
          ),
        ),
      ),

    );

}
}