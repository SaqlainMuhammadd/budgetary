import 'package:flutter/foundation.dart';

import '../models/balance_data.dart';

class BalanceProvider extends ChangeNotifier {
  List<BalanceData> balanceList = [];
  double totalBalance = 0;

  void addBalance(BalanceData balanceData) {
    balanceList.add(balanceData);
    calculateTotalBalance();
    notifyListeners();
  }

  void deleteBalance(int index) {
    BalanceData removedBalance = balanceList.removeAt(index);
    if (removedBalance.balanceType == "Credit") {
      totalBalance -= removedBalance.balance;
    } else if (removedBalance.balanceType == "Debit") {
      totalBalance += removedBalance.balance;
    }
    notifyListeners();
  }

  // void deleteBalance(int index) {
  //   balanceList.removeAt(index);
  //   calculateTotalBalance();
  //   notifyListeners();
  // }

  void calculateTotalBalance() {
    double total = 0;
    for (var balanceData in balanceList) {
      if (balanceData.balanceType == "Credit") {
        total += balanceData.balance;
      } else if (balanceData.balanceType == "Debit") {
        total -= balanceData.balance;
      }
    }
    totalBalance = total;
  }
}
