import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget CustomBottomBtn({
  required BuildContext context,
   double? width,
   double? height,
  required String name,
  required VoidCallback callBack,
  IconData? icon,
}){
  return InkWell(
    onTap: callBack,
    child: Container(
      width: (width??408).w,
      height: (height??56).h,
      decoration: BoxDecoration(
        color:context.colorScheme.primary,
        borderRadius: BorderRadius.circular(100.r)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(icon!=null)...[
            Icon(
                icon,
              size: 15.sp,
              color: context.colorScheme.onPrimary,
            ),
            SizedBox(width: 4.w,),
          ],
          Text(
            name,
            style: context.textTheme.labelLarge!.copyWith(
              color: context.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    ),
  );
}