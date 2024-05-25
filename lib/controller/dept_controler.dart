import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/Screens/debit_credit/deptsscreen.dart';
import 'package:snab_budget/controller/balanceProvider.dart';
import 'package:snab_budget/models/balance_data.dart';
import 'package:snab_budget/models/dept.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class DeptScreenController extends GetxController {
  static DeptScreenController get to => Get.find();
  TextEditingController balanceController = TextEditingController();
  TextEditingController currentDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController person = TextEditingController();
  TextEditingController noteController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  DateTime currentDate = DateTime.now();
  DateTime dueDate = DateTime.now();
  clearcontroller() {
    balanceController.clear();
    currentDateController.clear();
    dueDateController.clear();
    person.clear();
    noteController.clear();
    nameController.clear();
    amountController.clear();
  }

  void saveDeptData(
      BuildContext context,
      String balanceType,
      String balance,
      DateTime currentDate,
      DateTime dueDate,
      String person,
      String userId,
      String imgUrl,
      String note,
      height,
      width) async {
    final balanceData = BalanceData(
      balanceType: balanceType,
      balance: double.parse(balance),
      currentDate: currentDate,
      dueDate: dueDate,
      person: person,
      //  status: "unpaid",
    );

    Provider.of<BalanceProvider>(context, listen: false)
        .addBalance(balanceData);
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.rotate(
          angle: math.radians(a1.value * 360),
          child: AlertDialog(
            elevation: 10,
            shadowColor: AppTheme.colorPrimary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              height: height * 0.3,
              width: width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context)!.success,
                    style: TextStyle(
                        fontSize: width * 0.04,
                        color: AppTheme.colorPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.2,
                    width: width * 0.2,
                    child: Lottie.asset('assets/lottie_files/success.json'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => BalanceScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.2,
                      decoration: BoxDecoration(
                          color: AppTheme.colorPrimary,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.ok,
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 600),
    );

    Dept dept = Dept(
        id: DateTime.now().millisecond.toString(),
        status: "unpaid",
        type: balanceType,
        amount: int.parse(balance),
        // date: currentDate.toString().substring(0, 10),
        // backDate: dueDate.toString().substring(0, 10),
        date: currentDate,
        backDate: dueDate,
        paidamount: 0,
        to: person,
        imgUrl: imgUrl,
        note: note);

    await FirebaseFirestore.instance
        .collection("UserTransactions")
        .doc(userId)
        .collection("depts")
        .doc(dept.id)
        .set(dept.toJson());
  }

  Future<void> selectDate(BuildContext context,
      TextEditingController controller, DateTime initialDate) async {
    final DateTime? selectedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: AppTheme.colorPrimary,
              colorScheme: ColorScheme.light(primary: AppTheme.colorPrimary),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      controller.text = DateFormat.yMMMd().format(selectedDate);
      if (controller == currentDateController) {
        currentDate = selectedDate;
      } else if (controller == dueDateController) {
        dueDate = selectedDate;
      }
    }
    update();
  }
}
