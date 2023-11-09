import 'package:flutter/material.dart';

class CreatebudgetScreen extends StatefulWidget {
  const CreatebudgetScreen({super.key});

  @override
  State<CreatebudgetScreen> createState() => _CreatebudgetScreenState();
}

class _CreatebudgetScreenState extends State<CreatebudgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Budget'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.check),
          )
        ],
      ),
      body: TextFormField(
        decoration: InputDecoration(
          labelText: 'Budget Name',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
