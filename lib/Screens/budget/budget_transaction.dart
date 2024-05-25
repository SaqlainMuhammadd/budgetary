import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:snab_budget/Screens/budget/budgetModalClass.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/utils/spinkit.dart';

import '../../apis/ApiStore.dart';
import '../../static_data.dart';

class bugetTransaction extends StatefulWidget {
  BudgetData data;

  bugetTransaction({super.key, required this.data});

  @override
  State<bugetTransaction> createState() => _bugetTransactionState();
}

class _bugetTransactionState extends State<bugetTransaction> {
  final TextEditingController _value = TextEditingController();
  final TextEditingController numberoftimescontroller = TextEditingController();
  final TextEditingController repeatcontrooler = TextEditingController();
  int index = 1;
  var height, width;
  bool opencatagoryclick = false;
  String walletname = "Select Wallet";
  int? clicktile;
  String? getimage;
  String? selectcatagorytital;
  String dropdownvalue = 'Day';
  String? paymentMethod;

  final TextEditingController controller = TextEditingController();
  final TextEditingController subcatagorycontroller = TextEditingController();
  final TextEditingController fromcontroller = TextEditingController();
  final TextEditingController notescontroller = TextEditingController();
  List<String> listdropdown = [
    'Day',
    'Week',
    'Month',
    'Year',
  ];

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2400),
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
    );

    if (pickedDate != null) {
      _selectedDate = pickedDate;
      print(_selectedDate);
    }
  }

  void showtoast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: AppTheme.colorPrimary,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG);
  }

  // void deletebudget(String id) {
  //   firebaseFirestore
  //       .collection("Budgets")
  //       .doc(userId)
  //       .collection("userbudget")
  //       .doc(id)
  //       .delete();
  //   showtoast("delete succesfully");
  //   Navigator.pop(context);
  // }

  void updatebudget() async {
    if (pay! < double.parse(_value.text)) {
      showtoast("The Amount is up from the given budget.");
    } else {
      // double pay = widget.data.paidAmount! + int.parse(_value.text);

      DateTime originalDate = DateTime.parse(_selectedDate.toString());
      String formattedDate = DateFormat('d/M/yyyy').format(originalDate);
      bool? iscash;
      if (paymentMethod == 'Cash') {
        setState(() {
          iscash = true;
        });
      } else {
        setState(() {
          iscash = false;
        });
      }
      Map<String, dynamic> data = {
        "budgetId": widget.data.budgetId,
        "amount": double.parse(_value.text),
        "isCash": iscash,
        "from": fromcontroller.text,
        "note": notescontroller.text,
        "date": formattedDate,
      };

      var result = await httpClient().post(StaticValues.payBudgets, data: data);

      // firebaseFirestore
      //     .collection("Budgets")
      //     .doc(userId)
      //     .collection("userbudget")
      //     .doc(id)
      //     .update({
      //   'payableamount': pay,
      //   'from': ,
      //   'notes': ,
      // });

      showtoast("update succesfully");
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    }
  }

  double? pay;
  DateTime _selectedDateschedule = DateTime.now();
  Future<void> _selectDateschedule(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2400),
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
    );

    if (pickedDate != null) {
      _selectedDateschedule = pickedDate;
      print(_selectedDateschedule);
    }
  }

  String formatTime = "";
  final TimeOfDay _selectedTime = TimeOfDay.now();
  bool isLoading = false;
  bool status = false;
  @override
  void initState() {
    pay = widget.data.amount! - widget.data.paidAmount!;
    _value.text = pay.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: width * 0.9,
                    height: height * 0.13,
                    decoration: BoxDecoration(
                      color: AppTheme.colorPrimary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: width * 0.065,
                            )),
                        Text(
                          AppLocalizations.of(context)!.budget,
                          style: TextStyle(
                              fontSize: width * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: width * 0.045,
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.1,
                        ),
                        SizedBox(
                          height: height / 80,
                        ),
                        SizedBox(
                          height: height * 0.07,
                          width: width,
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      activeColor: AppTheme.colorPrimary,
                                      value: "Cash",
                                      groupValue: paymentMethod,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          paymentMethod = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.bycash,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      activeColor: AppTheme.colorPrimary,
                                      value:
                                          AppLocalizations.of(context)!.balance,
                                      groupValue: paymentMethod,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          paymentMethod = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.bybank,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height / 80,
                        ),
                        Center(
                            child: SizedBox(
                          width: width * 0.9,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Card(
                                      elevation: 7,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SizedBox(
                                        width: width * 0.4,
                                        child: TextFormField(
                                          controller: _value,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            errorStyle: const TextStyle(
                                                color: Colors.black),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 20),
                                            fillColor: Colors.grey,
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .payable,
                                            alignLabelWithHint: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: AppTheme.colorPrimary),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: AppTheme.colorPrimary),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 30),
                                        child: Text(
                                          DashBoardController.to.curency,
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black87
                                                  .withOpacity(0.7)),
                                        ))

                                    //...............................................
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: width * 0.02),
                                  child: SizedBox(
                                    width: width * 0.4,
                                    child: InkWell(
                                      onTap: () => _selectDate(context),
                                      child: IgnorePointer(
                                        child: TextFormField(
                                          controller: TextEditingController(
                                            text: ' 7/7/2000',
                                          ),
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)!
                                                    .date,
                                            labelStyle: TextStyle(
                                                fontSize: width * 0.045,
                                                color: AppTheme.colorPrimary,
                                                fontWeight: FontWeight.w500),
                                            prefix: Icon(
                                              Icons.calendar_today,
                                              color: AppTheme.colorPrimary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: height * 0.03,
                                ),
                                //.........................................................................................................................
                                index == 1
                                    ? Container(
                                        child: Column(children: [
                                          Card(
                                            elevation: 7,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: SizedBox(
                                              width: width * 0.85,
                                              child: TextFormField(
                                                controller: fromcontroller,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  errorStyle: const TextStyle(
                                                      color: Colors.black),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 0,
                                                          horizontal: 20),
                                                  fillColor: Colors.grey,
                                                  hintText: AppLocalizations.of(
                                                          context)!
                                                      .fromoptional,
                                                  alignLabelWithHint: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: AppTheme
                                                            .colorPrimary),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: AppTheme
                                                            .colorPrimary),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.015,
                                          ),
                                          Card(
                                            elevation: 7,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: SizedBox(
                                              width: width * 0.85,
                                              child: TextFormField(
                                                controller: notescontroller,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  errorStyle: const TextStyle(
                                                      color: Colors.black),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 0,
                                                          horizontal: 20),
                                                  fillColor: Colors.grey,
                                                  hintText: AppLocalizations.of(
                                                          context)!
                                                      .noteoptional,
                                                  alignLabelWithHint: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: AppTheme
                                                            .colorPrimary),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: AppTheme
                                                            .colorPrimary),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      )
                                    : Container(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                            Card(
                                              elevation: 7,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: SizedBox(
                                                width: width * 0.85,
                                                child: TextFormField(
                                                  controller: fromcontroller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                        color: Colors.black),
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 0,
                                                            horizontal: 20),
                                                    fillColor: Colors.grey,
                                                    hintText:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .fromoptional,
                                                    alignLabelWithHint: true,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: AppTheme
                                                              .colorPrimary),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: AppTheme
                                                              .colorPrimary),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                            Card(
                                              elevation: 7,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: SizedBox(
                                                width: width * 0.85,
                                                child: TextFormField(
                                                  controller: notescontroller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                        color: Colors.black),
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 0,
                                                            horizontal: 20),
                                                    fillColor: Colors.grey,
                                                    hintText:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .noteoptional,
                                                    alignLabelWithHint: true,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: AppTheme
                                                              .colorPrimary),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: AppTheme
                                                              .colorPrimary),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                SizedBox(
                                  height: height * 0.07,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.05,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: height * 0.05,
                                          width: width * 0.35,
                                          decoration: BoxDecoration(
                                              color: AppTheme.colorPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .cancel,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.04,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          updatebudget();
                                        },
                                        child: Container(
                                          height: height * 0.05,
                                          width: width * 0.35,
                                          decoration: BoxDecoration(
                                            color: AppTheme.colorPrimary,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .save,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.04,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                        )),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isLoading == true
                  ? Container(
                      height: height,
                      width: width,
                      color: AppTheme.colorPrimary.withOpacity(0.3),
                      child: Center(
                        child: SpinKit.loadSpinkit,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
