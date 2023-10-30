import 'package:budgetary_your_personal_finance_manager/Profileeditingscreen.dart';
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
              child: ListView(
                children: [
                  Container(
                    color: Colors.teal,
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Saqlain Qureshi',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.gpp_good_outlined),
                    ),
                    title: Text('Get Premium'),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.home_work_outlined),
                    ),
                    title: Text('Bank Sync'),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.home),
                    ),
                    title: Text('Home'),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.grid_on_rounded),
                    ),
                    title: Text('Records'),
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
