// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_final_fields, depend_on_referenced_packages, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:snab_budget/Screens/home_screen.dart';
import 'package:snab_budget/utils/spinkit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snab_budget/calculator/calcu.dart';
import 'package:snab_budget/controller/calculator_controller.dart';
import 'package:snab_budget/controller/dept_controler.dart';
import 'package:snab_budget/models/IncomeDataMode.dart';
import 'package:snab_budget/models/income_catagery._model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../apis/controller/add_debit_controller.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AddCreditDebitScreen extends StatefulWidget {
  final String balanceType;

  const AddCreditDebitScreen({
    super.key,
    required this.balanceType,
  });

  @override
  State<AddCreditDebitScreen> createState() => _AddCreditDebitScreenState();
}

class _AddCreditDebitScreenState extends State<AddCreditDebitScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  //final userId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController controller = TextEditingController();
  final TextEditingController subcatagorycontroller = TextEditingController();
  String formatTime = "";
  String? maingetimage;
  String? selectcatagorytital;
  String? selectcatagoryurl;
  String? selectedcat;
  bool isselectcatagory = false;
  bool isbankclick = true;
  String? paymentMethod;
  final storage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool schedual = false;
  CatagoryModel? catagorymodel;
  int? clicktile;
  var height, width;
  List<SubCatagoriesModel> dummysubcatagorylist = [];
  List<SubCatagoriesModel> subcatagorylistview = [];
  String? getimage;

  IncomeDataCategory? selectcatagorytile;
  List<IncomeData> incomeDatList = [];

  CameraController? _cameraController;

  @override
  void initState() {
    Get.put(AddDebitController());
    Get.put(DeptScreenController());
    DeptScreenController.to.clearcontroller();
    super.initState();
  }

  void initializeCamera() async {
    await Permission.photos.request();
    print("permission+${await Permission.photos.isGranted}");
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController!.initialize();
  }

  bool opencatagoryclick = false;

  @override
  Widget build(BuildContext context) {
    FloatingActionButton.extended(
        onPressed: () {},
        label: Text(AppLocalizations.of(context)!.add).pSymmetric(h: 60));
    height = MediaQuery.of(context).size.height;

    width = MediaQuery.of(context).size.width;

    FloatingActionButton.extended(
        onPressed: () {},
        label: Text(AppLocalizations.of(context)!.add).pSymmetric(h: 60));
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: GetBuilder<AddDebitController>(initState: (state) {
                    AddDebitController.to.getCatagoriesdata("income");
                  }, builder: (obj) {
                    return Column(
                      children: [
                        Container(
                          height: height * 0.07,
                          width: width,
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
                                widget.balanceType == "Debit"
                                    ? AppLocalizations.of(context)!.newdeptor
                                    : AppLocalizations.of(context)!.newcreditor,
                                style: TextStyle(
                                    fontSize: width * 0.04,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: width * 0.21,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: obj.balanceController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                decoration: InputDecoration(
                                    labelText:
                                        "${AppLocalizations.of(context)!.balance}${AppLocalizations.of(context)!.amount}"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .accountname;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                CalculatorController.to.clear();
                                BudgetCalculator.addSimpleCalculatorBottomSheet(
                                    context: context,
                                    height: height,
                                    width: width);
                              },
                              child: Image.asset(
                                "assets/images/cal.png",
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ).pSymmetric(v: 10),

                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .createtheassociatedntransaction,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Column(children: [
                          Row(
                            children: [
                              Radio(
                                activeColor: AppTheme.colorPrimary,
                                value: "Cash",
                                groupValue: paymentMethod,
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                    paymentMethod = value!;
                                  });
                                },
                              ),
                              Text(
                                AppLocalizations.of(context)!.bycash,
                              ),
                              Radio(
                                activeColor: AppTheme.colorPrimary,
                                value: AppLocalizations.of(context)!.bank,
                                groupValue: paymentMethod,
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                    paymentMethod = value!;
                                  });
                                },
                              ),
                              Text(
                                AppLocalizations.of(context)!.bybank,
                              )
                            ],
                          ),
                        ]),
                        InkWell(
                          onTap: () {
                            obj.selectDate(
                              context,
                              obj.currentDateController,
                              obj.currentdate!,
                            );
                          },
                          child: IgnorePointer(
                            child: TextFormField(
                              controller: obj.currentDateController,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.date,
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color:
                                      //provider.brightness == AppBrightness.dark
                                      // ? AppTheme.colorWhite
                                      //:
                                      AppTheme.colorPrimary,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .pleaseenterthecurrentdate;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  obj.selectDate(context, obj.dueDateController,
                                      obj.duedate!);
                                },
                                child: IgnorePointer(
                                  child: TextFormField(
                                    controller: obj.dueDateController,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)!
                                          .paybackdate,
                                      prefixIcon: Icon(Icons.calendar_today,
                                          color:
                                              //   provider.brightness ==
                                              //  AppBrightness.dark
                                              // ?
                                              AppTheme.colorPrimary
                                          // : AppTheme.colorPrimary,
                                          ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .pleaseentertheduedate;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: obj.person,
                          decoration: InputDecoration(
                            labelText: widget.balanceType == "Debit"
                                ? AppLocalizations.of(context)!.from
                                : AppLocalizations.of(context)!.to,
                            prefixIcon: Icon(Icons.person,
                                color:
                                    //provider.brightness == AppBrightness.dark
                                    //?
                                    AppTheme.colorPrimary
                                //: AppTheme.colorPrimary,
                                ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseenteraname;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height / 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.note_alt_outlined,
                              size: 35,
                              color:
                                  // provider.brightness == AppBrightness.dark
                                  //  ? AppTheme.colorWhite
                                  //:
                                  AppTheme.colorPrimary,
                            ).pOnly(right: 10),
                            Expanded(
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SizedBox(
                                  child: TextFormField(
                                    maxLines: 4,
                                    controller: obj.noteController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      errorStyle:
                                          TextStyle(color: Colors.black),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      fillColor: Colors.black.withOpacity(0.2),
                                      hintText:
                                          AppLocalizations.of(context)!.notes,
                                      alignLabelWithHint: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color:
                                              //  provider.brightness ==
                                              //         AppBrightness.dark
                                              //     ? AppTheme.colorWhite
                                              //:
                                              AppTheme.colorPrimary,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  //  provider.brightness ==
                                                  //         AppBrightness.dark
                                                  //?
                                                  AppTheme.colorWhite
                                              //: AppTheme.colorPrimary,
                                              )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height / 30,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.file_present_outlined,
                              size: width * 0.065,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: InkWell(
                                onTap: () {
                                  obj.selectImage(context);
                                },
                                child: Container(
                                  height: height * 0.05,
                                  width: width * 0.2,
                                  decoration: BoxDecoration(
                                      color: AppTheme.colorPrimary,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.addfile,
                                      // AppLocalizations.of(context)!.addFile,
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
                        ),

                        // !isLoading
                        //     ?
                        SizedBox(
                          height: height * 0.025,
                        ),
                        widget.balanceType == "Debit"
                            ? Center(
                                child: SizedBox(
                                  width: width / 2,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    child: InkWell(
                                      onTap: () async {
                                        // obj.isLoading = true;
                                        // obj.update();
                                        bool cash;
                                        if (paymentMethod == "Cash") {
                                          cash = true;
                                        } else {
                                          cash = false;
                                        }

                                        DateTime parsedDate =
                                            DateFormat('MMM d, y').parse(obj
                                                .currentDateController.text
                                                .toString());

                                        String curentdate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(parsedDate);

                                        DateTime parsedDate1 =
                                            DateFormat('MMM d, y').parse(obj
                                                .dueDateController.text
                                                .toString());
                                        String duedate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(parsedDate1);

                                        num amoubt = double.parse(
                                            obj.balanceController.text);
                                        bool cashs;
                                        if (paymentMethod == "Cash") {
                                          cashs = true;
                                        } else {
                                          cashs = false;
                                        }

                                        formatTime =
                                            "${_selectedTime.hour}:${_selectedTime.minute} ${_selectedTime.period.name.toUpperCase()}";
                                        obj.addDebit(
                                          obj.person.text,
                                          obj.noteController.text,
                                          amoubt,
                                          "$curentdate $formatTime",
                                          duedate,
                                          1,
                                          cashs,
                                          obj.catid!,
                                        );
                                        print("date  $curentdate $formatTime ");
                                        print("due date  $duedate ");
                                        Navigator.pop(context);
                                        // Navigator.pop(context);

                                        ///
                                        // obj.isLoading = false;
                                        // obj.update();
                                      },
                                      child: Container(
                                        height: height * 0.05,
                                        width: width * 0.4,
                                        decoration: BoxDecoration(
                                            color: AppTheme.colorPrimary,
                                            borderRadius:
                                                BorderRadius.circular(7)),
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
                                ),
                              )
                            : Center(
                                child: SizedBox(
                                  width: width / 2,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    child: InkWell(
                                      onTap: () async {
                                        bool cash;
                                        if (paymentMethod == "Cash") {
                                          cash = true;
                                        } else {
                                          cash = false;
                                        }

                                        DateTime parsedDate =
                                            DateFormat('MMM d, y').parse(obj
                                                .currentDateController.text
                                                .toString());

                                        String curentdate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(parsedDate);

                                        DateTime parsedDate1 =
                                            DateFormat('MMM d, y').parse(obj
                                                .dueDateController.text
                                                .toString());
                                        String duedate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(parsedDate1);

                                        num amoubt = double.parse(
                                            obj.balanceController.text);
                                        bool cashs;
                                        if (paymentMethod == "Cash") {
                                          cashs = true;
                                        } else {
                                          cashs = false;
                                        }

                                        formatTime =
                                            "${_selectedTime.hour}:${_selectedTime.minute} ${_selectedTime.period.name.toUpperCase()}";
                                        obj.addDebit(
                                          obj.person.text,
                                          obj.noteController.text,
                                          amoubt,
                                          "$curentdate $formatTime",
                                          duedate,
                                          0,
                                          cashs,
                                          obj.catid!,
                                        );
                                        print("date  $curentdate $formatTime ");
                                        print("due date  $duedate ");
                                        Navigator.pop(context);
                                        // Navigator.pop(context);

                                        ///
                                      },
                                      child: Container(
                                        height: height * 0.05,
                                        width: width * 0.4,
                                        decoration: BoxDecoration(
                                            color: AppTheme.colorPrimary,
                                            borderRadius:
                                                BorderRadius.circular(7)),
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
                                ),
                              )

                        // : CircularProgressIndicator()
                      ],
                    );
                  }),
                ),
                // AddDebitController.to.isLoading == true
                //     ? Center(
                //         child: Container(
                //           height: height,
                //           width: width,
                //           color: AppTheme.colorPrimary.withOpacity(0.2),
                //           child: Center(
                //             child: SpinKit.loadSpinkit,
                //           ),
                //         ),
                //       )
                //     : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.anotherpage),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [],
        ),
      ),
    );
  }
}
