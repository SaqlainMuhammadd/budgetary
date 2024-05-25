// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/Screens/debit_credit/edit_debit_credit.dart';
import 'package:snab_budget/Screens/debit_credit/view_debitcredit.dart';
import 'package:snab_budget/Screens/home_screen.dart';
import 'package:snab_budget/apis/controller/add_debit_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/controller/dept_controler.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/utils/addDebit.dart';
import 'package:snab_budget/utils/balance_ex.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import '../../../models/currency_controller.dart';
import '../../../models/dept.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../apis/model/add_debit_model.dart';
import '../../utils/spinkit.dart';

class BalanceScreen extends StatefulWidget {
  static const routeName = "balance-screen";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  BalanceScreen({super.key});
  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  //String? paid

  //final String userId = FirebaseAuth.instance.currentUser!.uid;
  double balance = 0;

  String calculateTotal(List<DebitCreditData> debts) {
    double total = 0;
    for (var debt in debts) {
      if (debt.type == 0) {
        total += debt.amount!;
      } else if (debt.type == 1) {
        total -= debt.amount!;
      }
    }
    // print("total ${total.toString()}");
    return total.toString();
  }

  // Future<List<Data>> fetchDepts(String userId) async {
  //   List<Dept> depts = [];

  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await FirebaseFirestore.instance
  //             .collection("UserTransactions")
  //             .doc(userId)
  //             .collection("depts")
  //             .get();

  //     List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
  //         querySnapshot.docs;

  //     for (var document in documents) {
  //       Dept dept = Dept.fromJson(document.data(), document.id);
  //       depts.add(dept);
  //     }

  //     // for (var doc in querySnapshot.docs) {
  //     //   Dept dept = Dept.fromMap(doc.data()!);
  //     //   depts.add(dept);
  //     // }
  //   } catch (e) {
  //     print('Error fetching depts: $e');
  //   }
  //   setState(() {
  //     for (Dept dept in depts) {
  //       if (dept.type == "Credit") {
  //         balance += dept.paidamount as int;
  //       } else if (dept.type == "Debit") {
  //         balance -= dept.paidamount as int;
  //       }
  //     }
  //   });
  //   return dept;
  // }

  // // List<Dept> depts = [];
  // // void getdepts() async {
  // //   depts = await fetchDepts(userId);
  // // }

