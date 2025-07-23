import 'package:fit_fuel_final/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OptionCard extends StatelessWidget {
  final String label;
  final String svgAssetPath;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.label,
    required this.svgAssetPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 4.h),
        child: Card(
          shape: RoundedRectangleBorder(
            side: isSelected
                ? BorderSide(color: context.colorScheme.primaryContainer, width: 2)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
            child: Row(
              children: [
                SvgPicture.asset(
                  svgAssetPath,
                  height: 48.h,
                  width: 48.w,

                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
