// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/Screens/auth/login.dart';

import 'package:snab_budget/apis/model/signup_model.dart';
import 'package:snab_budget/apis/controller/login_signup_controller.dart';

import '../home_screen.dart';

// ignore: must_be_immutable
class EmailVerificationScreen extends StatefulWidget {
  SignupModel model;
  EmailVerificationScreen({
    super.key,
    required this.model,
  });

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.emailsuccessverify)));

      timer?.cancel();

      LoginSignUPController.to.signUp(widget.model).then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => LoginScreen()));
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/icon.jpg',
                height: 100,
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '${AppLocalizations.of(context)!.checkyour} \n Email',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    "${AppLocalizations.of(context)!.wehavesentyouaemailon}${auth.currentUser?.email}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.verifyingemail,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 57),
            ],
          ),
        ),
      ),
    );
  }
}

final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
