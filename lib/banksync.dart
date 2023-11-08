import 'package:flutter/material.dart';

class banksyncscreen extends StatefulWidget {
  const banksyncscreen({super.key});

  @override
  State<banksyncscreen> createState() => _banksyncscreenState();
}

class _banksyncscreenState extends State<banksyncscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Sync'),
      ),
    );
  }
}
