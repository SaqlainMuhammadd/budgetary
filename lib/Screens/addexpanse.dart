// ignore_for_file: unused_local_variable, prefer_const_constructors, depend_on_referenced_packages, use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/apis/model/user_category_model.dart';
import 'package:snab_budget/models/IncomeDataMode.dart';
import 'package:snab_budget/models/income_catagery._model.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import 'package:snab_budget/utils/daimond_shape.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:velocity_x/velocity_x.dart';
import 'home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddExpanse extends StatefulWidget {
  static const routeName = "add-expense";
  final num balance;
  final num snabWallet;
  const AddExpanse(
      {super.key, required this.balance, required this.snabWallet});

  @override
  State<AddExpanse> createState() => _AddExpanseState();
}

class _AddExpanseState extends State<AddExpanse> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  // final userId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  final TextEditingController subcatagorycontroller = TextEditingController();
  String formatTime = "";
  String? maingetimage;
  String? selectcatagorytital;
  String? selectcatagoryurl;
  UserCategoryModel? selectedCatagorymodel;
  String? paymentMethod;
  String? selectedcat;
  String? selectedcatId;
  bool isLoading = false;
  bool isselectcatagory = false;

  final storage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool schedual = false;
  CatagoryModel? catagorymodel;
  int? clicktile;
  var height, width;

  List<SubCatagoriesModel> dummysubcatagorylist = [];
  List<SubCatagoriesModel> subcatagorylistview = [];
  String? getimage;

  String? imageUrl;

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

  String? currency = "";

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
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        print(_selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: AppTheme.colorPrimary,
              colorScheme: ColorScheme.light(primary: AppTheme.colorPrimary),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        formatTime =
            "${_selectedTime.hour}:${_selectedTime.minute} ${_selectedTime.period.name.toUpperCase()}";
      });
    }
  }

  IncomeDataCategory? selectcatagorytile;
  List<IncomeData> incomeDatList = [];
  void _saveIncome() async {
    if (_formKey.currentState!.validate() && selectcatagorytital != null) {
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
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
                                builder: (context) => HomeScreen()),
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
      setState(() {
        isLoading = true; // Show the progress indicator
      });

      num amount = double.parse(_amountController.text);
      String name = _nameController.text;
      // Use category name if name is not provided
      DateTime dateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
      );
      bool cash;
      if (paymentMethod == "Cash") {
        cash = true;
      } else {
        cash = false;
      }

      String time =
          "${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year} $formatTime";
      TransactionController.to.addTransaction(
          name, _noteController.text, amount, time, 0, cash, selectedcatId!);
    }
  }

  CameraController? _cameraController;

  @override
  void initState() {
    Get.put(TransactionController());
    TransactionController.to.getCatagoriesdata("expense");

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
        label: Text(
          AppLocalizations.of(context)!.add,
        ).pSymmetric(h: 60));
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          AppLocalizations.of(context)!.add,
        ).pSymmetric(h: 60));
    return SafeArea(
      child: KeyboardVisibilityBuilder(builder: (context, keyboard) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Consumer<BrightnessProvider>(
                  builder: (context, provider, bv) {
                return Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                AppLocalizations.of(context)!.addexpense,
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
                        Text(
                          AppLocalizations.of(context)!.expensename,
                          style: TextStyle(
                              fontSize: width * 0.04,
                              color: provider.brightness == AppBrightness.dark
                                  ? AppTheme.colorWhite
                                  : AppTheme.colorPrimary,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: height / 80,
                        ),
                        Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            width: width * 0.84,
                            child: TextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.black),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                fillColor: Colors.grey,
                                hintText:
                                    "${AppLocalizations.of(context)!.expensename} (optional) ",
                                alignLabelWithHint: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: provider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: provider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 80,
                        ),
                        Text(
                          AppLocalizations.of(context)!.amount,
                          style: TextStyle(
                              fontSize: width * 0.04,
                              color: provider.brightness == AppBrightness.dark
                                  ? AppTheme.colorWhite
                                  : AppTheme.colorPrimary,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: height / 80,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseenteravalidnumber;
                                    }
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .passwordmustbeatleast1digitlong;
                                    }
                                    return null;
                                  },
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    fillColor: Colors.grey,
                                    hintText:
                                        AppLocalizations.of(context)!.amount,
                                    alignLabelWithHint: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: provider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: provider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                DashBoardController.to.curency.toString(),
                                style: TextStyle(
                                    color: AppTheme.colorPrimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
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
                                      value: AppLocalizations.of(context)!.bank,
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
                        Text(
                          AppLocalizations.of(context)!.category,
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: provider.brightness == AppBrightness.dark
                                ? AppTheme.colorWhite
                                : AppTheme.colorPrimary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        GetBuilder<TransactionController>(builder: (obj) {
                          return ListTile(
                            onTap: () {
                              clicktile = null;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, state) {
                                      return AlertDialog(
                                        elevation: 10,
                                        shadowColor: AppTheme.colorPrimary,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .selectcategory,
                                              style: TextStyle(
                                                fontSize: width * 0.035,
                                                fontWeight: FontWeight.bold,
                                                color: provider.brightness ==
                                                        AppBrightness.dark
                                                    ? AppTheme.colorWhite
                                                    : AppTheme.colorPrimary,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: height * 0.04,
                                                width: width * 0.08,
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppTheme.colorPrimary,
                                                    shape: BoxShape.circle),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.clear,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        content: SizedBox(
                                          height: height * 0.8,
                                          width: width,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: obj.model == null
                                                    ? Center(
                                                        child: SpinKitCircle(
                                                          color: AppTheme
                                                              .colorPrimary,
                                                          size: 50.0,
                                                        ),
                                                      )
                                                    : ListView.builder(
                                                        itemCount: obj.model!
                                                            .data!.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return clicktile == index &&
                                                                  clicktile !=
                                                                      null &&
                                                                  opencatagoryclick ==
                                                                      true
                                                              ? Column(
                                                                  children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            selectcatagorytital =
                                                                                obj.model!.data![index].name;
                                                                            selectedcatId =
                                                                                obj.model!.data![index].categoryId;
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            ListTile(
                                                                          trailing: IconButton(
                                                                              onPressed: () {
                                                                                state(() {
                                                                                  clicktile = index;
                                                                                  opencatagoryclick = !opencatagoryclick;
                                                                                });
                                                                                setState(() {});
                                                                              },
                                                                              icon: Icon(
                                                                                clicktile == index && clicktile != null ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined,
                                                                                color: AppTheme.colorPrimary,
                                                                              )),
                                                                          leading:
                                                                              Container(
                                                                            height:
                                                                                height * 0.05,
                                                                            width:
                                                                                width * 0.1,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Image(
                                                                                image: AssetImage(obj.model!.data![index].imageUrl!),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          title:
                                                                              Text(
                                                                            obj.model!.data![index].name!,
                                                                            style: TextStyle(
                                                                                fontSize: width * 0.03,
                                                                                color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        obj.model!.data![index].child!.isEmpty
                                                                            ? AppLocalizations.of(context)!.nosubcategory
                                                                            : "Subcatagories of ${obj.model!.data![index].name!}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.1 *
                                                                            obj.model!.data![index].child!.length,
                                                                        child: ListView
                                                                            .builder(
                                                                          physics:
                                                                              NeverScrollableScrollPhysics(),
                                                                          itemCount: obj
                                                                              .model!
                                                                              .data![index]
                                                                              .child!
                                                                              .length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int i) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: ListTile(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    selectcatagorytital = obj.model!.data![index].child![i].name;
                                                                                    selectedcatId = obj.model!.data![index].child![i].categoryId;
                                                                                  });
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                leading: Container(
                                                                                  height: height * 0.05,
                                                                                  width: width * 0.1,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Image(
                                                                                      image: AssetImage(
                                                                                        obj.model!.data![index].child![i].imageUrl!,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                title: Text(
                                                                                  obj.model!.data![index].child![i].name!,
                                                                                  style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      )
                                                                    ])
                                                              : ListTile(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectcatagorytital = obj
                                                                          .model!
                                                                          .data![
                                                                              index]
                                                                          .name;
                                                                      selectedcatId = obj
                                                                          .model!
                                                                          .data![
                                                                              index]
                                                                          .categoryId;
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  trailing:
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            state(() {
                                                                              clicktile = index;
                                                                              opencatagoryclick = !opencatagoryclick;
                                                                            });
                                                                            setState(() {});
                                                                          },
                                                                          icon:
                                                                              Icon(
                                                                            clicktile == index && clicktile != null
                                                                                ? Icons.arrow_drop_down_outlined
                                                                                : Icons.arrow_drop_up_outlined,
                                                                            color: provider.brightness == AppBrightness.dark
                                                                                ? AppTheme.colorWhite
                                                                                : AppTheme.colorPrimary,
                                                                          )),
                                                                  leading:
                                                                      Container(
                                                                    height:
                                                                        height *
                                                                            0.05,
                                                                    width:
                                                                        width *
                                                                            0.1,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Image(
                                                                        image: AssetImage(obj
                                                                            .model!
                                                                            .data![index]
                                                                            .imageUrl!),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  title: Text(
                                                                    obj
                                                                        .model!
                                                                        .data![
                                                                            index]
                                                                        .name!,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            width *
                                                                                0.03,
                                                                        color: provider.brightness == AppBrightness.dark
                                                                            ? AppTheme
                                                                                .colorWhite
                                                                            : AppTheme
                                                                                .colorPrimary,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                );
                                                        },
                                                      ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    getimage = null;
                                                    isLoading = false;
                                                    subcatagorycontroller.text =
                                                        "";
                                                  });

                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return StatefulBuilder(
                                                            builder:
                                                                (context, set) {
                                                          return SingleChildScrollView(
                                                            child: AlertDialog(
                                                              elevation: 10,
                                                              shadowColor: AppTheme
                                                                  .colorPrimary,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              title: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .newsubcategory,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.035,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: provider.brightness ==
                                                                              AppBrightness
                                                                                  .dark
                                                                          ? AppTheme
                                                                              .colorWhite
                                                                          : AppTheme
                                                                              .colorPrimary,
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          height *
                                                                              0.04,
                                                                      width: width *
                                                                          0.08,
                                                                      decoration: BoxDecoration(
                                                                          color: AppTheme
                                                                              .colorPrimary,
                                                                          shape:
                                                                              BoxShape.circle),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .clear,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              content: Stack(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.8,
                                                                    width:
                                                                        width,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.08,
                                                                          width:
                                                                              width,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                '${AppLocalizations.of(context)!.name} :',
                                                                                style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              SizedBox(
                                                                                width: width * 0.3,
                                                                                child: TextFormField(
                                                                                  controller: subcatagorycontroller,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: "...",
                                                                                    hintStyle: const TextStyle(color: Colors.black),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.08,
                                                                          width:
                                                                              width,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                AppLocalizations.of(context)!.maincategory,
                                                                                style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  ////////// selection
                                                                                  showDialog(
                                                                                      context: context,
                                                                                      builder: (BuildContext context) {
                                                                                        return StatefulBuilder(builder: (context, setstateee) {
                                                                                          return SingleChildScrollView(
                                                                                            child: AlertDialog(
                                                                                                elevation: 10,
                                                                                                shadowColor: AppTheme.colorPrimary,
                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                                title: Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      AppLocalizations.of(context)!.selectcategory,
                                                                                                      style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                                                    ),
                                                                                                    InkWell(
                                                                                                      onTap: () {
                                                                                                        Navigator.pop(context);
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        height: height * 0.04,
                                                                                                        width: width * 0.08,
                                                                                                        decoration: BoxDecoration(color: AppTheme.colorPrimary, shape: BoxShape.circle),
                                                                                                        child: const Center(
                                                                                                          child: Icon(
                                                                                                            Icons.clear,
                                                                                                            size: 15,
                                                                                                            color: Colors.white,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                                  ],
                                                                                                ),
                                                                                                content: SizedBox(
                                                                                                  height: height * 0.8,
                                                                                                  width: width,
                                                                                                  child: ListView.builder(
                                                                                                      itemCount: obj.model!.data!.length,
                                                                                                      itemBuilder: (context, index) {
                                                                                                        return Padding(
                                                                                                          padding: EdgeInsets.symmetric(
                                                                                                            vertical: height * 0.01,
                                                                                                          ),
                                                                                                          child: InkWell(
                                                                                                            onTap: () {
                                                                                                              set(() {
                                                                                                                setstateee(() {
                                                                                                                  selectedcat = obj.model!.data![index].name!;
                                                                                                                  selectedcatId = obj.model!.data![index].categoryId!;
                                                                                                                });
                                                                                                              });

                                                                                                              Navigator.pop(context);
                                                                                                            },
                                                                                                            child: ListTile(
                                                                                                              leading: Container(
                                                                                                                height: height * 0.05,
                                                                                                                width: width * 0.1,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  shape: BoxShape.circle,
                                                                                                                ),
                                                                                                                child: Padding(
                                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                                  child: Image(
                                                                                                                    image: AssetImage(
                                                                                                                      obj.model!.data![index].imageUrl!,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              title: Text(
                                                                                                                obj.model!.data![index].name!,
                                                                                                                style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        );
                                                                                                      }),
                                                                                                )),
                                                                                          );
                                                                                        });
                                                                                      });
                                                                                },
                                                                                child: Container(
                                                                                  color: Colors.grey.withOpacity(0.4),
                                                                                  height: height * 0.05,
                                                                                  width: width * 0.33,
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    selectedcat == null ? AppLocalizations.of(context)!.selectcategory : selectedcat!,
                                                                                    style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                                  )),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.02,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.08,
                                                                          width:
                                                                              width,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                '${AppLocalizations.of(context)!.picture} :',
                                                                                style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              getimage == null
                                                                                  ? CircleAvatar(
                                                                                      radius: 20,
                                                                                      backgroundColor: Colors.grey,
                                                                                    )
                                                                                  : Container(
                                                                                      height: height * 0.05,
                                                                                      width: width * 0.1,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                        color: Colors.grey,
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Image(
                                                                                          image: AssetImage(getimage!),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.02,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.45,
                                                                          width:
                                                                              width,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                GridView.builder(
                                                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                crossAxisCount: 5,
                                                                                mainAxisSpacing: 20.0,
                                                                                crossAxisSpacing: 20.0,
                                                                              ),
                                                                              itemCount: iconList.length,
                                                                              itemBuilder: (context, index) {
                                                                                return InkWell(
                                                                                  onTap: () {
                                                                                    set(() {
                                                                                      getimage = iconList[index];
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                    height: height * 0.05,
                                                                                    width: width * 0.1,
                                                                                    decoration: BoxDecoration(
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Image(
                                                                                        image: AssetImage(iconList[index]),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                set(() {
                                                                                  getimage = null;
                                                                                });
                                                                              },
                                                                              child: Container(
                                                                                height: height * 0.05,
                                                                                width: width * 0.3,
                                                                                decoration: BoxDecoration(color: AppTheme.colorPrimary, borderRadius: BorderRadius.circular(7)),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    AppLocalizations.of(context)!.cancel,
                                                                                    style: TextStyle(fontSize: width * 0.03, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                if (getimage != null && subcatagorycontroller.text.isNotEmpty) {
                                                                                  selectedCatagorymodel = UserCategoryModel(parentId: selectedcatId, imageUrl: getimage, name: subcatagorycontroller.text, type: "income");
                                                                                  TransactionController.to.adddCatagoriesdata(selectedCatagorymodel!);

                                                                                  Navigator.pop(context);
                                                                                } else {
                                                                                  showtoast(AppLocalizations.of(context)!.pleasefullfillallfields);
                                                                                }
                                                                                getimage = null;
                                                                                subcatagorycontroller.text = "";
                                                                              },
                                                                              child: Container(
                                                                                height: height * 0.05,
                                                                                width: width * 0.3,
                                                                                decoration: BoxDecoration(color: AppTheme.colorPrimary, borderRadius: BorderRadius.circular(7)),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    AppLocalizations.of(context)!.save,
                                                                                    style: TextStyle(fontSize: width * 0.03, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                      });
                                                },
                                                child: Container(
                                                  height: height * 0.05,
                                                  width: width * 0.4,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppTheme.colorPrimary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Center(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .newsubcategory,
                                                      style: TextStyle(
                                                          fontSize:
                                                              width * 0.03,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.02,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return StatefulBuilder(
                                                          builder: (context,
                                                              setstateee) {
                                                        return AlertDialog(
                                                          elevation: 10,
                                                          shadowColor: AppTheme
                                                              .colorPrimary,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          title: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .categorymanagement,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.035,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: provider
                                                                              .brightness ==
                                                                          AppBrightness
                                                                              .dark
                                                                      ? AppTheme
                                                                          .colorWhite
                                                                      : AppTheme
                                                                          .colorPrimary,
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height *
                                                                          0.04,
                                                                  width: width *
                                                                      0.08,
                                                                  decoration: BoxDecoration(
                                                                      color: AppTheme
                                                                          .colorPrimary,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  child:
                                                                      const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .clear,
                                                                      size: 15,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          content: SizedBox(
                                                            height:
                                                                height * 0.8,
                                                            width: width,
                                                            child: ListView
                                                                .builder(
                                                                    itemCount: obj
                                                                        .model!
                                                                        .data!
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(
                                                                          vertical:
                                                                              height * 0.01,
                                                                        ),
                                                                        child:
                                                                            ListTile(
                                                                          leading:
                                                                              Container(
                                                                            height:
                                                                                height * 0.05,
                                                                            width:
                                                                                width * 0.1,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Image(
                                                                                image: AssetImage(
                                                                                  obj.model!.data![index].imageUrl!,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          title:
                                                                              Text(
                                                                            obj.model!.data![index].name!,
                                                                            style: TextStyle(
                                                                                fontSize: width * 0.03,
                                                                                color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                          trailing: InkWell(
                                                                              onTap: () {
                                                                                TransactionController.to.deleteCatagoriesdata(obj.model!.data![index].categoryId!, "income");
                                                                              },
                                                                              child: Icon(Icons.delete)),
                                                                        ),
                                                                      );
                                                                    }),
                                                          ),
                                                          actions: <Widget>[
                                                            FloatingActionButton(
                                                              shape:
                                                                  const DiamondBorder(),
                                                              backgroundColor:
                                                                  AppTheme
                                                                      .colorPrimary,
                                                              onPressed: () {
                                                                controller
                                                                    .text = '';
                                                                maingetimage ==
                                                                    null;
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return StatefulBuilder(builder:
                                                                          (context,
                                                                              set) {
                                                                        return SingleChildScrollView(
                                                                          child:
                                                                              AlertDialog(
                                                                            elevation:
                                                                                10,
                                                                            shadowColor:
                                                                                AppTheme.colorPrimary,
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                            title:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  AppLocalizations.of(context)!.addcatagory,
                                                                                  style: TextStyle(
                                                                                    fontSize: width * 0.035,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary,
                                                                                  ),
                                                                                ),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Container(
                                                                                    height: height * 0.04,
                                                                                    width: width * 0.08,
                                                                                    decoration: BoxDecoration(color: AppTheme.colorPrimary, shape: BoxShape.circle),
                                                                                    child: const Center(
                                                                                      child: Icon(
                                                                                        Icons.clear,
                                                                                        size: 15,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            content:
                                                                                SizedBox(
                                                                              height: height * 0.8,
                                                                              width: width,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    height: height * 0.08,
                                                                                    width: width,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          '${AppLocalizations.of(context)!.name} :',
                                                                                          style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: width * 0.3,
                                                                                          child: TextFormField(
                                                                                            controller: controller,
                                                                                            decoration: InputDecoration(
                                                                                              hintText: "...",
                                                                                              hintStyle: const TextStyle(color: Colors.black),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: height * 0.08,
                                                                                    width: width,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          '${AppLocalizations.of(context)!.picture} :',
                                                                                          style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                        maingetimage == null
                                                                                            ? CircleAvatar(
                                                                                                radius: 50,
                                                                                                backgroundColor: Colors.grey,
                                                                                              )
                                                                                            : Container(
                                                                                                height: height * 0.08,
                                                                                                width: width * 0.16,
                                                                                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Image(
                                                                                                    image: AssetImage(maingetimage!),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: height * 0.02,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: height * 0.45,
                                                                                    width: width,
                                                                                    child: Center(
                                                                                      child: GridView.builder(
                                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                          crossAxisCount: 5,
                                                                                          mainAxisSpacing: 20.0,
                                                                                          crossAxisSpacing: 20.0,
                                                                                        ),
                                                                                        itemCount: iconList.length, // Number of grid items
                                                                                        itemBuilder: (context, index) {
                                                                                          return InkWell(
                                                                                              onTap: () {
                                                                                                set(() {
                                                                                                  maingetimage = iconList[index];
                                                                                                });
                                                                                              },
                                                                                              child: Container(
                                                                                                height: height * 0.05,
                                                                                                width: width * 0.1,
                                                                                                decoration: BoxDecoration(
                                                                                                  shape: BoxShape.circle,
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Image(
                                                                                                    image: AssetImage(iconList[index]),
                                                                                                  ),
                                                                                                ),
                                                                                              ));
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          set(() {
                                                                                            maingetimage = null;
                                                                                            Navigator.pop(context);
                                                                                          });
                                                                                        },
                                                                                        child: Container(
                                                                                          height: height * 0.05,
                                                                                          width: width * 0.3,
                                                                                          decoration: BoxDecoration(color: AppTheme.colorPrimary, borderRadius: BorderRadius.circular(7)),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              AppLocalizations.of(context)!.cancel,
                                                                                              style: TextStyle(fontSize: width * 0.03, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          UserCategoryModel model = UserCategoryModel(parentId: null, imageUrl: maingetimage, name: controller.text, type: "income");
                                                                                          TransactionController.to.adddCatagoriesdata(model);

                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Container(
                                                                                          height: height * 0.05,
                                                                                          width: width * 0.3,
                                                                                          decoration: BoxDecoration(color: AppTheme.colorPrimary, borderRadius: BorderRadius.circular(7)),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              AppLocalizations.of(context)!.save,
                                                                                              style: TextStyle(fontSize: width * 0.03, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      });
                                                                    });
                                                              },
                                                              child: Text(
                                                                "+",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        40),
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      });
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  height: height * 0.05,
                                                  width: width * 0.5,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppTheme.colorPrimary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Center(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .categorymanagement,
                                                      style: TextStyle(
                                                          fontSize:
                                                              width * 0.03,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

//                                           content: SizedBox(
//                                                             height: height * 0.8,
//                                                             width: width,
//                                                             child: Column(
//                                                               children: [
//                                                                 Expanded(
//                                                                   child: ListView
//                                                                       .builder(
//                                                                           itemCount: obj.model!.data!.length,
//                                                                           itemBuilder:
//                                                                               (context,
//                                                                                   index) {
//                                                                             return Padding(
//                                                                               padding:
//                                                                                   EdgeInsets.symmetric(
//                                                                                 vertical:
//                                                                                     height * 0.01,
//                                                                               ),
//                                                                               child:
//                                                                                   InkWell(
//                                                                                 onTap:
//                                                                                     () {
//                                                                                   // state(() {
//                                                                                   //   selectcatagorytital = snapshot.data!.docs[index].get("name");

//                                                                                   //   selectcatagoryurl = snapshot.data!.docs[index].get("image");
//                                                                                   //   Navigator.pop(context);
//                                                                                   // });
//                                                                                   // setState(() {});
//                                                                                 },
//                                                                                 child: clicktile == index && clicktile != null && opencatagoryclick == true
//                                                                                     ? Column(
//                                                                                         children: [
//                                                                                           ListTile(
//                                                                                             trailing: IconButton(
//                                                                                                 onPressed: () {
//                                                                                                   state(() {
//                                                                                                     clicktile = index;
//                                                                                                     opencatagoryclick = !opencatagoryclick;
//                                                                                                   });
//                                                                                                   setState(() {});
//                                                                                                 },
//                                                                                                 icon: Icon(
//                                                                                                   clicktile == index && clicktile != null ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined,
//                                                                                                   color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary,
//                                                                                                 )),
//                                                                                             leading: Container(
//                                                                                               height: height * 0.05,
//                                                                                               width: width * 0.1,
//                                                                                               decoration: BoxDecoration(
//                                                                                                 shape: BoxShape.circle,
//                                                                                               ),
//                                                                                               child: Padding(
//                                                                                                 padding: const EdgeInsets.all(8.0),
//                                                                                                 child: Image(
//                                                                                                   image: AssetImage(
//                                                                                                     snapshot.data!.docs[index].get("image"),
//                                                                                                   ),
//                                                                                                 ),
//                                                                                               ),
//                                                                                             ),
//                                                                                             title: Text(
//                                                                                               snapshot.data!.docs[index].get("name"),
//                                                                                               style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
//                                                                                             ),
//                                                                                           ),
//                                                                                           Text(
//                                                                                             snapshot.data!.docs.isEmpty ? AppLocalizations.of(context)!.nosubcategory : "Subcatagories of ${snapshot.data!.docs[index].get("name")}",
//                                                                                             style: TextStyle(
//                                                                                               fontSize: 10,
//                                                                                             ),
//                                                                                           ),
//                                                                                           ///////////////////////////////////////////////////
//                                                                                           StreamBuilder<QuerySnapshot>(
//                                                                                             stream: FirebaseFirestore.instance.collection("catagories").doc(userId).collection("addincomecatagories").where("id", isEqualTo: snapshot.data!.docs[index].get("id")).snapshots(),
//                                                                                             builder: (context, snapshot) {
//                                                                                               if (snapshot.hasData) {
//                                                                                                 SubCatagoriesModel? model;
//                                                                                                 List<SubCatagoriesModel> modelList = [];
//                                                                                                 for (var documentSnapshot in snapshot.data!.docs) {
//                                                                                                   Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
//                                                                                                   List<dynamic> listProperty = data['subcatagories'] ?? [];
//                                                                                                   for (var item in listProperty) {
//                                                                                                     String name = item['name'];
//                                                                                                     String stringValue = item['name'];
//                                                                                                     String id = item['id'];
//                                                                                                     String image = item['image'];
//                                                                                                     String maincatagory = item['maincatagory'];
//                                                                                                     String maincatagoryId = item['maincatagoryId'];

//                                                                                                     model = SubCatagoriesModel(name: name, id: id, image: image, maincatagory: maincatagory, maincatagoryId: maincatagoryId);

//                                                                                                     modelList.add(model);
//                                                                                                   }
//                                                                                                 }
//                                                                                                 subcatagorylistview = modelList;
//                                                                                                 print("subcatagorylistview ${subcatagorylistview.length}");

//                                                                                                 if (snapshot.data!.docs.isNotEmpty) {
//                                                                                                   return SizedBox(
//                                                                                                     height: height * 0.1 * subcatagorylistview.length,
//                                                                                                     child: ListView.builder(
//                                                                                                       physics: NeverScrollableScrollPhysics(),
//                                                                                                       itemCount: subcatagorylistview.length,
//                                                                                                       itemBuilder: (BuildContext context, int index) {
//                                                                                                         return Padding(
//                                                                                                           padding: const EdgeInsets.all(8.0),
//                                                                                                           child: ListTile(
//                                                                                                             onTap: () {
//                                                                                                               setState(() {
//                                                                                                                 selectcatagorytital = subcatagorylistview[index].name;
//                                                                                                               });
//                                                                                                               Navigator.pop(context);
//                                                                                                             },
//                                                                                                             leading: Container(
//                                                                                                               height: height * 0.05,
//                                                                                                               width: width * 0.1,
//                                                                                                               decoration: BoxDecoration(
//                                                                                                                 shape: BoxShape.circle,
//                                                                                                                 color: AppTheme.colorPrimary,
//                                                                                                               ),
//                                                                                                               child: Padding(
//                                                                                                                 padding: const EdgeInsets.all(8.0),
//                                                                                                                 child: Image(
//                                                                                                                   image: AssetImage(
//                                                                                                                     subcatagorylistview[index].image!,
//                                                                                                                   ),
//                                                                                                                 ),
//                                                                                                               ),
//                                                                                                             ),
//                                                                                                             title: Text(
//                                                                                                               subcatagorylistview[index].name!,
//                                                                                                               style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                         );
//                                                                                                       },
//                                                                                                     ),
//                                                                                                   );
//                                                                                                 } else {
//                                                                                                   return Center(
//                                                                                                     child: Text(AppLocalizations.of(context)!.nosubcategory),
//                                                                                                   );
//                                                                                                 }
//                                                                                               } else {
//                                                                                                 return Center(
//                                                                                                   child: CircularProgressIndicator(),
//                                                                                                 );
//                                                                                               }
//                                                                                             },
//                                                                                           ),

// ///////////////////////////////////////////////////////////////////
//                                                                                         ],
//                                                                                       )
//                                                                                     : ListTile(
//                                                                                         trailing: IconButton(
//                                                                                             onPressed: () {
//                                                                                               state(() {
//                                                                                                 clicktile = index;
//                                                                                                 opencatagoryclick = !opencatagoryclick;
//                                                                                               });
//                                                                                             },
//                                                                                             icon: Icon(
//                                                                                               clicktile == index && clicktile != null ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined,
//                                                                                               color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary,
//                                                                                             )),
//                                                                                         leading: Container(
//                                                                                           height: height * 0.05,
//                                                                                           width: width * 0.1,
//                                                                                           decoration: BoxDecoration(
//                                                                                             shape: BoxShape.circle,
//                                                                                           ),
//                                                                                           child: Padding(
//                                                                                             padding: const EdgeInsets.all(8.0),
//                                                                                             child: Image(
//                                                                                               image: AssetImage(
//                                                                                                 obj.model!.data![index].imageUrl!,
//                                                                                               ),
//                                                                                             ),
//                                                                                           ),
//                                                                                         ),
//                                                                                         title: Text(
//                                                                                            obj.model!.data![index].name!,
//                                                                                           style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
//                                                                                         ),
//                                                                                       ),
//                                                                               ),
//                                                                             );
//                                                                           }),
//                                                                 ),
//                                                                 SizedBox(
//                                                                   height:
//                                                                       height * 0.02,
//                                                                 ),
//                                                                 InkWell(
//                                                                   onTap: () {
//                                                                     // setState(() {
//                                                                     //   getimage =
//                                                                     //       null;
//                                                                     //   isLoading =
//                                                                     //       false;
//                                                                     //   subcatagorycontroller
//                                                                     //       .text = "";
//                                                                     // });

//                                                                     // showDialog(
//                                                                     //     context:
//                                                                     //         context,
//                                                                     //     builder:
//                                                                     //         (BuildContext
//                                                                     //             context) {
//                                                                     //       return StatefulBuilder(builder:
//                                                                     //           (context,
//                                                                     //               set) {
//                                                                     //         return SingleChildScrollView(
//                                                                     //           child:
//                                                                     //               AlertDialog(
//                                                                     //             elevation:
//                                                                     //                 10,
//                                                                     //             shadowColor:
//                                                                     //                 AppTheme.colorPrimary,
//                                                                     //             shape:
//                                                                     //                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                                                                     //             title:
//                                                                     //                 Row(
//                                                                     //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                     //               children: [
//                                                                     //                 Text(
//                                                                     //                   AppLocalizations.of(context)!.newsubcategory,
//                                                                     //                   style: TextStyle(
//                                                                     //                     fontSize: width * 0.035,
//                                                                     //                     fontWeight: FontWeight.bold,
//                                                                     //                     color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary,
//                                                                     //                   ),
//                                                                     //                 ),
//                                                                     //                 InkWell(
//                                                                     //                   onTap: () {
//                                                                     //                     Navigator.pop(context);
//                                                                     //                   },
//                                                                     //                   child: Container(
//                                                                     //                     height: height * 0.04,
//                                                                     //                     width: width * 0.08,
//                                                                     //                     decoration: BoxDecoration(color: AppTheme.colorPrimary, shape: BoxShape.circle),
//                                                                     //                     child: const Center(
//                                                                     //                       child: Icon(
//                                                                     //                         Icons.clear,
//                                                                     //                         size: 15,
//                                                                     //                         color: Colors.white,
//                                                                     //                       ),
//                                                                     //                     ),
//                                                                     //                   ),
//                                                                     //                 )
//                                                                     //               ],
//                                                                     //             ),
//                                                                     //             content:
//                                                                     //                 Stack(
//                                                                     //               children: [
//                                                                     //                 SizedBox(
//                                                                     //                   height: height * 0.8,
//                                                                     //                   width: width,
//                                                                     //                   child: Column(
//                                                                     //                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                                     //                     children: [
//                                                                     //                       SizedBox(
//                                                                     //                         height: height * 0.08,
//                                                                     //                         width: width,
//                                                                     //                         child: Row(
//                                                                     //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                                     //                           crossAxisAlignment: CrossAxisAlignment.center,
//                                                                     //                           children: [
//                                                                     //                             Text(
//                                                                     //                               '${AppLocalizations.of(context)!.name} :',
//                                                                     //                               style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
//                                                                     //                             ),
//                                                                     //                             SizedBox(
//                                                                     //                               width: width * 0.3,
//                                                                     //                               child: TextFormField(
//                                                                     //                                 controller: subcatagorycontroller,
//                                                                     //                                 decoration: InputDecoration(
//                                                                     //                                   hintText: "...",
//                                                                     //                                   hintStyle: const TextStyle(color: Colors.black),
//                                                                     //                                 ),
//                                                                     //                               ),
//                                                                     //                             ),
//                                                                     //                           ],
//                                                                     //                         ),
//                                                                     //                       ),
//                                                                     //                       SizedBox(
//                                                                     //                         height: height * 0.08,
//                                                                     //                         width: width,
//                                                                     //                         child: Row(
//                                                                     //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                                     //                           crossAxisAlignment: CrossAxisAlignment.center,
//                                                                     //                           children: [
//                                                                     //                             Text(
//                                                                     //                               AppLocalizations.of(context)!.maincategory,
//                                                                     //                               style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
//                                                                     //                             ),
//                                                                     //                             InkWell(
//                                                                     //                               onTap: () {
//                                                                     //                                 ////////// selection
//                                                                     //                                 showDialog(
//                                                                     //                                     context: context,
//                                                                     //                                     builder: (BuildContext context) {
//                                                                     //                                       return StatefulBuilder(builder: (context, setstateee) {
//                                                                     //                                         return SingleChildScrollView(
//                                                                     //                                           child: AlertDialog(
//                                                                     //                                             elevation: 10,
//                                                                     //                                             shadowColor: AppTheme.colorPrimary,
//                                                                     //                                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                                                                     //                                             title: Row(
//                                                                     //                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                     //                                               children: [
//                                                                     //                                                 Text(
//                                                                     //                                                   AppLocalizations.of(context)!.selectcategory,
//                                                                     //                                                   style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
//                                                                     //                                                 ),
//                                                                     //                                                 InkWell(
//                                                                     //                                                   onTap: () {
//                                                                     //                                                     Navigator.pop(context);
//                                                                     //                                                   },
//                                                                     //                                                   child: Container(
//                                                                     //                                                     height: height * 0.04,
//                                                                     //                                                     width: width * 0.08,
//                                                                     //                                                     decoration: BoxDecoration(color: AppTheme.colorPrimary, shape: BoxShape.circle),
//                                                                     //                                                     child: const Center(
//                                                                     //                                                       child: Icon(
//                                                                     //                                                         Icons.clear,
//                                                                     //                                                         size: 15,
//                                                                     //                                                         color: Colors.white,
//                                                                     //                                                       ),
//                                                                     //                                                     ),
//                                                                     //                                                   ),
//                                                                     //                                                 )
//                                                                     //                                               ],
//                                                                     //                                             ),
//                                                                     //                                             content: StreamBuilder<QuerySnapshot>(
//                                                                     //                                                 stream: firebaseFirestore.collection("catagories").doc(userId).collection("addincomecatagories").snapshots(),
//                                                                     //                                                 builder: (context, snapshot) {
//                                                                     //                                                   return snapshot.hasData
//                                                                     //                                                       ? snapshot.data == null
//                                                                     //                                                           ? Center(
//                                                                     //                                                               child: SpinKitCircle(
//                                                                     //                                                                 color: AppTheme.colorPrimary,
//                                                                     //                                                                 size: 50.0,
//                                                                     //                                                               ),
//                                                                     //                                                             )
//                                                                     //                                                           : SizedBox(
//                                                                     //                                                               height: height * 0.8,
//                                                                     //                                                               width: width,
//                                                                     //                                                               child: ListView.builder(
//                                                                     //                                                                   itemCount: snapshot.data!.docs.length,
//                                                                     //                                                                   itemBuilder: (context, index) {
//                                                                     //                                                                     print("catagorymodel $catagorymodel");

//                                                                     //                                                                     return Padding(
//                                                                     //                                                                       padding: EdgeInsets.symmetric(
//                                                                     //                                                                         vertical: height * 0.01,
//                                                                     //                                                                       ),
//                                                                     //                                                                       child: InkWell(
//                                                                     //                                                                         onTap: () {
//                                                                     //                                                                           catagorymodel = CatagoryModel(
//                                                                     //                                                                             id: snapshot.data!.docs[index].get("id"),
//                                                                     //                                                                             image: snapshot.data!.docs[index].get("image"),
//                                                                     //                                                                             name: snapshot.data!.docs[index].get("name"),
//                                                                     //                                                                             subcatagories: snapshot.data!.docs[index].get("subcatagories") ?? [],
//                                                                     //                                                                           );
//                                                                     //                                                                           print("catagorymodel $catagorymodel");
//                                                                     //                                                                           set(() {
//                                                                     //                                                                             setstateee(() {
//                                                                     //                                                                               selectedcat = snapshot.data!.docs[index].get("name");
//                                                                     //                                                                               print("selectedcat $selectedcat");
//                                                                     //                                                                             });
//                                                                     //                                                                           });

//                                                                     //                                                                           Navigator.pop(context);
//                                                                     //                                                                         },
//                                                                     //                                                                         child: ListTile(
//                                                                     //                                                                           leading: Container(
//                                                                     //                                                                             height: height * 0.05,
//                                                                     //                                                                             width: width * 0.1,
//                                                                     //                                                                             decoration: BoxDecoration(
//                                                                     //                                                                               shape: BoxShape.circle,
//                                                                     //                                                                             ),
//                                                                     //                                                                             child: Padding(
//                                                                     //                                                                               padding: const EdgeInsets.all(8.0),
//                                                                     //                                                                               child: Image(
//                                                                     //                                                                                 image: AssetImage(
//                                                                     //                                                                                   snapshot.data!.docs[index].get("image"),
//                                                                     //                                                                                 ),
//                                                                     //                                                                               ),
//                                                                     //                                                                             ),
//                                                                     //                                                                           ),
//                                                                     //                                                                           title: Text(
//                                                                     //                                                                             snapshot.data!.docs[index].get("name"),
//                                                                     //                                                                             style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
//                                                                     //                                                                           ),
//                                                                     //                                                                         ),
//                                                                     //                                                                       ),
//                                                                     //                                                                     );
//                                                                     //                                                                   }),
//                                                                     //                                                             )
//                                                                     //                                                       : Center(child: Text(AppLocalizations.of(context)!.nodatafound));
//                                                                     //                                                 }),
//                                                                     //                                           ),
//                                                                     //                                         );
//                                                                     //                                       });
//                                                                     //                                     });
//                                                                     //                               },
//                                                                     //                               child: Container(
//                                                                     //                                 color: Colors.grey.withOpacity(0.4),
//                                                                     //                                 height: height * 0.05,
//                                                                     //                                 width: width * 0.33,
//                                                                     //                                 child: Center(
//                                                                     //                                     child: Text(
//                                                                     //                                   selectedcat == null ? AppLocalizations.of(context)!.selectcategory : selectedcat!,
//                                                                     //                                   style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
//                                                                     //                                 )),
//                                                                     //                               ),
//                                                                     //                             ),
//                                                                     //                           ],
//                                                                     //                         ),
//                                                                     //                       ),
//                                                                     //                       SizedBox(
//                                                                     //                         height: height * 0.02,
//                                                                     //                       ),
//                                                                     //                       SizedBox(
//                                                                     //                         height: height * 0.08,
//                                                                     //                         width: width,
//                                                                     //                         child: Row(
//                                                                     //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                                     //                           crossAxisAlignment: CrossAxisAlignment.center,
//                                                                     //                           children: [
//                                                                     //                             Text(
//                                                                     //                               '${AppLocalizations.of(context)!.picture} :',
//                                                                     //                               style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
//                                                                     //                             ),
//                                                                     //                             getimage == null
//                                                                     //                                 ? CircleAvatar(
//                                                                     //                                     radius: 20,
//                                                                     //                                     backgroundColor: Colors.grey,
//                                                                     //                                   )
//                                                                     //                                 : Container(
//                                                                     //                                     height: height * 0.05,
//                                                                     //                                     width: width * 0.1,
//                                                                     //                                     decoration: BoxDecoration(
//                                                                     //                                       shape: BoxShape.circle,
//                                                                     //                                       color: Colors.grey,
//                                                                     //                                     ),
//                                                                     //                                     child: Padding(
//                                                                     //                                       padding: const EdgeInsets.all(8.0),
//                                                                     //                                       child: Image(
//                                                                     //                                         image: AssetImage(getimage!),
//                                                                     //                                       ),
//                                                                     //                                     ),
//                                                                     //                                   )
//                                                                     //                           ],
//                                                                     //                         ),
//                                                                     //                       ),
//                                                                     //                       SizedBox(
//                                                                     //                         height: height * 0.02,
//                                                                     //                       ),
//                                                                     //                       SizedBox(
//                                                                     //                         height: height * 0.45,
//                                                                     //                         width: width,
//                                                                     //                         child: Center(
//                                                                     //                           child: GridView.builder(
//                                                                     //                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                                                     //                               crossAxisCount: 5,
//                                                                     //                               mainAxisSpacing: 20.0,
//                                                                     //                               crossAxisSpacing: 20.0,
//                                                                     //                             ),
//                                                                     //                             itemCount: iconList.length, // Number of grid items
//                                                                     //                             itemBuilder: (context, index) {
//                                                                     //                               return InkWell(
//                                                                     //                                 onTap: () {
//                                                                     //                                   set(() {
//                                                                     //                                     getimage = iconList[index];
//                                                                     //                                     print("getimage $getimage");
//                                                                     //                                   });
//                                                                     //                                 },
//                                                                     //                                 child: Container(
//                                                                     //                                   height: height * 0.05,
//                                                                     //                                   width: width * 0.1,
//                                                                     //                                   decoration: BoxDecoration(
//                                                                     //                                     shape: BoxShape.circle,
//                                                                     //                                   ),
//                                                                     //                                   child: Padding(
//                                                                     //                                     padding: const EdgeInsets.all(8.0),
//                                                                     //                                     child: Image(
//                                                                     //                                       image: AssetImage(iconList[index]),
//                                                                     //                                     ),
//                                                                     //                                   ),
//                                                                     //                                 ),
//                                                                     //                               );
//                                                                     //                             },
//                                                                     //                           ),
//                                                                     //                         ),
//                                                                     //                       ),
//                                                                     //                       Row(
//                                                                     //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                                     //                         crossAxisAlignment: CrossAxisAlignment.center,
//                                                                     //                         children: [
//                                                                     //                           InkWell(
//                                                                     //                             onTap: () {
//                                                                     //                               set(() {
//                                                                     //                                 getimage = null;
//                                                                     //                               });
//                                                                     //                             },
//                                                                     //                             child: Container(
//                                                                     //                               height: height * 0.05,
//                                                                     //                               width: width * 0.3,
//                                                                     //                               decoration: BoxDecoration(color: AppTheme.colorPrimary, borderRadius: BorderRadius.circular(7)),
//                                                                     //                               child: Center(
//                                                                     //                                 child: Text(
//                                                                     //                                   AppLocalizations.of(context)!.cancel,
//                                                                     //                                   style: TextStyle(fontSize: width * 0.03, color: Colors.white, fontWeight: FontWeight.bold),
//                                                                     //                                 ),
//                                                                     //                               ),
//                                                                     //                             ),
//                                                                     //                           ),
//                                                                     //                           InkWell(
//                                                                     //                             onTap: () {
//                                                                     //                               /////////////jgsduuwfdgy
//                                                                     //                               if (getimage != null && catagorymodel != null && subcatagorycontroller.text.isNotEmpty) {
//                                                                     //                                 dummysubcatagorylist.add(SubCatagoriesModel(
//                                                                     //                                   id: dummysubcatagorylist.length.toString(),
//                                                                     //                                   image: getimage,
//                                                                     //                                   maincatagory: catagorymodel!.name,
//                                                                     //                                   maincatagoryId: catagorymodel!.id,
//                                                                     //                                   name: subcatagorycontroller.text,
//                                                                     //                                 ));
//                                                                     //                                 postsubcatagories(dummysubcatagorylist);
//                                                                     //                               } else {
//                                                                     //                                 showtoast("please fullfill all fields");
//                                                                     //                               }
//                                                                     //                               getimage = null;
//                                                                     //                               subcatagorycontroller.text = "";
//                                                                     //                             },
//                                                                     //                             child: Container(
//                                                                     //                               height: height * 0.05,
//                                                                     //                               width: width * 0.3,
//                                                                     //                               decoration: BoxDecoration(color: AppTheme.colorPrimary, borderRadius: BorderRadius.circular(7)),
//                                                                     //                               child: Center(
//                                                                     //                                 child: Text(
//                                                                     //                                   AppLocalizations.of(context)!.save,
//                                                                     //                                   style: TextStyle(fontSize: width * 0.03, color: Colors.white, fontWeight: FontWeight.bold),
//                                                                     //                                 ),
//                                                                     //                               ),
//                                                                     //                             ),
//                                                                     //                           ),
//                                                                     //                         ],
//                                                                     //                       ),
//                                                                     //                     ],
//                                                                     //                   ),
//                                                                     //                 ),
//                                                                     //                 // isLoading == true ? showspinkit(context) : SizedBox(),
//                                                                     //               ],
//                                                                     //             ),
//                                                                     //             // actions: <Widget>[
//                                                                     //             //   InkWell(
//                                                                     //             //     onTap: () {},
//                                                                     //             //   ),
//                                                                     //             // ],
//                                                                     //           ),
//                                                                     //         );
//                                                                     //       });
//                                                                     //     });
//                                                                   },
//                                                                   child: Container(
//                                                                     height: height *
//                                                                         0.05,
//                                                                     width:
//                                                                         width * 0.4,
//                                                                     decoration: BoxDecoration(
//                                                                         color: AppTheme
//                                                                             .colorPrimary,
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(
//                                                                                 7)),
//                                                                     child: Center(
//                                                                       child: Text(
//                                                                         // AppLocalizations.of(context)!.add,
//                                                                         AppLocalizations.of(
//                                                                                 context)!
//                                                                             .newsubcategory,
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                                 width *
//                                                                                     0.03,
//                                                                             color: Colors
//                                                                                 .white,
//                                                                             fontWeight:
//                                                                                 FontWeight.bold),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 SizedBox(
//                                                                   height:
//                                                                       height * 0.02,
//                                                                 ),
//                                                                 InkWell(
//                                                                   onTap: () {

//                                                                     // showDialog(
//                                                                     //   context:
//                                                                     //       context,
//                                                                     //   builder:
//                                                                     //       (BuildContext
//                                                                     //           context) {
//                                                                     //     return StatefulBuilder(builder:
//                                                                     //         (context,
//                                                                     //             setstateee) {
//                                                                     //       return AlertDialog(
//                                                                     //         elevation:
//                                                                     //             10,
//                                                                     //         shadowColor:
//                                                                     //             AppTheme.colorPrimary,
//                                                                     //         shape: RoundedRectangleBorder(
//                                                                     //             borderRadius:
//                                                                     //                 BorderRadius.circular(20)),
//                                                                     //         title:
//                                                                     //             Row(
//                                                                     //           mainAxisAlignment:
//                                                                     //               MainAxisAlignment.spaceBetween,
//                                                                     //           children: [
//                                                                     //             Text(
//                                                                     //               AppLocalizations.of(context)!.categorymanagement,
//                                                                     //               style: TextStyle(
//                                                                     //                 fontSize: width * 0.035,
//                                                                     //                 fontWeight: FontWeight.bold,
//                                                                     //                 color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary,
//                                                                     //               ),
//                                                                     //             ),
//                                                                     //             InkWell(
//                                                                     //               onTap: () {
//                                                                     //                 Navigator.pop(context);
//                                                                     //               },
//                                                                     //               child: Container(
//                                                                     //                 height: height * 0.04,
//                                                                     //                 width: width * 0.08,
//                                                                     //                 decoration: BoxDecoration(color: AppTheme.colorPrimary, shape: BoxShape.circle),
//                                                                     //                 child: const Center(
//                                                                     //                   child: Icon(
//                                                                     //                     Icons.clear,
//                                                                     //                     size: 15,
//                                                                     //                     color: Colors.white,
//                                                                     //                   ),
//                                                                     //                 ),
//                                                                     //               ),
//                                                                     //             )
//                                                                     //           ],
//                                                                     //         ),
//                                                                     //         content: StreamBuilder<
//                                                                     //                 QuerySnapshot>(
//                                                                     //             stream:
//                                                                     //                 firebaseFirestore.collection("catagories").doc(userId).collection("addincomecatagories").snapshots(),
//                                                                     //             builder: (context, snapshot) {
//                                                                     //               return snapshot.hasData
//                                                                     //                   ? snapshot.data == null
//                                                                     //                       ? Center(
//                                                                     //                           child: SpinKitCircle(
//                                                                     //                             color: AppTheme.colorPrimary,
//                                                                     //                             size: 50.0,
//                                                                     //                           ),
//                                                                     //                         )
//                                                                     //                       : SizedBox(
//                                                                     //                           height: height * 0.8,
//                                                                     //                           width: width,
//                                                                     //                           child: ListView.builder(
//                                                                     //                               itemCount: snapshot.data!.docs.length,
//                                                                     //                               itemBuilder: (context, index) {
//                                                                     //                                 return Padding(
//                                                                     //                                   padding: EdgeInsets.symmetric(
//                                                                     //                                     vertical: height * 0.01,
//                                                                     //                                   ),
//                                                                     //                                   child: ListTile(
//                                                                     //                                     leading: Container(
//                                                                     //                                       height: height * 0.05,
//                                                                     //                                       width: width * 0.1,
//                                                                     //                                       decoration: BoxDecoration(
//                                                                     //                                         shape: BoxShape.circle,
//                                                                     //                                       ),
//                                                                     //                                       child: Padding(
//                                                                     //                                         padding: const EdgeInsets.all(8.0),
//                                                                     //                                         child: Image(
//                                                                     //                                           image: AssetImage(
//                                                                     //                                             snapshot.data!.docs[index].get("image"),
//                                                                     //                                           ),
//                                                                     //                                         ),
//                                                                     //                                       ),
//                                                                     //                                     ),
//                                                                     //                                     title: Text(
//                                                                     //                                       snapshot.data!.docs[index].get("name"),
//                                                                     //                                       style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
//                                                                     //                                     ),
//                                                                     //                                     trailing: InkWell(
//                                                                     //                                         onTap: () {
//                                                                     //                                           deletecatagory(
//                                                                     //                                             snapshot.data!.docs[index].get("id"),
//                                                                     //                                           );
//                                                                     //                                         },
//                                                                     //                                         child: Icon(Icons.delete)),
//                                                                     //                                   ),
//                                                                     //                                 );
//                                                                     //                               }),
//                                                                     //                         )
//                                                                     //                   : Center(child: Text(AppLocalizations.of(context)!.nodatafound));
//                                                                     //             }),
//                                                                     //         actions: <Widget>[
//                                                                     //           FloatingActionButton(
//                                                                     //             shape:
//                                                                     //                 const DiamondBorder(),
//                                                                     //             backgroundColor:
//                                                                     //                 AppTheme.colorPrimary,
//                                                                     //             onPressed:
//                                                                     //                 () {
//                                                                     //               controller.text = '';
//                                                                     //               maingetimage == null;
//                                                                     //               showDialog(
//                                                                     //                   context: context,
//                                                                     //                   builder: (BuildContext context) {
//                                                                     //                     return StatefulBuilder(builder: (context, set) {
//                                                                     //                       return SingleChildScrollView(
//                                                                     //                         child: AlertDialog(
//                                                                     //                           elevation: 10,
//                                                                     //                           shadowColor: AppTheme.colorPrimary,
//                                                                     //                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                                                                     //                           title: Row(
//                                                                     //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                     //                             children: [
//                                                                     //                               Text(
//                                                                     //                                 AppLocalizations.of(context)!.addcatagory,
//                                                                     //                                 style: TextStyle(
//                                                                     //                                   fontSize: width * 0.035,
//                                                                     //                                   fontWeight: FontWeight.bold,
//                                                                     //                                   color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary,
//                                                                     //                                 ),
//                                                                     //                               ),
//                                                                     //                               InkWell(
//                                                                     //                                 onTap: () {
//                                                                     //                                   Navigator.pop(context);
//                                                                     //                                 },
//                                                                     //                                 child: Container(
//                                                                     //                                   height: height * 0.04,
//                                                                     //                                   width: width * 0.08,
//                                                                     //                                   decoration: BoxDecoration(color: AppTheme.colorPrimary, shape: BoxShape.circle),
//                                                                     //                                   child: const Center(
//                                                                     //                                     child: Icon(
//                                                                     //                                       Icons.clear,
//                                                                     //                                       size: 15,
//                                                                     //                                       color: Colors.white,
//                                                                     //                                     ),
//                                                                     //                                   ),
//                                                                     //                                 ),
//                                                                     //                               )
//                                                                     //                             ],
//                                                                     //                           ),
//                                                                     //                           content: SizedBox(
//                                                                     //                             height: height * 0.8,
//                                                                     //                             width: width,
//                                                                     //                             child: Column(
//                                                                     //                               crossAxisAlignment: CrossAxisAlignment.start,
//                                                                     //                               children: [
//                                                                     //                                 SizedBox(
//                                                                     //                                   height: height * 0.08,
//                                                                     //                                   width: width,
//                                                                     //                                   child: Row(
//                                                                     //                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                                     //                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                                                     //                                     children: [
//                                                                     //                                       Text(
//                                                                     //                                         '${AppLocalizations.of(context)!.name} :',
//                                                                     //                                         style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
//                                                                     //                                       ),
//                                                                     //                                       SizedBox(
//                                                                     //                                         width: width * 0.3,
//                                                                     //                                         child: TextFormField(
//                                                                     //                                           controller: controller,
//                                                                     //                                           decoration: InputDecoration(
//                                                                     //                                             hintText: "...",
//                                                                     //                                             hintStyle: const TextStyle(color: Colors.black),
//                                                                     //                                           ),
//                                                                     //                                         ),
//                                                                     //                                       ),
//                                                                     //                                     ],
//                                                                     //                                   ),
//                                                                     //                                 ),
//                                                                     //                                 SizedBox(
//                                                                     //                                   height: height * 0.08,
//                                                                     //                                   width: width,
//                                                                     //                                   child: Row(
//                                                                     //                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                                     //                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                                                     //                                     children: [
//                                                                     //                                       Text(
//                                                                     //                                         '${AppLocalizations.of(context)!.picture} :',
//                                                                     //                                         style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
//                                                                     //                                       ),
//                                                                     //                                       maingetimage == null
//                                                                     //                                           ? CircleAvatar(
//                                                                     //                                               radius: 50,
//                                                                     //                                               backgroundColor: Colors.grey,
//                                                                     //                                             )
//                                                                     //                                           : Container(
//                                                                     //                                               height: height * 0.08,
//                                                                     //                                               width: width * 0.16,
//                                                                     //                                               decoration: BoxDecoration(
//                                                                     //                                                 shape: BoxShape.circle,
//                                                                     //                                                 color: Colors.grey,
//                                                                     //                                               ),
//                                                                     //                                               child: Padding(
//                                                                     //                                                 padding: const EdgeInsets.all(8.0),
//                                                                     //                                                 child: Image(
//                                                                     //                                                   image: AssetImage(maingetimage!),
//                                                                     //                                                 ),
//                                                                     //                                               ),
//                                                                     //                                             )
//                                                                     //                                     ],
//                                                                     //                                   ),
//                                                                     //                                 ),
//                                                                     //                                 SizedBox(
//                                                                     //                                   height: height * 0.02,
//                                                                     //                                 ),
//                                                                     //                                 SizedBox(
//                                                                     //                                   height: height * 0.45,
//                                                                     //                                   width: width,
//                                                                     //                                   child: Center(
//                                                                     //                                     child: GridView.builder(
//                                                                     //                                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                                                     //                                         crossAxisCount: 5,
//                                                                     //                                         mainAxisSpacing: 20.0,
//                                                                     //                                         crossAxisSpacing: 20.0,
//                                                                     //                                       ),
//                                                                     //                                       itemCount: iconList.length, // Number of grid items
//                                                                     //                                       itemBuilder: (context, index) {
//                                                                     //                                         return InkWell(
//                                                                     //                                             onTap: () {
//                                                                     //                                               set(() {
//                                                                     //                                                 maingetimage = iconList[index];
//                                                                     //                                               });
//                                                                     //                                             },
//                                                                     //                                             child: Container(
//                                                                     //                                               height: height * 0.05,
//                                                                     //                                               width: width * 0.1,
//                                                                     //                                               decoration: BoxDecoration(
//                                                                     //                                                 shape: BoxShape.circle,
//                                                                     //                                               ),
//                                                                     //                                               child: Padding(
//                                                                     //                                                 padding: const EdgeInsets.all(8.0),
//                                                                     //                                                 child: Image(
//                                                                     //                                                   image: AssetImage(iconList[index]),
//                                                                     //                                                 ),
//                                                                     //                                               ),
//                                                                     //                                             ));
//                                                                     //                                       },
//                                                                     //                                     ),
//                                                                     //                                   ),
//                                                                     //                                 ),
//                                                                     //                                 Row(
//                                                                     //                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                                     //                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                                                     //                                   children: [
//                                                                     //                                     InkWell(
//                                                                     //                                       onTap: () {
//                                                                     //                                         set(() {
//                                                                     //                                           maingetimage = null;
//                                                                     //                                         });
//                                                                     //                                       },
//                                                                     //                                       child: Container(
//                                                                     //                                         height: height * 0.05,
//                                                                     //                                         width: width * 0.3,
//                                                                     //                                         decoration: BoxDecoration(color: AppTheme.colorPrimary, borderRadius: BorderRadius.circular(7)),
//                                                                     //                                         child: Center(
//                                                                     //                                           child: Text(
//                                                                     //                                             "${AppLocalizations.of(context)!.cancel}",
//                                                                     //                                             style: TextStyle(fontSize: width * 0.03, color: Colors.white, fontWeight: FontWeight.bold),
//                                                                     //                                           ),
//                                                                     //                                         ),
//                                                                     //                                       ),
//                                                                     //                                     ),
//                                                                     //                                     InkWell(
//                                                                     //                                       onTap: () {
//                                                                     //                                         postCatgoriestoDB();
//                                                                     //                                       },
//                                                                     //                                       child: Container(
//                                                                     //                                         height: height * 0.05,
//                                                                     //                                         width: width * 0.3,
//                                                                     //                                         decoration: BoxDecoration(color: AppTheme.colorPrimary, borderRadius: BorderRadius.circular(7)),
//                                                                     //                                         child: Center(
//                                                                     //                                           child: Text(
//                                                                     //                                             "${AppLocalizations.of(context)!.save}",
//                                                                     //                                             style: TextStyle(fontSize: width * 0.03, color: Colors.white, fontWeight: FontWeight.bold),
//                                                                     //                                           ),
//                                                                     //                                         ),
//                                                                     //                                       ),
//                                                                     //                                     ),
//                                                                     //                                   ],
//                                                                     //                                 ),
//                                                                     //                               ],
//                                                                     //                             ),
//                                                                     //                           ),
//                                                                     //                           // actions: <Widget>[
//                                                                     //                           //   InkWell(
//                                                                     //                           //     onTap: () {},
//                                                                     //                           //   ),
//                                                                     //                           // ],
//                                                                     //                         ),
//                                                                     //                       );
//                                                                     //                     });
//                                                                     //                   });
//                                                                     //             },
//                                                                     //             child:
//                                                                     //                 Text(
//                                                                     //               "+",
//                                                                     //               style: TextStyle(fontSize: 40, color: Colors.white),
//                                                                     //             ),
//                                                                     //           )
//                                                                     //         ],
//                                                                     //       );
//                                                                     //     });
//                                                                     //   },
//                                                                     // );

//                                                                   },
//                                                                   child: Container(
//                                                                     height: height *
//                                                                         0.05,
//                                                                     width:
//                                                                         width * 0.5,
//                                                                     decoration: BoxDecoration(
//                                                                         color: AppTheme
//                                                                             .colorPrimary,
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(
//                                                                                 7)),
//                                                                     child: Center(
//                                                                       child: Text(
//                                                                         // AppLocalizations.of(context)!.add,
//                                                                         AppLocalizations.of(
//                                                                                 context)!
//                                                                             .categorymanagement,
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                                 width *
//                                                                                     0.03,
//                                                                             color: Colors
//                                                                                 .white,
//                                                                             fontWeight:
//                                                                                 FontWeight.bold),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 SizedBox(
//                                                                   height:
//                                                                       height * 0.1,
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
                                        // content: StreamBuilder<QuerySnapshot>(
                                        //     stream: firebaseFirestore
                                        //         .collection("catagories")
                                        //         .doc(userId)
                                        //         .collection("addincomecatagories")
                                        //         .snapshots(),
                                        //     builder: (context, snapshot) {
                                        //       return snapshot.hasData
                                        //           ? snapshot.data == null
                                        //               ? Center(
                                        //                   child: SpinKitCircle(
                                        //                     color: AppTheme
                                        //                         .colorPrimary,
                                        //                     size: 50.0,
                                        //                   ),
                                        //                 )
                                        //               :
                                        //           : Center(
                                        //               child: Text(
                                        //                   AppLocalizations.of(
                                        //                           context)!
                                        //                       .nodatafound));
                                        //     }),
                                      );
                                    });
                                  });
                            },
                            title: Text(
                              selectcatagorytital ??
                                  AppLocalizations.of(context)!.selectcategory,
                              style: TextStyle(
                                fontSize: width * 0.035,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_drop_down,
                              color: provider.brightness == AppBrightness.dark
                                  ? AppTheme.colorWhite
                                  : AppTheme.colorPrimary,
                            ),
                          );
                        }),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => _selectDate(context),
                                child: IgnorePointer(
                                  child: TextFormField(
                                    controller: TextEditingController(
                                      text:
                                          '  ${DateFormat.yMMMd().format(_selectedDate)}',
                                    ),
                                    decoration: InputDecoration(
                                      labelText:
                                          AppLocalizations.of(context)!.date,
                                      labelStyle: TextStyle(
                                          fontSize: width * 0.045,
                                          color: provider.brightness ==
                                                  AppBrightness.dark
                                              ? AppTheme.colorWhite
                                              : AppTheme.colorPrimary,
                                          fontWeight: FontWeight.w500),
                                      prefix: Icon(
                                        Icons.calendar_today,
                                        color: provider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: width / 3.3),
                            InkWell(
                              onTap: () => _selectTime(context),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.access_time),
                                  SizedBox(width: 15),
                                  Text(
                                    '${_selectedTime.hour}:${_selectedTime.minute}',
                                    style: TextStyle(
                                        fontSize: width * 0.045,
                                        color: provider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                              color: provider.brightness == AppBrightness.dark
                                  ? AppTheme.colorWhite
                                  : AppTheme.colorPrimary,
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
                                    controller: _noteController,
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
                                            color: AppTheme.colorPrimary),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: AppTheme.colorPrimary),
                                      ),
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
                                  TransactionController.to
                                      .selectImage(context, height, width);
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
                                      style: TextStyle(
                                          fontSize: width * 0.03,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //     width: 200,
                            //     child: Text(
                            //       pathFile,
                            //       softWrap: true,
                            //     )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            !schedual
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        schedual = true;
                                      });
                                      //   schedualeTransaction();
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.schedule,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: provider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                      ),
                                    ),
                                  )
                                : CircularProgressIndicator(),
                          ],
                        )
                      ],
                    ).pSymmetric(h: 20),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    // !isLoading
                    //     ?
                    Center(
                      child: SizedBox(
                        width: width / 2,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          child: InkWell(
                            onTap: () {
                              _saveIncome();
                            },
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.4,
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
                      ),
                    ),
                    // : CircularProgressIndicator()
                    keyboard
                        ? SizedBox(
                            height: height * 0.2,
                          )
                        : SizedBox()
                  ],
                );
              }),
            ),
          ),
        );
      }),
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

class DropdownItem {
  final String name;
  final String imagePath;

  DropdownItem(this.name, this.imagePath);
}
