import 'package:budgetary_your_personal_finance_manager/banksync.dart';
import 'package:budgetary_your_personal_finance_manager/getpremium.dart';
import 'package:budgetary_your_personal_finance_manager/notification.dart';
import 'package:budgetary_your_personal_finance_manager/plannedpayments.dart';
import 'package:budgetary_your_personal_finance_manager/records.dart';
import 'package:budgetary_your_personal_finance_manager/reports.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownvalue = 'One';

  @override
  Widget build(BuildContext context) {
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => getpremiumscreen(),
                          ));
                    },
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.gpp_good_outlined,
                          color: Colors.teal,
                        ),
                      ),
                      title: Text('Get Premium'),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => banksyncscreen(),
                          ));
                    },
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.home_work_outlined,
                          color: Colors.teal,
                        ),
                      ),
                      title: Text('Bank Sync'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportsScreen(),
                          ));
                    },
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add_chart_rounded,
                          color: Colors.teal,
                        ),
                      ),
                      title: Text('Reports'),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    },
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.home,
                          color: Colors.teal,
                        ),
                      ),
                      title: Text('Home'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecordsScreen(),
                          ));
                    },
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.grid_on_rounded,
                          color: Colors.teal,
                        ),
                      ),
                      title: Text('Records'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlannedpaymentsScreen(),
                          ));
                    },
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.send_time_extension_sharp,
                          color: Colors.teal,
                        ),
                      ),
                      title: Text('Planned Payments'),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.payments_sharp,
                        color: Colors.teal,
                      ),
                    ),
                    title: Text('Budgets'),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.payments_sharp,
                        color: Colors.teal,
                      ),
                    ),
                    title: Text('Debts'),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.track_changes_rounded,
                        color: Colors.teal,
                      ),
                    ),
                    title: Text('Goals'),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.business_center_rounded,
                        color: Colors.teal,
                      ),
                    ),
                    title: Text('Wallet For Business'),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.teal,
                      ),
                    ),
                    title: Text('Shopping List'),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.currency_exchange,
                        color: Colors.teal,
                      ),
                    ),
                    title: Text('Currency Rates'),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.person_pin_outlined,
                        color: Colors.teal,
                      ),
                    ),
                    title: Text('Invite Friends'),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.share,
                        color: Colors.teal,
                      ),
                    ),
                    title: Text('Follow Us'),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.question_answer_sharp,
                        color: Colors.teal,
                      ),
                    ),
                    title: Text('Help'),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.settings_outlined,
                        color: Colors.teal,
                      ),
                    ),
                    title: Text('Settings'),
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
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'List of Accounts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 130,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.settings),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 95),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CASH',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$0.00',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                height: 55,
                width: 165,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'ADD ACCOUNT',
                        style: TextStyle(color: Colors.teal),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.teal,
                      )
                    ],
                  ),
                  height: 55,
                  width: 165,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.teal),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class budgetandgoals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 400,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}
