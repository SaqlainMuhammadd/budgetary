import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:snab_budget/apis/controller/add_debit_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/spinkit.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../apis/model/add_debit_model.dart';

class AddDebit extends StatefulWidget {
  DebitCreditData? deta;
  String? id;
  int? type;
  num? remaing;
  AddDebit({super.key, this.deta, this.remaing, this.id, this.type});

  @override
  State<AddDebit> createState() => _AddDebitState();
}

class _AddDebitState extends State<AddDebit> {
  TextEditingController valuecontrol = TextEditingController();
  TextEditingController notecontrol = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //final String userId = FirebaseAuth.instance.currentUser!.uid;
  double updatamount = 0;

  updateamount() async {
    try {
      double paidAmount = double.parse(widget.deta!.paidAmount.toString()) ??
          0.0; // Default to 0 if paidAmount is null
      double newValue = double.tryParse(valuecontrol.text) ??
          0.0; // Default to 0 if parsing fails

      updatamount = paidAmount + newValue;

      print('Updated Amount: $updatamount');
    } catch (e) {
      print('Error updating amount: $e');
    }
  }

  bool switchvalue = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<AddDebitController>(builder: (obj) {
          return Form(
            key: _formKey,
            child: Stack(
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: height * 0.07,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                            color: AppTheme.colorPrimary,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: width * 0.07,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.1,
                            ),
                            widget.type == 0
                                ? Text(
                                    AppLocalizations.of(context)!.paybackcredit,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  )
                                : Text(
                                    AppLocalizations.of(context)!.paybackdebit,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: height * 0.05,
                      ),

                      SizedBox(
                        height: height * 0.07,
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                width: width * 0.3,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null) {
                                      return AppLocalizations.of(context)!
                                          .enteramount;
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: valuecontrol,
                                  decoration: InputDecoration(
                                    hintText: "${widget.remaing}",
                                  ),
                                )),
                            Text(DashBoardController.to.curency),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!
                                    .residualamount),
                                Text("${widget.remaing}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: widget.type != 1
                              ? const AssetImage("assets/images/paid.png")
                              : const AssetImage("assets/images/notpaid.png"),
                        ),
                        title: widget.type == 0
                            ? Text(
                                AppLocalizations.of(context)!.credit,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                AppLocalizations.of(context)!.debit,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.total}"
                        " ${valuecontrol.text}  ${DashBoardController.to.curency}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.home,
                          size: 30,
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.wallet,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.calendar_month,
                          size: 30,
                        ),
                        title: InkWell(
                          onTap: () {
                            // _selectDate(context, date as DateTime);
                          },
                          child: Text(
                            //   widget.debt!.backDate!.substring(0, 10),
                            widget.deta!.payBackDate!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.person,
                          size: 30,
                        ),
                        title: Text(
                          widget.deta!.person.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.edit,
                          size: 30,
                        ),
                        title: TextFormField(
                          controller: notecontrol,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context)!.enteramount;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.noteoptional,
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.checked),
                        trailing: Switch(
                          value: switchvalue,
                          onChanged: (value) {
                            setState(() {
                              switchvalue = value;
                            });
                            print("value $switchvalue");
                          },
                        ),
                      ),
                      const Divider(),
                      // const Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Icon(Icons.camera_alt, color: Colors.grey, size: 30),
                      //     Icon(
                      //       Icons.file_copy,
                      //       color: Colors.grey,
                      //       size: 30,
                      //     )
                      //   ],
                      // ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.colorPrimary,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40)),
                            onPressed: () {
                              valuecontrol.clear();
                              notecontrol.clear();
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Text(
                                "${AppLocalizations.of(context)!.cancel}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.colorPrimary,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 50)),
                            onPressed: () {
                              if ((double.parse(valuecontrol.text)) >
                                  widget.remaing!) {
                                //   print("update amount ${updatamount}");
                                Fluttertoast.showToast(
                                    msg: "Invalid Amount ",
                                    backgroundColor: AppTheme.colorPrimary,
                                    textColor: AppTheme.colorGreyBackground);
                              } else {
                                updateamount();
                                final data = {
                                  "amount": updatamount,
                                  "note": notecontrol.text,
                                  "date": widget.deta!.payBackDate,
                                  "isCash": switchvalue,
                                  "debitCreditId": widget.id,
                                };
                                obj.paydebitcredit(data, context);
                              }
                            },
                            child: Center(
                              child: Text(
                                "${AppLocalizations.of(context)!.save}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                obj.isLoading == false
                    ? SizedBox()
                    : Center(
                        child: Container(
                          height: height,
                          width: width,
                          color: AppTheme.colorPrimary.withOpacity(0.2),
                          child: Center(
                            child: SpinKit.loadSpinkit,
                          ),
                        ),
                      )
              ],
            ),
          );
        }),
      ),
    );
  }
}
