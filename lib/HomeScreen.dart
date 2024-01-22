import 'package:budgetary_your_personal_finance_manager/Addexpense.dart';
import 'package:budgetary_your_personal_finance_manager/Profile.dart';
import 'package:budgetary_your_personal_finance_manager/WalletScreen.dart';
import 'package:budgetary_your_personal_finance_manager/homepage.dart';
import 'package:budgetary_your_personal_finance_manager/statistics.dart';
import 'package:budgetary_your_personal_finance_manager/themeclass.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const homepage(),
    const WalletScreen(),
    const AddExpense_Screen(),
    const statisticsScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Set the selected tab index
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.teal,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.wallet,
                color: Colors.teal,
              ),
              label: 'Wallet'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: Colors.teal,
              ),
              label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.trending_up_outlined,
                size: 24.0,
                color: Colors.teal,
              ),
              label: 'Statistics'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.teal,
              ),
              label: 'Profile'),
        ],
        unselectedItemColor: MythemeClass.black54color,
        selectedItemColor: Colors.teal,
      ),
    );
  }
}
