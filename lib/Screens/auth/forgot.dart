import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/Screens/auth/login.dart';
import 'package:snab_budget/apis/ApiStore.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import 'package:snab_budget/utils/custombtn.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../static_data.dart';

class ForgitPassword extends StatefulWidget {
  static const String idScreen = 'forgotpass';

  const ForgitPassword({super.key});

  @override
  State<ForgitPassword> createState() => _ForgitPasswordState();
}

class _ForgitPasswordState extends State<ForgitPassword> {
  final TextEditingController _email = TextEditingController();
  //key for handling Auth
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  Future<void> resetPassword() async {
    try {
      var result = await httpClient()
          .post('${StaticValues.forgotpassword}${_email.text}');

      print("respomse ${result.statusCode}");

      print("Password reset email sent successfully");
    } catch (e) {
      print("Failed to send password reset email: $e");
    }
  }

  void _showetoast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<BrightnessProvider>(builder: (context, provider, bv) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Form(
              key: formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.13,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        color: AppTheme.colorPrimary,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: size.width * 0.065,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.1,
                          ),
                          Text(
                            AppLocalizations.of(context)!.forget,
                            style: TextStyle(
                                fontSize: size.width * 0.04,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: size.width * 0.21,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  Text(
                    AppLocalizations.of(context)!.resetyourpassword,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: provider.brightness == AppBrightness.dark
                            ? AppTheme.colorWhite
                            : AppTheme.colorPrimary),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (!RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                              .hasMatch(value!)) {
                            return "${AppLocalizations.of(context)!.pleaseenteranemail}";
                          }
                          return null;
                        },
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.colorPrimary),
                        controller: _email,
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.enteryouremail,
                          hintStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.colorPrimary),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),

                            borderRadius: BorderRadius.circular(
                                20), // Set border radius here
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppTheme.colorPrimary),

                            borderRadius: BorderRadius.circular(
                                20), // Set border radius here
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(
                                20), // Set border radius here
                          ),
                          filled: true,
                          fillColor: const Color(0xffeceff6),
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.visiblePassword),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  MyCustomButton(
                      title: "${AppLocalizations.of(context)!.save}",
                      borderrad: 25,
                      onaction: () {
                        if (formGlobalKey.currentState!.validate()) {
                          resetPassword();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                          _showetoast(
                              AppLocalizations.of(context)!.detailsendemail);
                        } else {
                          _showetoast(
                              "${AppLocalizations.of(context)!.pleaseenteravalidemailaddress}");
                        }
                      },
                      color1: AppTheme.colorPrimary,
                      color2: AppTheme.colorPrimary,
                      width: MediaQuery.of(context).size.width - 50),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
