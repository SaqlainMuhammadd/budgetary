import 'package:budgetary_your_personal_finance_manager/Clipperr.dart';
import 'package:budgetary_your_personal_finance_manager/themeclass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                  width: width * 0.13,
                ),
                Text(
                  'Profile',
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
            top: height * 0.25,
            left: width * 0.4,
            child: Container(
              height: height * 0.11,
              width: width * 0.20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  image: const DecorationImage(
                      image:
                          AssetImage("assets/images/IMG_20231117_144452.jpg"),
                      fit: BoxFit.cover),
                  color: Colors.amber),
            ),
          ),
          Positioned(
            top: height * 0.35,
            child: SizedBox(
              height: height * 0.7,
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Muhammad Saqlain',
                    style: GoogleFonts.aBeeZee(
                        color: MythemeClass.blackcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Text(
                    'saqlainqureshi12@gmail.com',
                    style: GoogleFonts.aBeeZee(
                        color: MythemeClass.black54color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.diamond_outlined,
                            color: MythemeClass.blackcolor,
                          )),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Invite Friends',
                        style: GoogleFonts.aBeeZee(
                            color: MythemeClass.blackcolor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.person,
                            color: MythemeClass.blackcolor,
                          )),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Account Info',
                        style: GoogleFonts.aBeeZee(
                            color: MythemeClass.blackcolor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.person,
                            color: MythemeClass.blackcolor,
                          )),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Personal Profile',
                        style: GoogleFonts.aBeeZee(
                            color: MythemeClass.blackcolor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.message,
                            color: MythemeClass.blackcolor,
                          )),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Message center',
                        style: GoogleFonts.aBeeZee(
                            color: MythemeClass.blackcolor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.security,
                            color: MythemeClass.blackcolor,
                          )),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Login and security',
                        style: GoogleFonts.aBeeZee(
                            color: MythemeClass.blackcolor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.private_connectivity_sharp,
                            color: MythemeClass.blackcolor,
                          )),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        'Data and Privacy',
                        style: GoogleFonts.aBeeZee(
                            color: MythemeClass.blackcolor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
