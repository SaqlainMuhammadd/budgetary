import 'package:flutter/material.dart';

class Mypage3 extends StatefulWidget {
  const Mypage3({super.key});

  @override
  State<Mypage3> createState() => _Mypage3State();
}

class _Mypage3State extends State<Mypage3> {
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
            child: Image.asset('assets/images/Mypage3.png'),
          ),
          Container(
            child: Text(
              'Track your Spending',
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
                      '               Track and analyze your spendings               '),
                ),
                Center(
                  child: Text(
                      '               immediately and automatically.                 '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
