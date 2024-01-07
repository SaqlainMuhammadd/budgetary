import 'package:budgetary_your_personal_finance_manager/Clipperr.dart';
import 'package:budgetary_your_personal_finance_manager/themeclass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                  width: width * 0.13,
                ),
                Text(
                  'Wallet',
                  style: GoogleFonts.aBeeZee(
                      color: MythemeClass.whitecolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  width: width * 0.13,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notification_add,
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      'Total Balance',
                      style: GoogleFonts.aBeeZee(
                          color: MythemeClass.black54color,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    Text(
                      'Rs2,548.000',
                      style: GoogleFonts.aBeeZee(
                          color: MythemeClass.blackcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: height * 0.07,
                          width: width * 0.13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: MythemeClass.tealcolor)),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: MythemeClass.tealcolor,
                              )),
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Container(
                          height: height * 0.07,
                          width: width * 0.13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: MythemeClass.tealcolor)),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.payments_rounded,
                                color: MythemeClass.tealcolor,
                              )),
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Container(
                          height: height * 0.07,
                          width: width * 0.13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: MythemeClass.tealcolor)),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.send,
                                color: MythemeClass.tealcolor,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ),
                        SizedBox(
                          width: width * 0.09,
                        ),
                        Text(
                          'Pay',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ),
                        SizedBox(
                          width: width * 0.09,
                        ),
                        Text(
                          'Send',
                          style: GoogleFonts.aBeeZee(
                              color: MythemeClass.blackcolor,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.07,
                    ),
                    Container(
                      height: height * 0.06,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(137, 220, 217, 217)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: height * 0.05,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: MythemeClass.whitecolor),
                            child: Center(
                              child: Text(
                                'Transactions',
                                style: GoogleFonts.aBeeZee(
                                    color: MythemeClass.blackcolor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.05,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: MythemeClass.whitecolor),
                            child: Center(
                              child: Text(
                                'Upcoming Bills',
                                style: GoogleFonts.aBeeZee(
                                    color: MythemeClass.blackcolor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      children: [
                        Container(
                          height: height * 0.06,
                          width: width * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/upwork-pngrepo-com.png"))),
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
                                  image: AssetImage(
                                      "assets/images/Onboarding.png"))),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Column(
                          children: [
                            Text(
                              'Transfer',
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
                                  image: AssetImage("assets/images/yt.jpg"))),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Column(
                          children: [
                            Text(
                              'YouTube',
                              style: GoogleFonts.aBeeZee(
                                  color: MythemeClass.blackcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            Text(
                              'Jan 12,2022',
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
                                  image: AssetImage("assets/images/ppal.jpg"))),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Column(
                          children: [
                            Text(
                              'Paypal',
                              style: GoogleFonts.aBeeZee(
                                  color: MythemeClass.blackcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            Text(
                              'jan 30,2022',
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
                    ),
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