  @override
  void initState() {
    super.initState();
    Get.put(AddDebitController());

    //  getdepts();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: widget.scaffoldKey,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<BrightnessProvider>(builder: (context, provider, bv) {
            return GetBuilder<AddDebitController>(builder: (obj) {
              return Column(
                children: [
                  Container(
                    height: height * 0.07,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        color: AppTheme.colorPrimary,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (Route<dynamic> route) => false);
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
                          "${AppLocalizations.of(context)!.dr}/${AppLocalizations.of(context)!.cr}",
                          style: TextStyle(
                              fontSize: width * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: width * 0.23,
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.residualamount,
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color: provider.brightness == AppBrightness.dark
                                ? AppTheme.colorWhite
                                : AppTheme.colorPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        balance.toString(),
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color: provider.brightness == AppBrightness.dark
                                ? AppTheme.colorWhite
                                : AppTheme.colorPrimary,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ).pSymmetric(h: 20, v: 20),
                  //  depts.isEmpty
                  //?
                  // Column(
                  //   children: [
                  //     SizedBox(
                  //       height: 200,
                  //     ),
                  //     Image.asset(
                  //       'assets/images/icon.jpg',
                  //       height: 100,
                  //     ),
                  //     SizedBox(
                  //       height: 40,
                  //     ),
                  //     Center(
                  //       child: Text(
                  //         "  Your Debts are empty.\nWanna Create a Account?",
                  //         style: TextStyle(
                  //             fontSize: width * 0.03,
                  //             color: provider.brightness == AppBrightness.dark
                  //                 ? AppTheme.colorWhite
                  //                 : AppTheme.colorPrimary,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //   ],
                  // )

                  //:
                  SizedBox(
                    height: 600,
                    width: size.width - 10,
                    child: StreamBuilder<DebitCreditModel>(
                      stream: AddDebitController.to.getdebitcredit(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Center(
                            child: SizedBox(
                              height: height * 0.1,
                              width: width * 0.2,
                              child: SpinKit.loadSpinkit,
                            ),
                          ));
                        } else if (obj.debitcreditmodel!.data!.isEmpty) {
                          return const Center(child: Text('Empty Budget'));
                        } else {
                          return ListView.builder(
                            itemCount: obj.debitcreditmodel!.data!.length,
                            itemBuilder: (context, index) {
                              print(
                                "length ${obj.debitcreditmodel!.data!.length}",
                              );
                              DebitCreditData data =
                                  obj.debitcreditmodel!.data![index];
                              return deptCard(data, context);
                            },
                          );
                          // } else if (snapshot.hasError) {
                          //   return Text('Error: ${snapshot.error}');
                          // } else {
                          //   return Center(child: CircularProgressIndicator());
                          //   // }
                        }
                      },
                    ),
                  )
                ],
              );
            });
          }),
        ),
      ),
      floatingActionButton: BlanceExpandableFloating(),
    );
  }

  List<DebitCreditData> datavalue = [];
  double remaingamount = 0;
  Consumer<BrightnessProvider> deptCard(
    DebitCreditData data,
    BuildContext context,
  ) {
    datavalue.add(data);
    calculateTotal(datavalue);
    remaingamount = double.parse(data.amount.toString()) -
        double.parse(data.paidAmount.toString());

    double percentage = 0;
    double slider = 0;
    // remaingamount = double.parse(data.amount.toString()) -
    //     double.parse(data.paidAmount.toString());
    percentage = double.parse(data.paidAmount.toString()) *
        100 /
        double.parse(data.amount.toString());
    slider = double.parse(data.paidAmount.toString()) /
        double.parse(data.amount.toString());

    return Consumer<BrightnessProvider>(builder: (context, provider, bv) {
      return Column(
        children: [
          Stack(children: [
            InkWell(
              child: Card(
                elevation: 2,
                shadowColor: AppTheme.colorPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: data.type == 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/paid.png"),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.type == 1
                                            ? AppLocalizations.of(context)!
                                                .debit
                                            : AppLocalizations.of(context)!
                                                .credit,
                                        style: TextStyle(
                                            fontSize: width * 0.035,
                                            color: AppTheme.colorPrimary,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.you,
                                            style: TextStyle(
                                                fontSize: width * 0.03,
                                                color: provider.brightness ==
                                                        AppBrightness.dark
                                                    ? AppTheme.colorWhite
                                                    : AppTheme.colorPrimary,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.arrow_right_alt_sharp,
                                            size: 35,
                                            color: data.type == 0
                                                ? Colors.green
                                                : Colors.black,
                                          ),
                                          Text(
                                            data.person.toString(),
                                            style: TextStyle(
                                                fontSize: width * 0.03,
                                                color: provider.brightness ==
                                                        AppBrightness.dark
                                                    ? AppTheme.colorWhite
                                                    : AppTheme.colorPrimary,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ).pOnly(left: 20),
                                ],
                              ).pSymmetric(v: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data.date!.toString(),
                                    // DateFormat.yMMMd()
                                    //     .format(dept.date as DateTime),
                                    style: TextStyle(
                                        fontSize: width * 0.03,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    //"${percentage} %",
                                    "${percentage.toStringAsFixed(1)} %",
                                    style: TextStyle(
                                        fontSize: width * 0.035,
                                        color: provider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data.payBackDate!,
                                    // DateFormat.yMMMd()
                                    //     .format(dept.backDate as DateTime),
                                    style: TextStyle(
                                        fontSize: width * 0.03,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              LinearPercentIndicator(
                                lineHeight: 6.0,
                                percent: slider.toDouble(),
                                backgroundColor: Colors.black26,
                                progressColor:
                                    data.type == 0 ? Colors.green : Colors.red,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$remaingamount',
                                    style: TextStyle(
                                        fontSize: width * 0.035,
                                        color: provider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${data.paidAmount} ${DashBoardController.to.curency} ',
                                    style: TextStyle(
                                        fontSize: width * 0.04,
                                        color: provider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' ${data.amount}',
                                    style: TextStyle(
                                        fontSize: width * 0.035,
                                        color: provider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              if (data.type == 1)
                                Row(
                                  children: [
                                    Image.asset("assets/images/notpaid.png"),
                                    Column(
                                      children: [
                                        Text(
                                          data.type == 1
                                              ? AppLocalizations.of(context)!
                                                  .debit
                                              : AppLocalizations.of(context)!
                                                  .creationdate,
                                          style: TextStyle(
                                              fontSize: width * 0.035,
                                              color: AppTheme.colorPrimary,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .residualamount,
                                    style: TextStyle(
                                        fontSize: width * 0.038,
                                        color: provider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '  ${data.paidAmount} ${DashBoardController.to.curency}',
                                    style: TextStyle(
                                        fontSize: width * 0.038,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  remaingamount != 0
                                      ? InkWell(
                                          onTap: () {
                                            print(" id${data.id}");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => AddDebit(
                                                    deta: data,
                                                    id: data.id,
                                                    type: data.type,
                                                    remaing: data.amount! -
                                                        data.paidAmount!,
                                                  ),
                                                ));
                                          },
                                          child: Icon(Icons.add,
                                              color: Colors.black))
                                      : Text(
                                          AppLocalizations.of(context)!.paid),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ViewDebitScreen(
                                                // wallet: TransactionController
                                                //     .to.currency,
                                                id: data.id,
                                                data: data,
                                                remaing: data.amount! -
                                                    data.paidAmount!,
                                                percentage: percentage,
                                                slider: slider,
                                              ),
                                            ));
                                      },
                                      child: Icon(Icons.visibility,
                                          color: Colors.black)),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  EditDebitCreditScreen(
                                                data: data,
                                                remaing: data.amount! -
                                                    data.paidAmount!,
                                              ),
                                            ));
                                      },
                                      child: Icon(Icons.edit,
                                          color: Colors.black)),
                                ],
                              ),
                            ],
                          ).p(20)
                        //debit
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/notpaid.png"),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.type == 1
                                            ? AppLocalizations.of(context)!
                                                .debit
                                            : AppLocalizations.of(context)!
                                                .credit,
                                        style: TextStyle(
                                            fontSize: width * 0.045,
                                            color: AppTheme.colorPrimary,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            data.person.toString(),
                                            style: TextStyle(
                                                fontSize: width * 0.045,
                                                color: AppTheme.colorPrimary,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.arrow_right_alt_sharp,
                                            size: 35,
                                            color: data.type == 0
                                                ? Colors.green
                                                : Colors.black,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!.you,
                                            style: TextStyle(
                                                fontSize: width * 0.045,
                                                color: AppTheme.colorPrimary,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ).pOnly(left: 20)
                                ],
                              ).pSymmetric(v: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data.date!.toString().substring(0, 10),

                                    // DateFormat.yMMMd()
                                    //     .format(dept.date as DateTime),
                                    style: TextStyle(
                                        fontSize: width * 0.035,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    //"${percentage} %",
                                    "${percentage.toStringAsFixed(1)} %",
                                    style: TextStyle(
                                        fontSize: width * 0.045,
                                        color: AppTheme.colorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data.payBackDate!,
                                    // DateFormat.yMMMd()
                                    //     .format(dept.backDate as DateTime),
                                    style: TextStyle(
                                        fontSize: width * 0.035,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              LinearPercentIndicator(
                                lineHeight: 6.0,
                                percent: slider.toDouble(),
                                backgroundColor: Colors.black26,
                                progressColor:
                                    data.type == 0 ? Colors.green : Colors.red,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$remaingamount',
                                    style: TextStyle(
                                        fontSize: width * 0.035,
                                        color: AppTheme.colorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.08),
                                    child: Text(
                                      '${data.paidAmount} ${DashBoardController.to.curency}',
                                      style: TextStyle(
                                          fontSize: width * 0.04,
                                          color: AppTheme.colorPrimary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    '${data.amount}',
                                    style: TextStyle(
                                        fontSize: width * 0.035,
                                        color: AppTheme.colorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .residualamount,
                                    style: TextStyle(
                                        fontSize: width * 0.038,
                                        color: AppTheme.colorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '  ${data.paidAmount}  ${DashBoardController.to.curency}',
                                    style: TextStyle(
                                        fontSize: width * 0.038,
                                        color: data.type == 0
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  remaingamount != 0
                                      ? InkWell(
                                          onTap: () {
                                            print("id ${data.id}");
                                            print(
                                                "remaing amount ${(data.amount! - data.paidAmount!)}");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => AddDebit(
                                                    deta: data,
                                                    id: data.id,
                                                    type: data.type,
                                                    remaing: data.amount! -
                                                        data.paidAmount!,
                                                  ),
                                                ));
                                          },
                                          child: Icon(Icons.add,
                                              color: Colors.black))
                                      : Text(
                                          AppLocalizations.of(context)!.paid),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ViewDebitScreen(
                                                //  wallet: TransactionController
                                                //   .to.currency,
                                                data: data,
                                                id: data.id,
                                                remaing: data.amount! -
                                                    data.paidAmount!,
                                                percentage: percentage,
                                                slider: slider,
                                              ),
                                            ));
                                      },
                                      child: Icon(Icons.visibility,
                                          color: Colors.black)),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  EditDebitCreditScreen(
                                                data: data,
                                                remaing: data.amount! -
                                                    data.paidAmount!,
                                              ),
                                            ));
                                      },
                                      child: Icon(Icons.edit,
                                          color: Colors.black)),
                                  // InkWell(
                                ],
                              ),
                            ],
                          ).p(20)),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Consumer<BrightnessProvider>(
                          builder: (context, value, v) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: Text(
                            'Confirm Delete',
                            style: TextStyle(
                              color: value.brightness == AppBrightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          content: Text(
                            'Are you sure you want to delete this ?',
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
                                  color: value.brightness == AppBrightness.dark
                                      ? Colors.white
                                      : AppTheme.colorPrimary,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 17, 41,
                                            73)), // Set the custom color here
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();

                                AddDebitController.to
                                    .deleteDebitCredit(data.id);
                              },
                              child: const Text(
                                'Delete',
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
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            )
          ]),
        ],
      );
    });
  }

  // void deleteDept(Dept dept) async {
  //   await FirebaseFirestore.instance
  //       .collection("UserTransactions")
  //       .doc(userId)
  //       .collection("depts")
  //       .doc(dept.id)
  //       .delete();
  //   setState(() {
  //     depts.removeWhere((deptz) => deptz.id == dept.id);
  //   });
  // }

  ListTile drawerTile(String imgUrl, String title) {
    return ListTile(
        leading: ImageIcon(
          AssetImage(imgUrl),
          color: Colors.white,
          size: 38,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ));
  }
}

class ExpandableFloatingActionButton extends StatefulWidget {
  const ExpandableFloatingActionButton({super.key});

  @override
  _ExpandableFloatingActionButtonState createState() =>
      _ExpandableFloatingActionButtonState();
}

class _ExpandableFloatingActionButtonState
    extends State<ExpandableFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;

      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isExpanded)
          if (_isExpanded) const SizedBox(height: 16),
        if (_isExpanded)
          FloatingActionButton(
            onPressed: () {},
            heroTag: null,
            backgroundColor: Colors.red,
            child: const ImageIcon(AssetImage("assets/images/minus.png")),
          ),
        if (_isExpanded) const SizedBox(height: 16),
        if (_isExpanded)
          FloatingActionButton(
            onPressed: () {},
            heroTag: null,
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
          ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: SizedBox(
              height: 60,
              width: 60,
              child: FittedBox(
                  child: FloatingActionButton(
                backgroundColor: AppTheme.colorPrimary,
                onPressed: _toggleExpanded,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                //  heroTag: null,
                child: AnimatedIcon(
                  icon: AnimatedIcons.add_event,
                  progress: _animation,
                ),
              ))),
        ),
      ],
    );
  }
}
