import 'package:flutter/material.dart';

class Mypage6 extends StatefulWidget {
  const Mypage6({super.key});

  @override
  State<Mypage6> createState() => _Mypage6State();
}

class _Mypage6State extends State<Mypage6> {
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
            child: Image.asset('assets/images/Mypage6.png'),
          ),
          Container(
            child: Text(
              'Follow your Plans and Dreams',
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
                      '               Built your financial life. Make the right               '),
                ),
                Center(
                  child: Text(
                      '               financial descisions.                 '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
