import 'package:flutter/material.dart';

class CreategoalScreen extends StatefulWidget {
  const CreategoalScreen({super.key});

  @override
  State<CreategoalScreen> createState() => _CreategoalScreenState();
}

class _CreategoalScreenState extends State<CreategoalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Goal'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 330,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Goal Name',
                ),
              ),
            ),
          ),
          Container(
            height: 10,
          ),
          Center(
            child: Container(
              width: 330,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Goal Name',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
