import 'package:budgetary_your_personal_finance_manager/Mypage1.dart';
import 'package:budgetary_your_personal_finance_manager/Mypage2.dart';
import 'package:budgetary_your_personal_finance_manager/Mypage3.dart';
import 'package:budgetary_your_personal_finance_manager/Mypage4.dart';
import 'package:budgetary_your_personal_finance_manager/Mypage5.dart';
import 'package:budgetary_your_personal_finance_manager/signup.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int selectedPage;
  late final PageController _pageController;

  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const pageCount = 5;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      selectedPage = page;
                    });
                  },
                  children: [
                    Mypage1(),
                    Mypage2(),
                    Mypage3(),
                    Mypage4(),
                    Mypage5(),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PageViewDotIndicator(
                currentItem: selectedPage,
                count: pageCount,
                unselectedColor: Colors.black26,
                selectedColor: Colors.blue,
                duration: const Duration(milliseconds: 200),
                boxShape: BoxShape.circle,
                unselectedSize: Size(8, 8),
                onItemClicked: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ));
                },
                child: Text('START NOW')),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
