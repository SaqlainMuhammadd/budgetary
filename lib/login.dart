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
        body: Container(
      height: height * 0.4,
      width: width,
      color: Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height * 0.2,
            width: width * 0.4,
            decoration: BoxDecoration(
                //image: DecorationImage(
                //image: AssetImage(
                //    "assets/images/logosignin.png",
                //  ),
                //      fit: BoxFit.cover),
                color: Color.fromARGB(255, 255, 255, 255),
                shape: BoxShape.circle),
          ),
        ],
      ),
    ));
  }
}
