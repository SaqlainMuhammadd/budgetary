import 'package:flutter/material.dart';

class LoginClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, height);
    path.quadraticBezierTo(0, height * 0.8, width * 0.2, height * 0.8);

    path.lineTo(width * 0.8, height * 0.8);

    path.quadraticBezierTo(width * 1.1, height * 0.8, width, height * 0.4);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
