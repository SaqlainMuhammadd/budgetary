import 'package:budgetary_your_personal_finance_manager/Signup.dart';
import 'package:budgetary_your_personal_finance_manager/signin.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: height * 0.5,
              width: width * 0.5,
              child: Image.asset('assets/images/onboarding.png'),
            ),
          ),
          Center(
            child: Text(
              'SPEND SMARTER\n     SAVE MORE',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => signupScreen(),
                    ));
              },
              child: Container(
                child: Center(
                  child: Text(
                    'GET STARTED',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 15),
                  ),
                ),
                width: width * 0.5,
                height: height * 0.05,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                        spreadRadius: 0.5,
                      )
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text('Already have an account?'),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SigninScreen(),
                  ));
            },
            child: Text(
              'Sign in',
              style: TextStyle(color: Colors.teal, shadows: [
                Shadow(
                    color: Colors.black38, blurRadius: 5, offset: Offset(0, 1))
              ]),
            ),
          )
        ],
      ),
    );
  }
}
