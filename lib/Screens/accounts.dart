import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/apis/controller/wallet_controller.dart';
import 'package:snab_budget/apis/model/user_wallet_model.dart' as wal;
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import 'package:snab_budget/utils/currency_model.dart';
import 'package:snab_budget/utils/daimond_shape.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/utils/spinkit.dart';
import '../models/account.dart';
import 'package:velocity_x/velocity_x.dart';

class Accounts extends StatefulWidget {
  static const routeName = "Account-Screen";

  const Accounts({super.key});

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  List<Account> accounts = [];
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController amount = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController notes = TextEditingController();

  String? _currency;

  num balance = 0.0;
  int credit = 0;
  int dept = 0;
  int expense = 0;
  int income = 0;
  int cash = 0;
  int bankTransfer = 0;
  int creditCard = 0;
  int check = 0;
  String? currency = "";

  bool deleteCheck = false;
  double totalwallet = 0;
  double totalbalance = 0;
  void _openAddTransactionDialog(bool a) async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              shadowColor: AppTheme.colorPrimary,
              content: Form(
                key: _formKey,
                child: GetBuilder<WalletController>(builder: (obj) {
                  return SizedBox(
                    height: height / 2.1,
                    width: width - 100,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: height / 2.1,
                          width: width - 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.createnewaccount,
                                style: TextStyle(
                                    color: a
                                        ? Colors.white
                                        : AppTheme.colorPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.035),
                              ).centered(),
                              const SizedBox(
                                height: 10,
                              ),
                              Card(
                                elevation: 5,
                                shadowColor: AppTheme.colorPrimary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  controller: name,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.green),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    labelText:
                                        AppLocalizations.of(context)!.fullname,
                                    hintText: AppLocalizations.of(context)!
                                        .accountname,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseenteraccountname;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: width - 140,
                                height: height * 0.08,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shadowColor: AppTheme.colorPrimary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SizedBox(
                                          width: width * 0.35,
                                          child: TextFormField(
                                            controller: amount,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 10),
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.green),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                labelText: AppLocalizations.of(
                                                        context)!
                                                    .amount,
                                                hintText: "0.00"),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .pleaseenteranamount;
                                              }
                                              if (double.tryParse(value) ==
                                                  null) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .pleaseenteraname;
                                              }
                                              return null;
                                            },
                                          )),
                                    ),
                                    Expanded(
                                      child: Card(
                                        elevation: 5,
                                        shadowColor: AppTheme.colorPrimary,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: DropdownButton<CurrencyModell>(
                                          isExpanded: true,
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          hint: Text(
                                              AppLocalizations.of(context)!
                                                  .currency),
                                          value: obj.selectedcurrency,
                                          items: CurrencyModell.currencyList
                                              .map((CurrencyModell value) {
                                            return DropdownMenuItem<
                                                CurrencyModell>(
                                              value: value,
                                              child: Text(value.value!),
                                            );
                                          }).toList(),
                                          onChanged: (v) {
                                            obj.changeCurrency(v!);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Card(
                                elevation: 5,
                                shadowColor: AppTheme.colorPrimary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: SizedBox(
                                    width: width - 140,
                                    height: height * 0.06,
                                    child: TextFormField(
                                      controller: notes,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.green),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .notes,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .notes),
                                    )),
                              ),
                              !obj.isLoadData
                                  ? InkWell(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          Map<String, dynamic> map = {
                                            "name": name.text,
                                            "amount": double.parse(amount.text),
                                            "currency": WalletController
                                                .to.selectedcurrency!.value!,
                                            "note": notes.text,
                                            "transferred": true
                                          };

                                          obj
                                              .adddWalletdata(map, context)
                                              .then((value) {
                                            name.clear();
                                            amount.clear();
                                            notes.clear();
                                          });
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: AppTheme.colorPrimary,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        width: width - 150,
                                        height: height * 0.05,
                                        child: Text(
                                          AppLocalizations.of(context)!.add,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : const CircularProgressIndicator(),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ));

    if (result != null) {
      setState(() {
        accounts.add(result);
      });
    }
  }

  void _transferAmount(Account account) {
    showDialog(
      context: context,
      builder: (BuildContext context) => TransferDialog(
        transaction: account,
        transferCallback: (double transferredAmount, String name) {
          print("balance ${account.amount}");
          setState(() {
            account.amount -= transferredAmount;
          });
        },
      ),
    );
  }

  void showTransactionDetails(
    wal.Data transaction,
    String currency,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) => TransactionDetailsDialog(
        transaction: transaction,
        currency: currency,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WalletController.to.getWalletdata();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    Size size = MediaQuery.of(context).size;
    return Consumer<BrightnessProvider>(
        builder: (context, brightnessprovider, _) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        body: Column(
          children: [
            Container(
              height: height * 0.13,
              width: width * 0.9,
              decoration: BoxDecoration(
                  color: AppTheme.colorPrimary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppTheme.colorWhite,
                            size: width * 0.05,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.accounts,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.totalamount,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${DashBoardController.to.curency} ${totalbalance + DashBoardController.to.balance}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<WalletController>(builder: (obj) {
                return SizedBox(
                  height: height,
                  width: width,
                  child: obj.walletList.isEmpty
                      ? Center(
                          child: SizedBox(
                            height: height * 0.1,
                            width: width * 0.2,
                            child: SpinKit.loadSpinkit,
                          ),
                        )
                      : ListView.builder(
                          itemCount: obj.walletList.length,
                          itemBuilder: (context, index) {
                            wal.Data account = obj.walletList[index];
                            totalbalance = obj.walletList[index].amount!;
                            print("amount ${totalbalance}");
                            return accountCard(
                                account,
                                index,
                                brightnessprovider.brightness ==
                                        AppBrightness.dark
                                    ? true
                                    : false);
                          },
                        ),
                );
              }),
            )
          ],
        ).p(10),
        floatingActionButton: FloatingActionButton(
          shape: const DiamondBorder(),
          backgroundColor: AppTheme.colorPrimary,
          onPressed: () {
            _openAddTransactionDialog(
                brightnessprovider.brightness == AppBrightness.dark
                    ? true
                    : false);
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  Card accountCard(wal.Data account, int index, bool a) {
    totalbalance = account.amount!;
    print("total balance ${totalbalance}");
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      shadowColor: AppTheme.colorPrimary,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                account.name!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        showTransactionDetails(account, currency.toString());
                      },
                      icon: const Icon(Icons.visibility)),
                  account.name != "Budgetary"
                      ? IconButton(
                          onPressed: () {},
                          icon: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Consumer<BrightnessProvider>(
                                        builder: (context, value, v) {
                                      return AlertDialog(
                                        title: Text(
                                          'Confirm Delete',
                                          style: TextStyle(
                                            color: value.brightness ==
                                                    AppBrightness.dark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        content: Text(
                                          'Are you sure you want to Delete?',
                                          style: TextStyle(
                                            color: value.brightness ==
                                                    AppBrightness.dark
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
                                                color: value.brightness ==
                                                        AppBrightness.dark
                                                    ? Colors.white
                                                    : AppTheme.colorPrimary,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      const Color.fromARGB(
                                                          255,
                                                          17,
                                                          41,
                                                          73)), // Set the custom color here
                                            ),
                                            onPressed: () async {
                                              WalletController.to
                                                  .deleteWalletdata(
                                                      account.walletId
                                                          .toString(),
                                                      context);
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
                              child: const Icon(Icons.delete_forever)))
                      : const SizedBox()
                ],
              ),
            ],
          ).pSymmetric(v: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppLocalizations.of(context)!.balance}:",
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "$currency ${account.amount}",
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ).pSymmetric(v: 10),
          if (account.transferred!)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.flag_circle),
                Text(
                  AppLocalizations.of(context)!.transferred,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
        ],
      ).p(10),
    );
  }
}

