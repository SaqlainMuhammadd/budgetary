import 'package:budgetary_your_personal_finance_manager/Profile.dart';
import 'package:budgetary_your_personal_finance_manager/Transactiondetail.dart';
import 'package:budgetary_your_personal_finance_manager/WalletScreen.dart';
import 'package:budgetary_your_personal_finance_manager/homepage.dart';
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
    const Transactiondetailscreen_screen(),
    const WalletScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Trade'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_travel_sharp), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        unselectedItemColor: MythemeClass.black54color,
        selectedItemColor: Colors.teal,
      ),
    );
  }
}
