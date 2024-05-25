// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_import, duplicate_import, use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:provider/provider.dart';
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

class ChangePasswordScreen extends StatefulWidget {
  // final String name;
  // final String email;
  const ChangePasswordScreen({
    super.key,
    // required this.name, required this.email
  });
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController currentPassword = TextEditingController();

  // String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetBuilder<DashBoardController>(builder: (obj) {
      return Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          child: SafeArea(
            child:
                Consumer<BrightnessProvider>(builder: (context, provider, bv) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                            "Change Password".toUpperCase(),
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
                              Icons.key,
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
                        child: SizedBox(
                          height: height * 0.07,
                          child: TextFormField(
                            cursorColor: AppTheme.colorPrimary,
                            style: TextStyle(
                                color: provider.brightness == AppBrightness.dark
                                    ? AppTheme.colorWhite
                                    : AppTheme.colorPrimary),
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: "Old Password",
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  color:
                                      provider.brightness == AppBrightness.dark
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorPrimary,
                                  fontWeight: FontWeight.bold),
                              errorStyle: TextStyle(color: Colors.black),
                              // contentPadding: EdgeInsets.symmetric(
                              //     vertical: 0, horizontal: 20),
                              fillColor: Colors.grey,
                              alignLabelWithHint: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: provider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: provider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary),
                              ),
                            ),
                            controller: currentPassword,
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
                        child: SizedBox(
                          height: height * 0.07,
                          child: TextFormField(
                            cursorColor: AppTheme.colorPrimary,
                            style: TextStyle(
                                color: provider.brightness == AppBrightness.dark
                                    ? AppTheme.colorWhite
                                    : AppTheme.colorPrimary),
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: "New Password",
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  color:
                                      provider.brightness == AppBrightness.dark
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorPrimary,
                                  fontWeight: FontWeight.bold),
                              errorStyle: TextStyle(color: Colors.black),
                              // contentPadding: EdgeInsets.symmetric(
                              //     vertical: 0, horizontal: 20),
                              fillColor: Colors.grey,
                              alignLabelWithHint: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: provider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: provider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary),
                              ),
                            ),
                            controller: newPassword,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Card(
                        elevation: 7,
                        shadowColor: AppTheme.colorPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: () {
                            Map<String, dynamic> map = {
                              "currentPassword": currentPassword.text,
                              "newPassword": newPassword.text
                            };

                            obj.changePassworddata(map, context);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              color: AppTheme.colorPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.update,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              );
            }),
          ),
        ),
      );
    });
  }
}
