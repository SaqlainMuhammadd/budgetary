import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snab_budget/Screens/home_screen.dart';
import 'package:snab_budget/Screens/introduction.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/static_data.dart';
import 'package:snab_budget/utils/apptheme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  var height, width;
  bool isAnimate = false;
  AnimationController? controller;
  Animation<double>? animation;
  @override
  void initState() {
    Get.put(TransactionController());

    geValuesSF();
    controller = AnimationController(
      duration: const Duration(
        seconds: 2,
      ),
      vsync: this,
      value: 0.1,
    )..repeat(reverse: false);
    animation = CurvedAnimation(
      parent: controller!,
      curve: Curves.easeIn,
    );
    controller!.forward();
    super.initState();
  }

  geValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    if (token != null) {
      StaticValues.token = token;
      Future.delayed(const Duration(milliseconds: 2500), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false);
      });
    } else {
      Future.delayed(const Duration(milliseconds: 2500), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => IntroductionScreensPage()),
            (Route<dynamic> route) => false);
      });
    }
  }

  @override
  dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: AppTheme.colorPrimary,
        child: Center(
          child: ScaleTransition(
            scale: animation!,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: height * 0.6,
              width: width * 0.6,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
