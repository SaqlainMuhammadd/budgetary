import 'package:flutter/material.dart';

class Mypage2 extends StatefulWidget {
  const Mypage2({super.key});

  @override
  State<Mypage2> createState() => _Mypage2State();
}

class _Mypage2State extends State<Mypage2> {
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
            child: Image.asset('assets/images/Mypage2.png'),
          ),
          Container(
            child: Text(
              'Connect your Bank Accounts',
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
                      '         Connect all your accounts from any bank.               '),
                ),
                Center(
                  child: Text(
                      '               Add savings, Credit cards, Paypal                 '),
                ),
                Center(
                  child: Text('               and more.                '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
