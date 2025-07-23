import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:fit_fuel_final/core/extensions/text_theme_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/route/path.dart';
import '../../../../shared/components/custom_bottom_btn.dart';

class AllSet extends StatefulWidget {
  const AllSet({super.key});

  @override
  State<AllSet> createState() => _AllSetState();
}

class _AllSetState extends State<AllSet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:SafeArea(
        child:Column(
          children: [
            SizedBox(height: 217.h,),
            Image.asset(
              AuthpageGif.allSet,
              height: 150.h,
              width: 150.h,
            ),
            SizedBox(height: 17.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                'You Are All Set',
              style: context.textTheme.headlineSmallEmphasized.copyWith(
                fontWeight: FontWeight.w600,
              ),
              )
            ],),
            SizedBox(height: 32.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                'You have successfully changed your password',
              style: context.textTheme.bodyMedium,
              )
            ],),
            Spacer(),
            CustomBottomBtn(
                context: context,
                name:'Sign In',
                callBack:(){
                  context.go(PathName.signupPageRoute.path);
                }
            ),
          ],
        )
    ),
    );
  }
}
