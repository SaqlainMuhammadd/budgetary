import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snab_budget/Screens/auth/profileview.dart';
import 'package:snab_budget/Screens/daily_stats.dart';
import 'package:snab_budget/Screens/dashboard_screen.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/apis/controller/wallet_controller.dart';
import 'package:snab_budget/utils/custom_bottombar.dart';
import 'package:snab_budget/utils/expandable_fab.dart';

class DashBordHome extends StatefulWidget {
  const DashBordHome({super.key});

  @override
  State<DashBordHome> createState() => _DashBordHomeState();
}

class _DashBordHomeState extends State<DashBordHome> {
  var height, width;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  int check = 0;
  late PageController _pageController;
  DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();
    Get.put(WalletController());
    TransactionController.to.getCatagoriesdata("income");
    TransactionController.to.fetchTransaction();
    TransactionController.to.fetchRecycleTransaction();
    TransactionController.to.getLineGraphDataList(now.year);
    TransactionController.to.getIncomeExpenceGraph(now.year);
    _pageController = PageController(initialPage: _selectedIndex);
    // TransactionController.to.getInfo();
    // TransactionController.to.fetchTransaction();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    final List<Widget> pages = [
      DashboardScreen(),
      DailyStats(),
      const ProfileView(),
    ];
    return GetBuilder<DashBoardController>(
      builder: (obj) {
        return AnimatedContainer(
            transform: Matrix4.translationValues(obj.xOffset, obj.yOffset, 0)
              ..scale(obj.scaleFactor)
              ..rotateY(obj.isDrawerOpen ? -0.5 : 0),
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius:
                    BorderRadius.circular(obj.isDrawerOpen == true ? 40 : 0.0)),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: scaffoldKey,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              floatingActionButton: const ExpandableFloatingActionButton(
                  // balance: balance, snabbWallet: snabbWallet
                  ),
              body: SizedBox(
                height: height,
                width: width,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: pages,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
              bottomNavigationBar: CustomBottomBar(
                selectedIndex: _selectedIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  });
                },
              ),
            ));
      },
    );
  }
}
