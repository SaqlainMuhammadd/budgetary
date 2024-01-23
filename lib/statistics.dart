import 'package:budgetary_your_personal_finance_manager/themeclass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class statisticsScreen extends StatefulWidget {
  const statisticsScreen({super.key});

  @override
  State<statisticsScreen> createState() => _statisticsScreenState();
}

class _statisticsScreenState extends State<statisticsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(child: Text('Statistics')),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(Icons.download_rounded),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 249, 250, 250),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          textStyle: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255)),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Week',
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                        )),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        textStyle: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Month',
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        textStyle: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Year',
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      )),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   // child: Container(child: LineChartgraph()),
                // ),
                SizedBox(
                  height: height * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        'Total Spending',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        width: width * 0.4,
                      ),
                      Icon(Icons.compare_arrows_outlined)
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.4,
                ),
                Column(
                  children: [
                    Container(
                      height: height * 0.06,
                      width: width * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/upwork.png"))),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Column(
                      children: [
                        Text(
                          'Upwork',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          'Today',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.black54color,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '+850,00',
                      style: GoogleFonts.aBeeZee(
                          color: MythemeClass.black54color,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    Container(
                      height: height * 0.06,
                      width: width * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/Facebook.png"))),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Column(
                      children: [
                        Text(
                          'Facebook',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          'Yesterday',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.black54color,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '+750,00',
                      style: GoogleFonts.aBeeZee(
                          color: MythemeClass.black54color,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
