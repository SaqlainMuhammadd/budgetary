// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/Screens/addexpanse.dart';
import 'package:snab_budget/Screens/addincome.dart';
import 'package:snab_budget/Screens/debit_credit/deptsscreen.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/utils/pdf/pdfpreview.dart';
import 'daimond_shape.dart';

class ExpandableFloatingActionButton extends StatefulWidget {
  // final num balance;
  // final num snabbWallet;
  const ExpandableFloatingActionButton({
    super.key,
    //  required this.balance, required this.snabbWallet
  });

  @override
  _ExpandableFloatingActionButtonState createState() =>
      _ExpandableFloatingActionButtonState();
}

class _ExpandableFloatingActionButtonState
    extends State<ExpandableFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // final String userId = FirebaseAuth.instance.currentUser!.uid;

  bool expensestatus = false;
  bool incomestatus = false;
  bool derbitCreditstatus = false;
  bool accountstatus = false;
  String? name;
  String? email;
  bool _isExpanded = false;

  // getuserdata() async {
  //   final userId = FirebaseAuth.instance.currentUser!.uid;
  //   var collection = FirebaseFirestore.instance.collection('UsersData');
  //   var docSnapshot = await collection.doc(userId).get();
  //   if (docSnapshot.exists) {
  //     print("ok");
  //     Map<String, dynamic>? data = docSnapshot.data();
  //     setState(() {
  //       name = data?["First Name"];
  //       email = data?["Email"];
  //       //  print("$name  ----------- $email");
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // getuserdata();
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

  Future<void> showPDFDialog(
      BuildContext context, var height, var width, provider) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          accountstatus = false;
          derbitCreditstatus = false;
          expensestatus = false;
          incomestatus = false;
          return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.createpdf,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: provider.brightness == AppBrightness.dark
                        ? AppTheme.colorWhite
                        : AppTheme.colorPrimary),
              ),
              backgroundColor: provider.brightness == AppBrightness.light
                  ? Colors.grey[200]
                  : AppTheme.darkbackground,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: StatefulBuilder(builder: (context, setstate) {
                return SizedBox(
                    height: height * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.createprintablepdf,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: provider.brightness == AppBrightness.dark
                                  ? Colors.white
                                  : AppTheme.colorPrimary,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.includereport,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: provider.brightness == AppBrightness.dark
                                  ? AppTheme.colorWhite
                                  : AppTheme.colorPrimary),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: expensestatus,
                                activeColor: AppTheme.colorPrimary,
                                onChanged: (newValue) {
                                  setstate(() {
                                    expensestatus = newValue as bool;
                                  });
                                }),
                            Text(
                              AppLocalizations.of(context)!.expense,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: provider.brightness == AppBrightness.dark
                                    ? Colors.white
                                    : AppTheme.colorPrimary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: incomestatus,
                                activeColor: AppTheme.colorPrimary,
                                onChanged: (newValue) {
                                  setstate(() {
                                    incomestatus = newValue as bool;
                                  });
                                }),
                            Text(
                              AppLocalizations.of(context)!.income,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: provider.brightness == AppBrightness.dark
                                    ? Colors.white
                                    : AppTheme.colorPrimary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: derbitCreditstatus,
                                activeColor: AppTheme.colorPrimary,
                                onChanged: (newValue) {
                                  setstate(() {
                                    derbitCreditstatus = newValue as bool;
                                  });
                                }),
                            Text(
                              AppLocalizations.of(context)!.debitcredit,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: provider.brightness == AppBrightness.dark
                                    ? Colors.white
                                    : AppTheme.colorPrimary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: accountstatus,
                                activeColor: AppTheme.colorPrimary,
                                onChanged: (newValue) {
                                  setstate(() {
                                    accountstatus = newValue as bool;
                                  });
                                }),
                            Text(
                              AppLocalizations.of(context)!.amount,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: provider.brightness == AppBrightness.dark
                                    ? Colors.white
                                    : AppTheme.colorPrimary,
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              if (accountstatus ||
                                  derbitCreditstatus ||
                                  expensestatus ||
                                  incomestatus) {
                                print(
                                    "============${TransactionController.to.transactions.length}");

                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PDFPreview(
                                          email: "email.com",
                                          name: "my name",
                                          accountstatus: accountstatus,
                                          derbitCreditstatus:
                                              derbitCreditstatus,
                                          expensestatus: expensestatus,
                                          incomestatus: incomestatus,
                                          accountlist: TransactionController
                                              .to.walletttt,
                                          debitcreditlist: TransactionController
                                              .to.debtCreditlst,
                                          incomeTransactions:
                                              TransactionController
                                                  .to.incomeTransactions,
                                          expanceTransactions:
                                              TransactionController
                                                  .to.expanceTransactions),
                                    ));
                              }
                            },
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                  color: AppTheme.colorPrimary,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.add,
                                  style: TextStyle(
                                      fontSize: width * 0.03,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
              }));
        });
  }

  var height, width;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Consumer<BrightnessProvider>(builder: (context, provider, c) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_isExpanded)
            // FloatingActionButton(
            //   onPressed: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => const TransferScreen(),
            //     ));
            //   },
            //   backgroundColor: const Color.fromRGBO(86, 111, 245, 1),
            //   heroTag: null,
            //   child: const ImageIcon(AssetImage("assets/images/transfer.png")),
            // ),
            // if (_isExpanded) const SizedBox(height: 16),
            if (_isExpanded) const SizedBox(height: 16),
          if (_isExpanded)
            FloatingActionButton(
              onPressed: () {
                TransactionController.to.fetchDebtsCredits();
                TransactionController.to.fetchAccounts();
                TransactionController.to.fetchexpensetransaction();
                TransactionController.to.fetchincometransaction();
                showPDFDialog(context, height, width, provider);
              },
              heroTag: null,
              backgroundColor: AppTheme.colorPrimary,
              child: const Icon(Icons.picture_as_pdf),
            ),
          if (_isExpanded) const SizedBox(height: 16),
          if (_isExpanded)
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(BalanceScreen.routeName);
              },
              heroTag: null,
              backgroundColor: Theme.of(context).primaryColor,
              child: const ImageIcon(AssetImage("assets/images/dollar.png")),
            ),
          if (_isExpanded) const SizedBox(height: 16),
          if (_isExpanded)
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddExpanse(
                      balance: TransactionController.to.balance,
                      snabWallet: TransactionController.to.snabbWallet),
                ));
              },
              heroTag: null,
              backgroundColor: Colors.red,
              child: const ImageIcon(AssetImage("assets/images/minus.png")),
            ),
          if (_isExpanded) const SizedBox(height: 16),
          if (_isExpanded)
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddIncome(
                      balance: TransactionController.to.balance,
                      snabWallet: TransactionController.to.snabbWallet),
                ));
              },
              heroTag: null,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.add,
                color: provider.brightness == AppBrightness.dark
                    ? AppTheme.colorWhite
                    : AppTheme.colorWhite,
              ),
            ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: SizedBox(
                height: 60,
                width: 60,
                child: FittedBox(
                    child: FloatingActionButton(
                  shape: const DiamondBorder(),
                  backgroundColor: AppTheme.colorPrimary,
                  onPressed: _toggleExpanded,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(40.0),
                  // ),
                  //  heroTag: null,
                  child: AnimatedIcon(
                    icon: AnimatedIcons.add_event,
                    progress: _animation,
                  ),
                ))),
          ),
        ],
      );
    });
  }
}
