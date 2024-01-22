import 'package:budgetary_your_personal_finance_manager/Clipperr.dart';
import 'package:budgetary_your_personal_finance_manager/themeclass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class Transactiondetailscreen_screen extends StatefulWidget {
  const Transactiondetailscreen_screen({super.key});

  @override
  State<Transactiondetailscreen_screen> createState() =>
      _Transactiondetailscreen_screenState();
}

// ignore: camel_case_types
class _Transactiondetailscreen_screenState
    extends State<Transactiondetailscreen_screen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
          ),
          Container(
            height: height * 0.35,
            width: width,
            color: Colors.transparent,
            child: CustomPaint(
              painter: adminclipper(),
            ),
          ),
          Positioned(
            top: height * 0.05,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.13,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: MythemeClass.whitecolor,
                    )),
                SizedBox(
                  width: width * 0.05,
                ),
                Text(
                  'Tractions Detail',
                  style: GoogleFonts.aBeeZee(
                      color: MythemeClass.whitecolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  width: width * 0.05,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: MythemeClass.whitecolor,
                    )),
              ],
            ),
          ),
          Positioned(
            top: height * 0.18,
            child: Container(
              height: height * 0.73,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: MythemeClass.whitecolor),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      height: height * 0.07,
                      width: width * 0.13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/IMG_20231117_144452.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Expense',
                      style: GoogleFonts.aBeeZee(
                          color: MythemeClass.redcolor,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                    Text(
                      'Rs2,548.00',
                      style: GoogleFonts.aBeeZee(
                          color: MythemeClass.blackcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          'Transaction details',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.keyboard_arrow_up,
                              color: MythemeClass.blackcolor,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Status',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.black54color,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          'Expense',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.redcolor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          'To',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.black54color,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          'Umar',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          'Time',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.black54color,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          '04:30 PM',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          'Date',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.black54color,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          'Dec 4,2023',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Text(
                          'Time',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.black54color,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          '04:30 PM',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          'Spending',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.black54color,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          'Rs2,548.00',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          'Fee',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.black54color,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          '-0.99',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          'Rs2,547.00',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      height: height * 0.05,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: MythemeClass.tealcolor)),
                      child: Center(
                        child: Text(
                          'Download Reciept',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.tealcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
