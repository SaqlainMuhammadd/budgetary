import 'package:budgetary_your_personal_finance_manager/login.dart';
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
          SizedBox(
            height: height * 0.05,
          ),
          Container(
            height: height * 0.09,
            width: width * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/signuplogo.png'),
                    fit: BoxFit.fill)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: height * 0.38,
                width: width * 0.9,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/signupscreen.png'),
                        fit: BoxFit.fill)),
              ),
            ),
          ),
          Text(
            'Welcome to Budgetary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text('You Just took the first step to get your money into'),
          Text('shape, Lets get started!'),
          SizedBox(
            height: height * 0.01,
          ),
          Container(
            width: width * 0.9,
            height: height * 0.07,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 255, 238),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  const BoxShadow(
                    color: Color.fromARGB(255, 75, 72, 72),
                    offset: Offset(
                      1.0,
                      1.0,
                    ),
                    blurRadius: 2.0,
                    spreadRadius: 0.05,
                  ),
                ]),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset('assets/images/googleicon.png'),
                  SizedBox(
                    width: width * 0.17,
                  ),
                  Text(
                    "Sign Up with Google",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Container(
            width: width * 0.9,
            height: height * 0.07,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 255, 238),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  const BoxShadow(
                    color: Color.fromARGB(255, 75, 72, 72),
                    offset: Offset(
                      1.0,
                      1.0,
                    ),
                    blurRadius: 2.0,
                    spreadRadius: 0.05,
                  ),
                ]),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset('assets/images/facebooklogo.png'),
                  SizedBox(
                    width: width * 0.17,
                  ),
                  Text(
                    "Sign Up with Facebook",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Container(
            width: width * 0.9,
            height: height * 0.07,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 255, 238),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  const BoxShadow(
                    color: Color.fromARGB(255, 75, 72, 72),
                    offset: Offset(
                      1.0,
                      1.0,
                    ),
                    blurRadius: 2.0,
                    spreadRadius: 0.05,
                  ),
                ]),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset('assets/images/emailicon.png'),
                  SizedBox(
                    width: width * 0.17,
                  ),
                  Text(
                    "Sign Up with E-mail",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Text('Already have account?'),
          InkWell(
              child: new Text(
                'Login here',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Loginscreen()));
              }),
        ],
      ),
    );
  }
}
