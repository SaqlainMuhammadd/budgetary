import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: height * 0.4,
          width: width,
          color: Colors.teal,
          child: Container(
            height: height * 0.001,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                shape: BoxShape.circle),
          ),
        )
      ],
    ));
  }
}
