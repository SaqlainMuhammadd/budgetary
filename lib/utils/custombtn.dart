// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final String title;
  final double borderrad;
  final VoidCallback onaction;
  final Color color1;
  final Color color2;
  final double width;

  const MyCustomButton(
      {super.key,
      required this.title,
      required this.borderrad,
      required this.onaction,
      required this.color1,
      required this.color2,
      required this.width});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onaction,
      child: Container(
        height: 60,
        width: width,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
            ),
            borderRadius: BorderRadius.circular(borderrad)),
      ),
    );
  }
}
