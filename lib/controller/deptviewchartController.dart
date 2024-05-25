import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import '../apis/model/add_debit_model.dart';
import '../models/dept.dart';

class ViewDesbitController extends GetxController {
  static ViewDesbitController get to => Get.find();

  List<int> mounthamount = [];
  int maximumincome = 0;
  List<Dept> debtCreditlst = [];
  //  List<tr.Transaction> transactions = [];
  // List<tr.Transaction> incomeTransactions = [];
  int totalincome = 0;
  int income() {
    totalincome = 0;
    for (var i = 0; i < mounthamount.length; i++) {
      totalincome = totalincome + mounthamount[i];
    }
    print("totalincome:$totalincome");
    return totalincome;
  }

  List<FlSpot> list = [];

  fetchDebtsCreditstransaction(
      List<DebitCreditTransactions> debittransactionlist) async {
    debtCreditlst.clear();
    mounthamount = List<int>.filled(12, 0);
    for (var document in debittransactionlist) {
      print("date  ${document.date}");
      DateTime monthDate = DateFormat('MM-dd-yyyy').parse(document.date!);

      String dateformat = DateFormat('M').format(monthDate);
      int month = int.parse(dateformat);
      print("Month: $month");
      mounthamount[month - 1] =
          (mounthamount[month - 1] + (document.amount!.toInt()));
      print(document.amount);
    }

    checking();
    update();
  }

  checking() {
    list = [const FlSpot(0, 0)];
    print("-------88-------");
    print(mounthamount.length);
    //  print("--------------");
//
    int desiredResult = 10;
    int y4 = 0;
    int y3 = 0;
    for (var v = 0; v < mounthamount.length; v++) {
      int monthIndex = v + 1;
      int count = mounthamount[v];
      maximumincome = findMaxValueWithIndex(mounthamount);
      y3 = maximumincome ~/ desiredResult;
      //   print("ysfwf:$y3");
      if (y3 == 0) {
        y4 = 0;
      } else {
        //  print("||||  $y3");
        y4 = count ~/ y3;
        update();
      }

      list.add(FlSpot(monthIndex.toDouble(), y4.toDouble()));
    }
    print("this is list $list");
    update();
  }

  int findMaxValueWithIndex(List<int> numbers) {
    if (numbers.isEmpty) {
      throw ArgumentError('The list is empty');
    }

    int max = numbers[0];
    int maxIndex = 0;

    for (int i = 1; i < numbers.length; i++) {
      if (numbers[i] > max) {
        max = numbers[i];
        maxIndex = i;
      }
    }
    return max;
  }
}
