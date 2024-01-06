import 'package:flutter/material.dart';

class statisticsScreen extends StatefulWidget {
  const statisticsScreen({super.key});

  @override
  State<statisticsScreen> createState() => _statisticsScreenState();
}

class _statisticsScreenState extends State<statisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
