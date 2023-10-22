import 'package:flutter/material.dart';

class Emailsignup extends StatefulWidget {
  const Emailsignup({super.key});

  @override
  State<Emailsignup> createState() => _EmailsignupState();
}

class _EmailsignupState extends State<Emailsignup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [TextField()],
        ),
      ),
    );
  }
}
