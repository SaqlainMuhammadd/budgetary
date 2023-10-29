import 'package:budgetary_your_personal_finance_manager/notification.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Home'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ));
                    },
                    icon: Icon(Icons.notifications),
                  ),
                )
              ],
              bottom: const TabBar(tabs: [
                Tab(
                  child: Text('Accounts'),
                ),
                Tab(
                  child: Text('Budget & Goals'),
                )
              ]),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: height * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.white, width: 2),
                              shape: BoxShape.circle),
                        )
                      ],
                    ),
                    height: height * 0.2,
                    width: width,
                    color: Colors.teal,
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [accounts(), budgetandgoals()],
            )));
  }
}

class accounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
    );
  }
}

class budgetandgoals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
    );
  }
}
