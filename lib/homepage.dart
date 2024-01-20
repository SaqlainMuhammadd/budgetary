import 'package:budgetary_your_personal_finance_manager/NotificationScreen.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // child: Column(
            //   children: [
            //     Row(
            //       children: [
            //         SizedBox(
            //           height: 250,
            //         ),
            //         Text("Transaction History"),
            //       ],
            //     ),
            //     Row(
            //       children: [Icon(Icons.add)],
            //     )
            //   ],
            // ),
            height: height,
            width: width,
            decoration: BoxDecoration(color: Colors.blue[50]),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    'Good Afternoon',
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Muhammad Saqlain',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationScreen(),
                                ));
                          },
                          child: Icon(
                            Icons.notifications_active_sharp,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            height: height * 0.4,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.teal,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 3,
                      offset: Offset(0, 2))
                ]),
          ),
          Positioned(
            top: height * 0.25,
            left: width * 0.05,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Balance',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_drop_up,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 145,
                            ),
                            Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            )
                          ],
                        ),
                        Text(
                          'PKR   2,548.00',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: Colors.white, fontSize: 25),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_circle_down_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Income",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 105,
                            ),
                            Icon(
                              Icons.arrow_circle_up_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Expense",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Rs 1,840.00',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            Text(
                              'Rs 1,840.00',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  height: height * 0.26,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.teal[600],
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            spreadRadius: 3,
                            offset: Offset(0, 2))
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
