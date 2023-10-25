import 'package:flutter/material.dart';

class Mypage1 extends StatefulWidget {
  const Mypage1({super.key});

  @override
  State<Mypage1> createState() => _Mypage1State();
}

class _Mypage1State extends State<Mypage1> {
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
            child: Image.asset('assets/images/Mypage1.png'),
          ),
          Container(
            child: Text(
              'Your Finance in one Place',
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
                      '         Get the big picure on all your money.               '),
                ),
                Center(
                  child: Text(
                      '               Connect your bank accounts, savings,                 '),
                ),
                Center(
                  child: Text(
                      '               track cash and import data                '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
