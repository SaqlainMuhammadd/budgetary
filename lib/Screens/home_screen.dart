// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snab_budget/Screens/dashboard_home.dart';
import 'package:snab_budget/Screens/drawer_screen.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home-screen";
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Get.put(DashBoardController());
    super.initState();
  }

  double? height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: const Stack(
          children: [DrawerScreen(), DashBordHome()],
        ),
      ),
    );
  }
}
