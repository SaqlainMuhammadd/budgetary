import 'package:flutter/material.dart';

class PlannedpaymentsScreen extends StatefulWidget {
  const PlannedpaymentsScreen({super.key});

  @override
  State<PlannedpaymentsScreen> createState() => _PlannedpaymentsScreenState();
}

class _PlannedpaymentsScreenState extends State<PlannedpaymentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planned Payments'),
      ),
    );
  }
}
