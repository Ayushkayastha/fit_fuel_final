import 'dart:ui' as ui;

import 'package:flutter/material.dart';



//Copy this CustomPainter code to the Bottom of the File
class RPSCustomTriangle extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {

Path path_0 = Path();
path_0.moveTo(3.99999,28.9282);
path_0.cubicTo(-1.33334,25.849,-1.33333,18.151,4,15.0718);
path_0.lineTo(28,1.21539);
path_0.cubicTo(33.3333,-1.86382,40,1.98519,40,8.14359);
path_0.lineTo(40,35.8564);
path_0.cubicTo(40,42.0148,33.3333,45.8638,28,42.7846);
path_0.lineTo(3.99999,28.9282);
path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Color(0xffFB8C00).withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
return true;
}
}