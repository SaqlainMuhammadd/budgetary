import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snab_budget/Screens/auth/login.dart';
import 'package:snab_budget/apis/ApiStore.dart';
import 'package:snab_budget/apis/model/get_home_details.dart';
import 'package:snab_budget/apis/model/user_profile_model.dart';
import 'package:snab_budget/static_data.dart';
import 'package:snab_budget/utils/apptheme.dart';

class DashBoardController extends GetxController {
  static DashBoardController get to => Get.find();

  UserProfileModel? profileModel;
  String curency = "USD";
  String userNAme = '';
  String email = '';

  bool isDrawerOpen = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDataLoad = false;
  var colorList;
  var dataMap;
  double tIncomeAmount = 0.0;
  double balance = 0.0;
  double tExpenceAmount = 0.0;

  bool setGraph() {
    dataMap = <String, double>{
      "Income": tIncomeAmount,
      "expence": tExpenceAmount,
    };

    colorList = <Color>[Colors.green, Colors.red];
    update();
    return true;
  }

  Future<GetHomeDetails> getHomeDetailsdata() async {
    GetHomeDetails? getHomeDetails;
    isDataLoad = true;
    var res = await httpClient().get(StaticValues.getWalletDetails);
    if (res.statusCode == 200) {
      getHomeDetails = GetHomeDetails.fromMap(res.data);
      isDataLoad = false;
      tIncomeAmount = getHomeDetails.data!.totalIncome!;
      tExpenceAmount = getHomeDetails.data!.totalExpense!;
      curency = getHomeDetails.data!.currency!;
      balance = getHomeDetails.data!.balance!;
      print(" dkfgkd  ${getHomeDetails.data!.totalIncome} ");
      setGraph();
      return getHomeDetails;
    }
    update();
    return getHomeDetails!;
  }

  Future updateProfiledata(Map<String, dynamic> model, BuildContext c) async {
    isDataLoad = true;
    var res =
        await httpClient().post(StaticValues.updateProfileDetails, data: model);
    if (res.statusCode == 200) {
      getProfileDetailsdata();
    }
    Navigator.pop(c);
  }

  Future changePassworddata(Map<String, dynamic> model, BuildContext c) async {
    isDataLoad = true;
    var res = await httpClient().post(StaticValues.changePassword, data: model);
    if (res.statusCode == 200) {
      if (res.data["status"] == "Your Current Password doesn't Match") {
        Fluttertoast.showToast(
            msg: "Your Current Password doesn't Match",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 17,
            timeInSecForIosWeb: 1,
            toastLength: Toast.LENGTH_LONG);
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.getKeys();
        for (String key in preferences.getKeys()) {
          preferences.remove(key);
        }
        Fluttertoast.showToast(
            msg: "Password Change Successfully",
            backgroundColor: AppTheme.colorPrimary,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 17,
            timeInSecForIosWeb: 1,
            toastLength: Toast.LENGTH_LONG);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(c).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false);
        });
      }
      print(res.data["status"]);
    }
  }

  Future getProfileDetailsdata() async {
    var res = await httpClient().get(StaticValues.getProfileDetails);
    profileModel = UserProfileModel.fromMap(res.data);
    userNAme = profileModel!.data!.name!;
    email = profileModel!.data!.email!;
    isDataLoad = false;
    update();
  }

  movePage(bool value, double x, double y, double scale) {
    isDrawerOpen = value;
    xOffset = x;
    yOffset = y;
    scaleFactor = scale;
    update();
  }
}
