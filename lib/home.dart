import 'package:budgetary_your_personal_finance_manager/notification.dart';
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
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.grid_on_rounded),
                      ),
                      title: Text('Statistics'),
                      trailing: DropdownButton<String>(
                        value: dropdownvalue,
                        icon: Icon(Icons.arrow_drop_down),
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                        items: const [
                          DropdownMenuItem<String>(
                              value: 'One', child: Text('One')),
                          DropdownMenuItem<String>(
                              value: 'Two', child: Text('Two')),
                          DropdownMenuItem<String>(
                              value: 'Three', child: Text('Three'))
                        ],
                      )),
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
    return Container(
      height: double.infinity,
    );
  }
}
