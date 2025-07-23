import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/extensions/text_theme_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/route/path.dart';
import '../../../../shared/components/custom_bottom_btn.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController _pwdController=TextEditingController();
  TextEditingController _pwdconfirmController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pwdController.dispose();
    _pwdconfirmController.dispose();
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
                    'Enter New Password',
                    style: context.textTheme.headlineLargeEmphasized.copyWith(
                      letterSpacing: -1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h,),
              Text(
                AuthpageText.newpwdText,
                style: context.textTheme.bodyLarge!.copyWith(
                  height: 24/16,
                ),
              ),

              SizedBox(height: 16.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Create new password',
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10.h,),
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
              SizedBox(height: 16.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Confirm New Password',
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10.h,),
              TextFormField(
                controller: _pwdconfirmController,
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

              Spacer(),
              CustomBottomBtn(
                  context: context,
                  name:'Recover Password',
                  callBack:(){
                    context.go(PathName.allsetPageRoute.path);
                  }
              ),
            ],
          ),
        ),
      ),

    );
  }
}
