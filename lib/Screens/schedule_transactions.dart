import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/apis/ApiStore.dart';
import 'package:snab_budget/models/scheduled_transaction.dart';
import 'package:snab_budget/models/transaction.dart';
import 'package:snab_budget/static_data.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import 'package:snab_budget/utils/schedule_ex.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ScheduleTransactions extends StatefulWidget {
  static const routeName = "Schedule-Transactions";

  const ScheduleTransactions({Key? key}) : super(key: key);

  @override
  State<ScheduleTransactions> createState() => _ScheduleTransactionsState();
}

class _ScheduleTransactionsState extends State<ScheduleTransactions> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<ScheduleTransactionData> transactions = [];
  int thisMonth = 0;
  int nextMonth = 0;
  bool isLoadConfirm = false;
  num balance = 0;
  int check = 0;
  num snabbWallet = 0;
  // final String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    getCurrency();
    fetchTransactions();
  }

  String? currency = "";
  getCurrency() async {
    // CurrencyData currencyData = CurrencyData();
    // currency = await currencyData.fetchCurrency(userId);
    // //currency = currencyData.currency;
    print(currency);
  }

  void getInfo() async {
    // var docSnapshot2 = await FirebaseFirestore.instance
    //     .collection("UserTransactions")
    //     .doc(userId)
    //     .collection("data")
    //     .doc("userData")
    //     .get();
    // if (docSnapshot2.exists) {
    //   Map<String, dynamic>? data = docSnapshot2.data();
    //   setState(() {
    //     balance = data!["balance"];
    //   });
    // }
    // var docSnapshot3 = await FirebaseFirestore.instance
    //     .collection('UserTransactions')
    //     .doc(userId)
    //     .collection("Accounts")
    //     .doc("snabbWallet")
    //     .get();
    // if (docSnapshot3.exists) {
    //   Map<String, dynamic>? data = docSnapshot3.data();
    //   setState(() {
    //     snabbWallet = data!["amount"];
    //   });
    // }
    // print(userId);
  }
  ScheduleTransactionModel? schedulemodel;
  Future<ScheduleTransactionModel> fetchTransactions() async {
    var result = await httpClient().get(StaticValues.getscheduleTransaction);
    schedulemodel = ScheduleTransactionModel.fromJson(result.data);
    print("model length ${schedulemodel!.data!.length}");
    for (var document in schedulemodel!.data!) {
      transactions.add(document);
    }
    setState(() {});
    calculateTotalAmount(transactions);
    return schedulemodel!;
  }

  void calculateTotalAmount(List<ScheduleTransactionData> transactions) {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int nextMonth = currentMonth + 1;
    int localThisMonth = 0;
    int localNextMonth = 0;

    for (ScheduleTransactionData transaction in transactions) {
      DateFormat format = DateFormat("d/M/yyyy");
      DateTime date = format.parse(transaction.dateTime!);
      int amount = transaction.amount!.truncate();
      print("amount $date");

      if (date.year == currentYear && date.month == currentMonth) {
        if (transaction.type == 0) {
          localThisMonth -= amount;
        } else {
          localThisMonth += amount;
        }
      }
      if (date.year == currentYear && date.month == nextMonth) {
        if (transaction.type == 0) {
          localNextMonth -= amount;
        } else {
          localNextMonth += amount;
        }
      }
    }

    setState(() {
      thisMonth = localThisMonth;
      nextMonth = localNextMonth;
      print("thissssss month $thisMonth nexxxxt month $nextMonth");
    });
  }

  Future<void> showImageDialog(
      BuildContext context, ScheduleTransactionData obj) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10,
          shadowColor: AppTheme.colorPrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content:
              Consumer<BrightnessProvider>(builder: (context, provider, f) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context)!.transationdetails,
                            style: TextStyle(
                                color: provider.brightness == AppBrightness.dark
                                    ? AppTheme.colorWhite
                                    : AppTheme.colorPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "${AppLocalizations.of(context)!.walletname}: ",
                                    style: TextStyle(
                                        color: provider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(obj.name.toString()),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context)!.repeat}: ",
                                        style: TextStyle(
                                            color: provider.brightness ==
                                                    AppBrightness.dark
                                                ? AppTheme.colorWhite
                                                : AppTheme.colorPrimary,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(obj.schedule!.repeats.toString()),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context)!.amount}: ",
                                        style: TextStyle(
                                            color: provider.brightness ==
                                                    AppBrightness.dark
                                                ? AppTheme.colorWhite
                                                : AppTheme.colorPrimary,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(obj.amount.toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context)!.cname}: ",
                                        style: TextStyle(
                                            color: provider.brightness ==
                                                    AppBrightness.dark
                                                ? AppTheme.colorWhite
                                                : AppTheme.colorPrimary,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(obj.category!),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context)!.date}: ",
                                        style: TextStyle(
                                            color: provider.brightness ==
                                                    AppBrightness.dark
                                                ? AppTheme.colorWhite
                                                : AppTheme.colorPrimary,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(obj.dateTime.toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "${AppLocalizations.of(context)!.notes}: ",
                                  style: TextStyle(
                                      color: provider.brightness ==
                                              AppBrightness.dark
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorPrimary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(obj.note!),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: obj.file != null && obj.file != ""
                                  ? Hero(
                                      tag: obj.file!,
                                      child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        placeholder: 'assets/images/bell.png',
                                        image:
                                            '${StaticValues.imageUrl}${obj.file!}',
                                        placeholderErrorBuilder:
                                            (context, error, stackTrace) {
                                          return const CircularProgressIndicator();
                                        },
                                      ),
                                    )
                                  : Text(AppLocalizations.of(context)!
                                      .nofileforthistransaction),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.08,
                          decoration: BoxDecoration(
                              color: AppTheme.colorPrimary,
                              shape: BoxShape.circle),
                          child: const Center(
                            child: Icon(
                              Icons.clear,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.08,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(obj.imageUrl!)),
                              shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    // if (check == 0) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
    //   check++;
    // }
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton:
          ScheduleFB(balance: balance, snabbWallet: snabbWallet),
      body: SafeArea(
        child: Consumer<BrightnessProvider>(
            builder: (context, brightnessprobvider, _) {
          return Column(
            children: [
              // AppLocalizations.of(context)!.scheduledtransactions,
              Container(
                height: height * 0.13,
                width: width * 0.9,
                decoration: BoxDecoration(
                    color: AppTheme.colorPrimary,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.025),
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
                          size: width * 0.065,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.1,
                      ),
                      Text(
                        AppLocalizations.of(context)!.scheduledtransaction,
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: width * 0.11,
                      )
                    ],
                  ),
                ),
              ),
              Card(
                shadowColor: AppTheme.colorPrimary,
                elevation: 7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                child: Container(
                    height: height * 0.15,
                    width: width * 0.9,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(7)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.thismonth,
                                style: TextStyle(
                                    fontSize: width * 0.033,
                                    color: brightnessprobvider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$thisMonth",
                                style: TextStyle(
                                  color: thisMonth >= 0
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.nextmonth,
                                style: TextStyle(
                                    fontSize: width * 0.033,
                                    color: brightnessprobvider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$nextMonth",
                                style: TextStyle(
                                  color: nextMonth >= 0
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              transactions.isNotEmpty
                  ? Expanded(
                      child: SizedBox(
                        height: height,
                        child: ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            ScheduleTransactionData transaction =
                                transactions[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shadowColor: AppTheme.colorPrimary,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  onTap: () {
                                    showImageDialog(context, transaction);
                                  },
                                  leading: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.colorPrimary,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          '${transaction.imageUrl!}',
                                        ),
                                      )),
                                  title: Text(
                                    transaction.category!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(transaction.name!),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          transaction.type == 1
                                              ? "+$currency${transaction.amount}"
                                              : "-$currency${transaction.amount}",
                                          style: TextStyle(
                                              color: transaction.type == 1
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontWeight: FontWeight.bold)),
                                      Text(transaction.schedule!.secondDateTime
                                          .toString()
                                          .substring(0, 10))
                                    ],
                                  ),
                                ),
                              ),
                            );
                            // return InkWell(
                            //   onTap: () {
                            //     showDialog(
                            //       context: context,
                            //       builder: (ctx) => AlertDialog(
                            //         title: const Text("Confirm Transaction"),
                            //         content: const Text(
                            //             "Confirm your scheduled transaction"),
                            //         actions: <Widget>[
                            //           TextButton(
                            //             onPressed: () {
                            //               Navigator.of(ctx).pop();
                            //             },
                            //             child: const Text("Cancel"),
                            //           ),
                            //           TextButton(
                            //             onPressed: () async {
                            //               num updatedBalance;
                            //               num updatedSnabbWallet;
                            //               setState(() {
                            //                 isLoadConfirm = true;
                            //               });
                            //               Transaction confirmTransaction =
                            //                   Transaction(
                            //                       mainFileUrl:
                            //                           transaction.mainFileUrl,
                            //                       amount: transaction.amount,
                            //                       category:
                            //                           transaction.category,
                            //                       date: transaction.date,
                            //                       fileUrl: transaction.fileUrl,
                            //                       id: transaction.id,
                            //                       imgUrl: transaction.imgUrl,
                            //                       name: transaction.name,
                            //                       time: transaction.time,
                            //                       type: transaction.type,
                            //                       note: '');
                            //               await FirebaseFirestore.instance
                            //                   .collection("UserTransactions")
                            //                   .doc(userId)
                            //                   .collection("transactions")
                            //                   .add(confirmTransaction.toJson());
                            //               if (transaction.type ==
                            //                   TransactionType.income) {
                            //                 updatedBalance =
                            //                     balance + transaction.amount;
                            //                 updatedSnabbWallet = snabbWallet +
                            //                     transaction.amount;
                            //               } else {
                            //                 updatedBalance =
                            //                     balance - transaction.amount;
                            //                 updatedSnabbWallet = snabbWallet -
                            //                     transaction.amount;
                            //               }
                            //               await FirebaseFirestore.instance
                            //                   .collection("UserTransactions")
                            //                   .doc(userId)
                            //                   .collection("data")
                            //                   .doc("userData")
                            //                   .update(
                            //                       {"balance": updatedBalance});
                            //               await FirebaseFirestore.instance
                            //                   .collection("UserTransactions")
                            //                   .doc(userId)
                            //                   .collection(
                            //                       "SchedualTrsanactions")
                            //                   .doc(transaction.id)
                            //                   .delete();
                            //               await FirebaseFirestore.instance
                            //                   .collection("UserTransactions")
                            //                   .doc(userId)
                            //                   .collection("Accounts")
                            //                   .doc("snabbWallet")
                            //                   .update({
                            //                 'amount': updatedSnabbWallet
                            //               });
                            //               setState(() {
                            //                 isLoadConfirm = false;
                            //                 transactions.removeWhere(
                            //                     (transactionz) =>
                            //                         transaction.id ==
                            //                         transactionz.id);
                            //               });
                            //               Navigator.of(ctx).pop();
                            //             },
                            //             child: !isLoadConfirm
                            //                 ? const Text("Confirm")
                            //                 : const CircularProgressIndicator(),
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   },
                            //   child:
                            // return Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     const Icon(Icons.add),
                            //     TransactionCard(transaction: transaction),
                            //   ],
                            // );
                            //  );
                          },
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(
                          child: Text(
                        AppLocalizations.of(context)!.noschedualedtransaction,
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color: brightnessprobvider.brightness ==
                                    AppBrightness.dark
                                ? AppTheme.colorWhite
                                : AppTheme.colorPrimary,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
            ],
          );
        }),
      ),
    );
  }
}
