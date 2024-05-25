// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_import, duplicate_import, use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snab_budget/Screens/auth/change_pass.dart';
import 'package:snab_budget/Screens/auth/forgot.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import 'package:snab_budget/utils/spinkit.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:snab_budget/Screens/auth/login.dart';
import '../../../models/usermodel.dart';
import '../../../utils/mycolors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../utils/custom_drawer.dart';
import 'editprofile.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ProfileView extends StatefulWidget {
  // final String name;
  // final String email;
  const ProfileView({
    super.key,
    // required this.name, required this.email
  });
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // String userId = FirebaseAuth.instance.currentUser!.uid;

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    // getConnectivity();
    super.initState();
  }

  // getConnectivity() =>
  //     subscription = Connectivity().onConnectivityChanged.listen(
  //       (ConnectivityResult result) async {
  //         isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //         if (!isDeviceConnected && isAlertSet == false) {
  //           showDialogBox();
  //           setState(() => isAlertSet = true);
  //         }
  //       },
  //     );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    final applan = AppLocalizations.of(context)!;

    // final controller = Get.put(ProfileController());
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetBuilder<DashBoardController>(builder: (obj) {
      return Scaffold(
        extendBody: true,
        //backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child:
                Consumer<BrightnessProvider>(builder: (context, provider, bv) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Card(
                  //   color: bgcolor,
                  //   elevation: 3,
                  //   child: Row(
                  //     children: [
                  //       IconButton(
                  //           onPressed: () {
                  //             _scaffoldKey.currentState?.openDrawer();
                  //           },
                  //           icon: const ImageIcon(
                  //             AssetImage("assets/images/menu.png"),
                  //             size: 40,
                  //           )),
                  //       ShaderMask(
                  //         shaderCallback: (bounds) => const LinearGradient(
                  //           colors: [Colors.black, Colors.black],
                  //         ).createShader(bounds),
                  //         child: const Text(
                  //           "Debts",
                  //           style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold),
                  //         ).pSymmetric(h: 130),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    height: height * 0.1,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        color: AppTheme.colorPrimary,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.025,
                          right: width * 0.05,
                          left: width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            obj.profileModel!.data!.name!.toUpperCase(),
                            style: TextStyle(
                                fontSize: width * 0.04,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            height: height * 0.05,
                            width: width * 0.1,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              Icons.person,
                              color: AppTheme.colorPrimary,
                              size: width * 0.065,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.15,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(children: [
                      Card(
                        shadowColor: AppTheme.colorPrimary,
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: Icon(
                            Icons.mail,
                            size: MediaQuery.of(context).size.width * 0.08,
                            color: provider.brightness == AppBrightness.dark
                                ? AppTheme.colorWhite
                                : AppTheme.colorPrimary,
                          ),
                          subtitle: Text(
                            obj.profileModel!.data!.email!,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.changeemail,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: Icon(CupertinoIcons.right_chevron),
                            onPressed: () {},
                            // onPressed: () {
                            //   email.text = obj.profileModel!.data!.email!;
                            //   showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return AlertDialog(
                            //         title: Text(
                            //           '${AppLocalizations.of(context)!.changeemail}:',
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //         content: SizedBox(
                            //           height:
                            //               MediaQuery.of(context).size.height *
                            //                   0.2,
                            //           width: MediaQuery.of(context).size.width *
                            //               0.8,
                            //           child: Column(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceEvenly,
                            //             children: [
                            //               TextFormField(
                            //                 cursorColor: AppTheme.colorPrimary,
                            //                 style: TextStyle(
                            //                     color: provider.brightness ==
                            //                             AppBrightness.dark
                            //                         ? AppTheme.colorWhite
                            //                         : AppTheme.colorPrimary),
                            //                 textInputAction:
                            //                     TextInputAction.done,
                            //                 decoration: InputDecoration(
                            //                   hintStyle: TextStyle(
                            //                       fontSize: 18,
                            //                       color: AppTheme.colorPrimary,
                            //                       fontWeight: FontWeight.bold),
                            //                   labelText:
                            //                       "${AppLocalizations.of(context)!.emailAddress}",
                            //                   labelStyle: TextStyle(
                            //                       fontSize: 18,
                            //                       color: provider.brightness ==
                            //                               AppBrightness.dark
                            //                           ? AppTheme.colorWhite
                            //                           : AppTheme.colorPrimary,
                            //                       fontWeight: FontWeight.bold),
                            //                   errorStyle: TextStyle(
                            //                       color: Colors.black),
                            //                   contentPadding:
                            //                       EdgeInsets.symmetric(
                            //                           vertical: 0,
                            //                           horizontal: 20),
                            //                   fillColor: Colors.grey,
                            //                   alignLabelWithHint: true,
                            //                   enabledBorder: OutlineInputBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(10),
                            //                     borderSide: BorderSide(
                            //                         color: provider
                            //                                     .brightness ==
                            //                                 AppBrightness.dark
                            //                             ? AppTheme.colorWhite
                            //                             : AppTheme
                            //                                 .colorPrimary),
                            //                   ),
                            //                   focusedBorder: OutlineInputBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(10),
                            //                     borderSide: BorderSide(
                            //                         color: provider
                            //                                     .brightness ==
                            //                                 AppBrightness.dark
                            //                             ? AppTheme.colorWhite
                            //                             : AppTheme
                            //                                 .colorPrimary),
                            //                   ),
                            //                 ),
                            //                 controller: email,
                            //               ),
                            //               Card(
                            //                 elevation: 7,
                            //                 shadowColor: AppTheme.colorPrimary,
                            //                 shape: RoundedRectangleBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(10)),
                            //                 child: InkWell(
                            //                   onTap: () {},
                            //                   child: Container(
                            //                     height: MediaQuery.of(context)
                            //                             .size
                            //                             .height *
                            //                         0.06,
                            //                     width: MediaQuery.of(context)
                            //                             .size
                            //                             .width *
                            //                         0.6,
                            //                     decoration: BoxDecoration(
                            //                       color: AppTheme.colorPrimary,
                            //                       borderRadius:
                            //                           BorderRadius.circular(10),
                            //                     ),
                            //                     child: Center(
                            //                       child: Text(
                            //                         AppLocalizations.of(
                            //                                 context)!
                            //                             .update,
                            //                         style: TextStyle(
                            //                             fontSize: 20,
                            //                             fontWeight:
                            //                                 FontWeight.bold,
                            //                             color: Colors.white),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   );
                            // },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Card(
                        shadowColor: AppTheme.colorPrimary,
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            size: MediaQuery.of(context).size.width * 0.08,
                            color: provider.brightness == AppBrightness.dark
                                ? AppTheme.colorWhite
                                : AppTheme.colorPrimary,
                          ),
                          subtitle: Text(
                            obj.profileModel!.data!.name!,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.changename,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: Icon(CupertinoIcons.right_chevron),
                            onPressed: () {
                              name.text = obj.profileModel!.data!.name!;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      '${AppLocalizations.of(context)!.changename}:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextFormField(
                                                  cursorColor:
                                                      AppTheme.colorPrimary,
                                                  style: TextStyle(
                                                      color: provider
                                                                  .brightness ==
                                                              AppBrightness.dark
                                                          ? AppTheme.colorWhite
                                                          : AppTheme
                                                              .colorPrimary),
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .name,
                                                    labelStyle: TextStyle(
                                                        fontSize: 18,
                                                        color: provider
                                                                    .brightness ==
                                                                AppBrightness
                                                                    .dark
                                                            ? AppTheme
                                                                .colorWhite
                                                            : AppTheme
                                                                .colorPrimary,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    errorStyle: TextStyle(
                                                        color: Colors.black),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0,
                                                            horizontal: 20),
                                                    fillColor: Colors.grey,
                                                    alignLabelWithHint: true,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: provider.brightness ==
                                                                  AppBrightness
                                                                      .dark
                                                              ? AppTheme
                                                                  .colorWhite
                                                              : AppTheme
                                                                  .colorPrimary),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: provider.brightness ==
                                                                  AppBrightness
                                                                      .dark
                                                              ? AppTheme
                                                                  .colorWhite
                                                              : AppTheme
                                                                  .colorPrimary),
                                                    ),
                                                  ),
                                                  controller: name,
                                                ),
                                                Card(
                                                  elevation: 7,
                                                  shadowColor:
                                                      AppTheme.colorPrimary,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Map<String, dynamic> map =
                                                          {
                                                        "name": name.text,
                                                        "email": obj
                                                            .profileModel!
                                                            .data!
                                                            .email!
                                                      };

                                                      obj.updateProfiledata(
                                                          map, context);
                                                    },
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.06,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme
                                                            .colorPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .update,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          obj.isDataLoad == true
                                              ? Container(
                                                  height: height,
                                                  width: width,
                                                  color: AppTheme.colorPrimary
                                                      .withOpacity(0.5),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: height * 0.4),
                                                    child: Center(
                                                      child: SizedBox(
                                                        height: height * 0.1,
                                                        width: width * 0.2,
                                                        child:
                                                            SpinKit.loadSpinkit,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Card(
                        shadowColor: AppTheme.colorPrimary,
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: Icon(
                            Icons.key,
                            size: MediaQuery.of(context).size.width * 0.08,
                            color: provider.brightness == AppBrightness.dark
                                ? AppTheme.colorWhite
                                : AppTheme.colorPrimary,
                          ),
                          subtitle: Text(
                            "********",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            "Change Password",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: Icon(CupertinoIcons.right_chevron),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          ChangePasswordScreen()));
                            },
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Consumer<BrightnessProvider>(
                              builder: (context, value, v) {
                            return AlertDialog(
                              title: Text(
                                'Confirm Logout',
                                style: TextStyle(
                                  color: value.brightness == AppBrightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              content: Text(
                                'Are you sure you want to Logout?',
                                style: TextStyle(
                                  color: value.brightness == AppBrightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    // Close the dialog when Cancel is pressed
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color:
                                          value.brightness == AppBrightness.dark
                                              ? Colors.white
                                              : AppTheme.colorPrimary,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .all<Color>(const Color.fromARGB(
                                            255,
                                            17,
                                            41,
                                            73)), // Set the custom color here
                                  ),
                                  onPressed: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    preferences.getKeys();
                                    for (String key in preferences.getKeys()) {
                                      preferences.remove(key);
                                    }
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                          (Route<dynamic> route) => false);
                                    });
                                  },
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                //signOut();
                              },
                              icon: Icon(
                                Icons.logout_rounded,
                                color: Colors.red,
                                size: MediaQuery.of(context).size.width * 0.08,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${AppLocalizations.of(context)!.logout}",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      );
    });
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(AppLocalizations.of(context)!.noconnection),
          content: Text(AppLocalizations.of(context)!.pleasecheckconnection),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(
                    context, "${AppLocalizations.of(context)!.cancel}");
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: Text(AppLocalizations.of(context)!.ok),
            ),
          ],
        ),
      );
}
