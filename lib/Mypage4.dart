import 'package:flutter/material.dart';

class Mypage4 extends StatefulWidget {
  const Mypage4({super.key});

  @override
  State<Mypage4> createState() => _Mypage4State();
}

class _Mypage4State extends State<Mypage4> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.09,
          ),
          Container(
            child: Image.asset('assets/images/Mypage4.png'),
          ),
          Container(
            child: Text(
              'Setup your Goals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.009,
                ),
                Center(
                  child: Text(
                      '               Track and follow what matters to you.               '),
                ),
                Center(
                  child: Text(
                      '               Save for important things.                 '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
