import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecorationTheme textFormTheme(ColorScheme colorScheme, TextTheme textTheme)
{
  final outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(
      color: colorScheme.outline,
      width: 1.w,
    ),
  );


return InputDecorationTheme(
  filled: true,
  fillColor:colorScheme.onInverseSurface,
  contentPadding: EdgeInsets.symmetric(horizontal: 12.h,vertical: 16.h),
  hintStyle: textTheme.bodyMedium!.copyWith(color: colorScheme.outline,),
  border: outlineBorder,
  enabledBorder: outlineBorder,
  focusedBorder: outlineBorder,
  errorBorder: outlineBorder.copyWith(borderSide: BorderSide(color: colorScheme.error)),
  focusedErrorBorder: outlineBorder,
);
}