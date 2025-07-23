import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressBar extends StatelessWidget {
  final VoidCallback onPressed;
  final int number;

  const ProgressBar({
    super.key,
    required this.onPressed,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.all(0),
          onPressed: onPressed,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        Stack(
          children: [
            Container(
              height: 12.h,
              width: 290.w,
              decoration: BoxDecoration(
                color: context.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
            Container(
              height: 12.h,
              width:(29*number).w,
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
          ],
        ),
        SizedBox(width: 18.w,),
        Text(
          '$number/10',
          style: context.textTheme.titleMedium,
        )
      ],
    );
  }
}
