import 'package:flutter/material.dart';

class Mypage5 extends StatefulWidget {
  const Mypage5({super.key});

  @override
  State<Mypage5> createState() => _Mypage5State();
}

class _Mypage5State extends State<Mypage5> {
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
            child: Image.asset('assets/images/Mypage5.png'),
          ),
          Container(
            child: Text(
              'Budget your Money',
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
                      '               Built Healthy financial habits.               '),
                ),
                Center(
                  child: Text(
                      '               Control your spendings.                 '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
