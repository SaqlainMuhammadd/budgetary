import 'package:budgetary_your_personal_finance_manager/home.dart';
import 'package:budgetary_your_personal_finance_manager/signup.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              height: height * 0.3,
              width: width,
              color: Colors.teal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.2,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/logo.png",
                            ),
                            fit: BoxFit.cover),
                        color: Color.fromARGB(255, 255, 255, 255),
                        shape: BoxShape.circle),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Center(
              child: Container(
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width * 0.8,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      label: Text('Email')),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: width * 0.8,
                  child: TextField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.remove_red_eye),
                        label: Text('Password')),
                  ),
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                '                                                 Forgot Password?',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
                height: height * 0.06,
                width: width * 0.8,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    topRight: Radius.circular(3),
                    bottomRight: Radius.circular(3),
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: height * 0.05,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? "),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ));
                },
                child: Text(
                  "Sign up",
                  style: TextStyle(color: Colors.teal),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
