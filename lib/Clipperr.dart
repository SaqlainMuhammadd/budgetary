import 'package:flutter/material.dart';

class adminclipper extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var height = size.height;
    var width = size.width;

    var paint = Paint()..color = Colors.teal;

    Path path1 = Path();
    path1.moveTo(0, 0);
    path1.lineTo(width, 0);

    path1.lineTo(width, height * 0.83);
    path1.quadraticBezierTo(width * 0.5, height * 0.99, 0, height * 0.83);
    path1.lineTo(0, 0);

    path1.close();
    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
