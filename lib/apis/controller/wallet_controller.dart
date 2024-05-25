import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:snab_budget/apis/ApiStore.dart';
import 'package:snab_budget/apis/model/user_wallet_model.dart';
import 'package:snab_budget/static_data.dart';
import 'package:snab_budget/utils/currency_model.dart';

class WalletController extends GetxController {
  static WalletController get to => Get.find();
  UserWalletModel? walletModel;

  List<Data> walletList = [];

  CurrencyModell? selectedcurrency;
  bool isLoadData = false;

  changeCurrency(CurrencyModell model) {
    selectedcurrency = model;
    update();
  }

  changeStatus(bool v) {
    isLoadData = v;
    update();
  }

  Future adddWalletdata(Map<String, dynamic> model, BuildContext c) async {
    changeStatus(true);
    var res = await httpClient().post(StaticValues.addWalletData, data: model);
    if (res.statusCode == 200) {
      changeStatus(false);
      getWalletdata();
    }
    Navigator.pop(c);
  }

  Future deleteWalletdata(String id, BuildContext c) async {
    var res = await httpClient().delete("${StaticValues.deleteWalletData}$id");
    if (res.statusCode == 200) {
      getWalletdata();
      Fluttertoast.showToast(
          msg: res.data["status"],
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          fontSize: 17,
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_LONG);
      update();
    }
  }

  Future getWalletdata() async {
    walletList.clear();

    isLoadData = true;
    var res = await httpClient().get(StaticValues.getWalletList);
    walletModel = UserWalletModel.fromMap(res.data);
    for (var wallet in walletModel!.data!) {
      walletList.add(wallet);
    }

    isLoadData = false;
    update();
  }
}
