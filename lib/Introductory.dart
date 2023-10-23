import 'package:budgetary_your_personal_finance_manager/Mypage1.dart';
import 'package:budgetary_your_personal_finance_manager/login.dart';
import 'package:flutter/material.dart';

class IntroductoryScreen extends StatefulWidget {
  const IntroductoryScreen({super.key});

  @override
  State<IntroductoryScreen> createState() => _IntroductoryScreenState();
}

class _IntroductoryScreenState extends State<IntroductoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: PageController(initialPage: 1),
      children: [
        Mypage1(),
      ],
    ));
  }
}
