import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snab_budget/Screens/home_screen.dart';
import 'package:snab_budget/apis/ApiStore.dart';
import 'package:snab_budget/apis/model/signup_model.dart';
import 'package:snab_budget/static_data.dart';
import 'package:dio/dio.dart' as deo;
import 'package:snab_budget/utils/apptheme.dart';

class LoginSignUPController extends GetxController {
  static LoginSignUPController get to => Get.find();

  Future signUp(SignupModel model) async {
    var res =
        await httpClient().post(StaticValues.registerUser, data: model.toMap());
    res.data['status'];
    if (res.statusCode == 200) {
      res.data['status'];
    }
    return res;
  }

  Future<bool> login(Map<String, dynamic> model, BuildContext context) async {
    bool v = false;
    deo.Response res =
        await httpClient().post(StaticValues.loginUser, data: model);
    if (res.statusCode == 200) {
      v = true;
      print(res.data);

      if (res.data["status"] == "Incorrect Email or Password") {
        Fluttertoast.showToast(
            msg: res.data["status"],
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 17,
            timeInSecForIosWeb: 1,
            toastLength: Toast.LENGTH_LONG);
      } else if (res.data["status"] == "Verify Your Email Address for Login") {
        Fluttertoast.showToast(
            msg: res.data["status"],
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 17,
            timeInSecForIosWeb: 1,
            toastLength: Toast.LENGTH_LONG);
      } else if (res.data["status"] == "Login Successfully") {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => const HomeScreen()),
            (Route<dynamic> route) => false);
        StaticValues.token = res.data["data"];
        setDataForIntro(res.data["data"]);
        Fluttertoast.showToast(
            msg: "Login Successfully",
            backgroundColor: AppTheme.colorPrimary,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 17,
            timeInSecForIosWeb: 1,
            toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(
            msg: res.data["status"],
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 17,
            timeInSecForIosWeb: 1,
            toastLength: Toast.LENGTH_LONG);
      }
    }

    return v;
  }

  setDataForIntro(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
