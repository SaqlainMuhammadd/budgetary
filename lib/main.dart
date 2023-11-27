import 'package:budgetary_your_personal_finance_manager/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budgetary',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.blue[50],
          primarySwatch: Colors.teal,
          textTheme: TextTheme(
            displayLarge: TextStyle(
                fontFamily: 'montserrat',
                fontSize: 25,
                color: Colors.teal,
                fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
          )),
      home: const Splashscreen(),
    );
  }
}
