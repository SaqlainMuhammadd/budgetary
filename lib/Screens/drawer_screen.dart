// Drawer Screen

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snab_budget/Screens/accounts.dart';
import 'package:snab_budget/Screens/auth/login.dart';
import 'package:snab_budget/Screens/budget/budget.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/Screens/calender.dart';
import 'package:snab_budget/Screens/debit_credit/deptsscreen.dart';
import 'package:snab_budget/Screens/home_screen.dart';
import 'package:snab_budget/Screens/preferences.dart';
import 'package:snab_budget/Screens/setting_screen.dart';
import 'package:snab_budget/Screens/summary_screen.dart';
import 'package:snab_budget/Screens/transactions_screen.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/utils/apptheme.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with TickerProviderStateMixin {
  bool isAnimate = false;
  AnimationController? controller;
  Animation<double>? animation;
  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(
        seconds: 2,
      ),
      vsync: this,
      value: 0.1,
    )..repeat(reverse: true);
    animation = CurvedAnimation(
      parent: controller!,
      curve: Curves.easeIn,
    );
    controller!.forward();
    super.initState();
  }

  num snabbWallet = 0;

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          height: height,
          width: width,
          color: AppTheme.colorPrimary,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.05),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        width: width * 0.2,
                        color: Colors.white,
                      ),
                    ),
                    drawerTile(
                        context,
                        "assets/images/home-icon.png",
                        AppLocalizations.of(context)!.dashboard,
                        HomeScreen.routeName),
                    drawerTile(
                        context,
                        "assets/images/user.png",
                        "${AppLocalizations.of(context)!.accounts} ",
                        Accounts.routeName),
                    drawerTile(context, "assets/images/dollar.png", "DR/CR",
                        BalanceScreen.routeName),
                    drawerTile(
                        context,
                        "assets/images/box.png",
                        "${AppLocalizations.of(context)!.budget} ",
                        BudgetScreen.routeName),
                    drawerTile(
                        context,
                        "assets/images/calender.png",
                        "${AppLocalizations.of(context)!.calendar} ",
                        CalenderScreen.routeName),
                    drawerTile(
                        context,
                        "assets/images/summary.png",
                        "${AppLocalizations.of(context)!.summary} ",
                        SummaryScreen.routeName),
                    drawerTile(
                        context,
                        "assets/images/transfer.png",
                        "${AppLocalizations.of(context)!.transactions} ",
                        TransactionsScreen.routeName),
                    drawerTile(
                        context,
                        "assets/images/clock.png",
                        "${AppLocalizations.of(context)!.schedule}\n${AppLocalizations.of(context)!.transactions} ",
                        "Schedule-Transactions"),
                    drawerTile(
                        context,
                        "assets/images/settings.png",
                        "${AppLocalizations.of(context)!.settings} ",
                        SettingScreen.routeName),
                    drawerTile(
                        context,
                        "assets/images/settings-2.png",
                        "${AppLocalizations.of(context)!.preferences} ",
                        PreferencesScreen.routeName),
                    Column(
                      children: [
                        const Divider(
                          color: Colors.white,
                          thickness: 2,
                          indent: 40,
                          endIndent: 40,
                        ),
                        ListTile(
                            onTap: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.getKeys();
                              for (String key in preferences.getKeys()) {
                                preferences.remove(key);
                              }
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (Route<dynamic> route) => false);
                              });
                              DashBoardController.to.movePage(false, 0, 0, 1);
                            },
                            leading: const Icon(
                              Icons.logout_rounded,
                              color: Colors.white,
                              size: 38,
                            ),
                            title: Text(
                              AppLocalizations.of(context)!.logout,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  ListTile drawerTile(
      BuildContext context, String imgUrl, String title, String routeName) {
    return ListTile(
      leading: ImageIcon(
        AssetImage(imgUrl),
        color: Colors.white,
        size: width * 0.07,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: width * 0.03, color: Colors.white),
      ),
      onTap: () {
        DashBoardController.to.movePage(false, 0, 0, 1);
        if (title == "Transactions") {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransactionsScreen(),
              ));
        } else if (title == "Summary") {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SummaryScreen(snabbWallet: snabbWallet),
              ));
        } else {
          Navigator.of(context).pushNamed(routeName);
        }
      },
    );
  }
}