class TransferDialog extends StatefulWidget {
  final Account transaction;
  final Function(double, String) transferCallback;

  const TransferDialog(
      {super.key, required this.transaction, required this.transferCallback});

  @override
  _TransferDialogState createState() => _TransferDialogState();
}

class _TransferDialogState extends State<TransferDialog> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final _formKey = GlobalKey<FormState>();
  double? _transferAmount;
  String? _name;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.transferamount),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.name,
                  hintText: AppLocalizations.of(context)!.name),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.pleaseenteraname;
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.transferamount),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.pleaseenteranamount;
                }
                if (double.tryParse(value) == null) {
                  return AppLocalizations.of(context)!.pleaseenteravalidnumber;
                }
                if (double.parse(value) > widget.transaction.amount) {
                  return AppLocalizations.of(context)!
                      .transferamountexceedsavailableamount;
                }
                return null;
              },
              onSaved: (value) {
                _transferAmount = double.parse(value!);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Account account = Account(
                  id: "d35s14d",
                  name: _name!,
                  amount: _transferAmount as double,
                  currency: widget.transaction.currency,
                  note: widget.transaction.note,
                  transferred: true);
              _formKey.currentState!.save();
              widget.transferCallback(_transferAmount!, _name!);
              await FirebaseFirestore.instance
                  .collection("UserTransactions")
                  .doc(userId)
                  .collection("Accounts")
                  .doc(widget.transaction.id)
                  .update(
                      {"amount": widget.transaction.amount - _transferAmount!});
              await FirebaseFirestore.instance
                  .collection("UserTransactions")
                  .doc(userId)
                  .collection("Accounts")
                  .add({
                "name": account.name,
                "amount": account.amount,
                "currency": account.currency,
                "notes": account.note,
                "transferred": account.transferred
              });
              Navigator.of(context).pop();
            }
          },
          child: Text(
            AppLocalizations.of(context)!.transationdetails,
          ),
        ),
      ],
    );
  }
}

class TransactionDetailsDialog extends StatelessWidget {
  final wal.Data transaction;
  String currency;

  TransactionDetailsDialog(
      {super.key, required this.transaction, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Consumer<BrightnessProvider>(builder: (context, brightness, _) {
      return AlertDialog(
        shadowColor: brightness.brightness == AppBrightness.light
            ? AppTheme.colorPrimary
            : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.transationdetails,
            style: TextStyle(
                color: brightness.brightness == AppBrightness.light
                    ? AppTheme.colorPrimary
                    : Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.amount,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: brightness.brightness == AppBrightness.light
                          ? AppTheme.colorPrimary
                          : Colors.white),
                ),
                Text(
                  '${transaction.amount}',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.currency,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: brightness.brightness == AppBrightness.light
                          ? AppTheme.colorPrimary
                          : Colors.white),
                ),
                Text(
                  transaction.currency!,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.notes}: ',
                  style: TextStyle(
                      color: brightness.brightness == AppBrightness.light
                          ? AppTheme.colorPrimary
                          : Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.035),
                ),
                Text(
                  transaction.note!,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              AppLocalizations.of(context)!.close,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.035,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    });
  }
}
