import 'package:budgetary_your_personal_finance_manager/signup.dart';
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
    var width = MediaQuery.of(context).size.width;
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
              'Your Personal Finance Manager',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Center(
                  child: Text(
                      '         Get the big picture on all your finances. Connect               '),
                ),
                Center(
                  child: Text(
                      '               your bank, track cash, split bills,                '),
                ),
                Center(
                  child:
                      Text('               and import data.                '),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.09,
          ),
          OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(),
                    ));
              },
              child: Text('START NOW'))
        ],
      ),
    );
  }
}
