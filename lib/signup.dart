import 'dart:io';

import 'package:budgetary_your_personal_finance_manager/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Icon(
              Icons.wallet,
              size: 180,
              color: Colors.white,
            ),
            height: height * 0.3,
            width: width,
            color: Colors.teal,
          ),
          SizedBox(
            height: height * 0.07,
          ),
          Text(
            'Signup Below to create\n       secure account',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.07,
          ),
          Container(
            height: height * 0.06,
            width: width * 0.8,
            decoration: BoxDecoration(
                color: Colors.teal, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                    ),
                    child: Icon(
                      Icons.facebook,
                      size: 40,
                      color: Colors.teal,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.08,
                ),
                Text(
                  'CONNECT WITH FACEBOOK',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Container(
            height: height * 0.06,
            width: width * 0.8,
            decoration: BoxDecoration(
                color: Colors.teal, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                    ),
                    child: Image.asset('assets/images/googleicon.png'),
                  ),
                ),
                SizedBox(
                  width: width * 0.08,
                ),
                Text(
                  'CONNECT WITH GOOGLE',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Container(
            height: height * 0.06,
            width: width * 0.8,
            decoration: BoxDecoration(
                color: Colors.teal, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                    ),
                    child: Icon(
                      Icons.email,
                      size: 30,
                      color: Colors.teal,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.08,
                ),
                Text(
                  'CONNECT WITH EMAIL',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account? '),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Loginscreen(),
                      ));
                },
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Loginscreen(),
                        ));
                  },
                  child: Text(
                    'LOG IN',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: height * 0.12,
          color: Colors.teal,
          child: Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text:
                                  'By signing up or connecting with the services above you agree to our ',
                              style: TextStyle()),
                          TextSpan(
                              text: 'Terms of Service ',
                              style: TextStyle(color: Colors.black),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                          TextSpan(text: 'and acknowledge our '),
                          TextSpan(
                              text: 'Privacy Policy ',
                              style: TextStyle(color: Colors.black),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                          TextSpan(
                            text: 'describing how we process your data.',
                          )
                        ])),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
