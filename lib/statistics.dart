import 'package:budgetary_your_personal_finance_manager/themeclass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class statisticsScreen extends StatefulWidget {
  const statisticsScreen({super.key});

  @override
  State<statisticsScreen> createState() => _statisticsScreenState();
}

class _statisticsScreenState extends State<statisticsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(child: Text('Statistics')),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(Icons.download_rounded),
            )
          ],
        ),
        body: Container());
  }
}
