import 'package:budgetary_your_personal_finance_manager/notification.dart';
import 'package:flutter/material.dart';

class getpremiumscreen extends StatefulWidget {
  const getpremiumscreen({super.key});

  @override
  State<getpremiumscreen> createState() => _getpremiumscreenState();
}

class _getpremiumscreenState extends State<getpremiumscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Premimum'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
