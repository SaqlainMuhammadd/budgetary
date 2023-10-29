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
                    child: Center(
                      child: ListTile(
                        iconColor: Colors.white,
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/facebooklogo.png'),
                        ),
                        title: Text('Saqlain Qureshi'),
                        subtitle: Text('Profile'),
                      ),
                    ),
                    height: height * 0.2,
                    width: width,
                    color: Colors.teal,
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile();
                    },
                  )
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
      color: Colors.blue,
    );
  }
}

class budgetandgoals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: const Color.fromARGB(255, 255, 187, 0),
    );
  }
}
