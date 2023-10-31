import 'package:flutter/material.dart';

class Profileeditingscreen extends StatefulWidget {
  const Profileeditingscreen({super.key});

  @override
  State<Profileeditingscreen> createState() => _ProfileeditingscreenState();
}

class _ProfileeditingscreenState extends State<Profileeditingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(children: [
        Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Container(
                  child: Text('Name'),
                )
              ],
            )
          ],
        )
      ]),
    );
  }
}
