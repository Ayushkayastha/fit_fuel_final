
import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/extensions/text_theme_extention.dart';
import 'package:fit_fuel_final/core/route/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_assets/app_assets.dart';
import '../../../shared/components/custom_bottom_btn.dart';

class VerifyAccPage extends StatefulWidget {
  const VerifyAccPage({super.key});

  @override
  State<VerifyAccPage> createState() => _VerifyAccPageState();
}

class _VerifyAccPageState extends State<VerifyAccPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,size: 32.sp,),
          onPressed: (){
            context.go(PathName.signupPageRoute.path);
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
                    'Please Verify Your Account',
                    style: context.textTheme.headlineSmallEmphasized.copyWith(
                      letterSpacing: -1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h,),
              Text(
                AuthpageText.verifyText,
                style: context.textTheme.bodyLarge!.copyWith(
                  height: 24/16,
                  letterSpacing: 0,
                ),
              ),

              Spacer(),
              SizedBox(
                height: 176.h,
                width: 236.w,
                child: SvgPicture.asset(
                  AuthpageIcons.verifyAcc,
                ),
              ),


              Spacer(),
              CustomBottomBtn(
                  context: context,
                  name:"I'm verified",
                  callBack:(){
                    context.go(PathName.loginPageRoute.path);
                  }
              ),
              SizedBox(height: 16.h,),
              GestureDetector(
                onTap: (){},
                child: Container(
                  width:408.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color:Colors.transparent,
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                      color: context.colorScheme.outlineVariant, // Border color
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Resend Verification Link',
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );  }
}
