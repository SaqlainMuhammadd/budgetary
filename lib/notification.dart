import 'package:budgetary_your_personal_finance_manager/home.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              icon: Icon(Icons.search)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                IconButton(onPressed: () {}, icon: Icon(Icons.question_mark)),
          )
        ],
      ),
    );
  }
}
