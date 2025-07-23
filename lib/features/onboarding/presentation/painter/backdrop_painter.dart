import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackdropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final path_0 = Path();

    // Start from bottom right
    path_0.moveTo(width, height);

    // Bottom line
    path_0.lineTo(0, height);

    // Left side up
    path_0.lineTo(0, 9.13695.h);

    // Top left curve start
    path_0.cubicTo(
      0,
      4.08912.h,
      4.09207.w,
      -0.00292969.h,
      9.1399.w,
      -0.00292969.h,
    );
    path_0.cubicTo(
      12.03.w,
      -0.00292969.h,
      14.742.w,
      1.37106.h,
      16.5074.w,
      3.65925.h,
    );
    path_0.cubicTo(
      63.5944.w,
      64.6879.h,
      width / 2 - 100.w,
      104.h,
      width / 2,
      104.h,
    );
    path_0.cubicTo(
      width / 2 + 100.w,
      104.h,
      width - 63.5944.w,
      64.5741.h,
      width - 16.5074.w,
      3.39431.h,
    );
    path_0.cubicTo(
      width - 14.742.w,
      1.27062.h,
      width - 12.03.w,
      -0.00292969.h,
      width - 9.1399.w,
      -0.00292969.h,
    );
    path_0.cubicTo(
      width - 4.09207.w,
      -0.00292969.h,
      width,
      3.79118.h,
      width,
      8.47145.h,
    );

    // Right side down
    path_0.lineTo(width, height);

    path_0.close();

    // Fill color
    final paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xffFFEDE2);
    canvas.drawPath(path_0, paint_0_fill);

    // Create border for top curve only
    final path_top_border = Path();

    path_top_border.moveTo(0, 9.13695.h);
    path_top_border.cubicTo(
      0,
      4.08912.h,
      4.09207.w,
      -0.00292969.h,
      9.1399.w,
      -0.00292969.h,
    );
    path_top_border.cubicTo(
      12.03.w,
      -0.00292969.h,
      14.742.w,
      1.37106.h,
      16.5074.w,
      3.65925.h,
    );
    path_top_border.cubicTo(
      63.5944.w,
      64.6879.h,
      width / 2 - 100.w,
      104.h,
      width / 2,
      104.h,
    );
    path_top_border.cubicTo(
      width / 2 + 100.w,
      104.h,
      width - 63.5944.w,
      64.5741.h,
      width - 16.5074.w,
      3.39431.h,
    );
    path_top_border.cubicTo(
      width - 14.742.w,
      1.27062.h,
      width - 12.03.w,
      -0.00292969.h,
      width - 9.1399.w,
      -0.00292969.h,
    );
    path_top_border.cubicTo(
      width - 4.09207.w,
      -0.00292969.h,
      width,
      3.79118.h,
      width,
      8.47145.h,
    );

    final paint_2_border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5.w
      ..color = const Color(0xffDCC1AE);

    canvas.drawPath(path_top_border, paint_2_border);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
