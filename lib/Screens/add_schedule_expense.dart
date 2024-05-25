import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/apis/model/user_wallet_model.dart' as wal;
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as deo;
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/Screens/home_screen.dart';
import 'package:snab_budget/apis/ApiStore.dart';
import 'package:snab_budget/apis/model/user_category_model.dart';
import 'package:snab_budget/apis/model/user_wallet_model.dart';
import 'package:snab_budget/calculator/calcu.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/models/IncomeDataMode.dart';
import 'package:snab_budget/models/account.dart';
import 'package:snab_budget/models/income_catagery._model.dart';
import 'package:snab_budget/static_data.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/utils/daimond_shape.dart';
import 'package:snab_budget/utils/spinkit.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:uuid/uuid.dart';

import '../controller/calculator_controller.dart';
import '../utils/brighness_provider.dart';

class ScheduleExpenses extends StatefulWidget {
  const ScheduleExpenses({super.key});

  @override
  State<ScheduleExpenses> createState() => _ScheduleExpensesState();
}

class _ScheduleExpensesState extends State<ScheduleExpenses> {
  final TextEditingController _value = TextEditingController();
  final TextEditingController numberoftimescontroller = TextEditingController();
  final TextEditingController repeatcontrooler = TextEditingController();
  int index = 1;
  var height, width;
  bool opencatagoryclick = false;
  String walletname = "Select Wallet";
  CatagoryModel? catagorymodel;
  int? clicktile;
  String? getimage;
  XFile? pickImage;
  String? maingetimage;
  String? selectedcatId;
  String? selectcatagorytital;
  String dropdownvalue = 'Day';
  UserCategoryModel? selectedCatagorymodel;
  String? selectcatagoryurl;
  String? paymentMethod;
  String? selectedcat;
  // final userId = FirebaseAuth.instance.currentUser!.uid;
  List<SubCatagoriesModel> dummysubcatagorylist = [];
  List<SubCatagoriesModel> subcatagorylistview = [];
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
  final storage = FirebaseStorage.instance;
  bool isLoading = false;
  bool status = false;
  bool isselectcatagory = false;

  final _formKey = GlobalKey<FormState>();
  // void postsubcatagories(List<SubCatagoriesModel> lissst) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   if (lissst.isNotEmpty) {
  //     SubCatagoriesModel? model;
  //     List<dynamic> dynamicList = [];
  //     for (int i = 0; i < lissst.length; i++) {
  //       model = lissst[i];
  //       var dynamicObj = {
  //         'name': model.name,
  //         'id': model.id,
  //         'image': model.image,
  //         'maincatagory': model.maincatagory,
  //         'maincatagoryId': model.maincatagoryId,
  //       };
  //       dynamicList.add(dynamicObj);
  //       setState(() {});
  //     }
  //     await firebaseFirestore
  //         .collection("catagories")
  //         .doc(userId)
  //         .collection("addschedulecatagories")
  //         .doc(catagorymodel!.id)
  //         .update({'subcatagories': dynamicList});
  //     showtoast("added sucessfully");
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Navigator.pop(context);
  //   }
  // }

  // void postsubcatagories(List<SubCatagoriesModel> lissst) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   if (lissst.isNotEmpty) {
  //     SubCatagoriesModel? model;
  //     List<dynamic> dynamicList = [];
  //     for (int i = 0; i < lissst.length; i++) {
  //       model = lissst[i];
  //       var dynamicObj = {
  //         'name': model.name,
  //         'id': model.id,
  //         'image': model.image,
  //         'maincatagory': model.maincatagory,
  //         'maincatagoryId': model.maincatagoryId,
  //       };
  //       dynamicList.add(dynamicObj);
  //       setState(() {});
  //     }
  //     await firebaseFirestore
  //         .collection("catagories")
  //         .doc(userId)
  //         .collection("addincomecatagories")
  //         .doc(catagorymodel!.id)
  //         .update({'subcatagories': dynamicList});
  //     showtoast("added sucessfully");
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Navigator.pop(context);
  //   }
  // }

  // void adddCatagoriesdata() async {
  //   for (var u in IncomeDataCategory.incomeCategories) {
  //     await firebaseFirestore
  //         .collection("catagories")
  //         .doc(userId)
  //         .collection("addincomecatagories")
  //         .doc(u.id)
  //         .set({
  //       "name": u.name,
  //       "image": u.image,
  //       "id": u.id,
  //       "subcatagories": null,
  //     });
  //   }
  // }

  String? imageUrl;

  // void postCatgoriestoDB() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   if (controller.text.isNotEmpty && maingetimage != null) {
  //     String id = const Uuid().v4();

  //     ////// mainget image
  //     CatagoryModel model = CatagoryModel(
  //       id: id,
  //       name: controller.text,
  //       image: maingetimage,
  //       subcatagories: null,
  //     );
  //     await firebaseFirestore
  //         .collection("catagories")
  //         .doc(userId)
  //         .collection("addincomecatagories")
  //         .doc(id)
  //         .set(model.toMap());
  //     showtoast("Added succesfully");
  //     setState(() {
  //       isLoading = false;
  //     });
  //     // ignore: use_build_context_synchronously
  //     Navigator.pop(context);
  //   } else {
  //     showtoast("give all fields");
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // void showtoast(String msg) {
  //   Fluttertoast.showToast(
  //       msg: msg,
  //       backgroundColor: AppTheme.colorPrimary,
  //       textColor: Colors.white,
  //       gravity: ToastGravity.BOTTOM,
  //       fontSize: 17,
  //       timeInSecForIosWeb: 1,
  //       toastLength: Toast.LENGTH_LONG);
  // }

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
      setState(() {
        _selectedDate = pickedDate;
        print(_selectedDate);
      });
    }
  }

  DateTime _selectedDateschedule = DateTime.now();
  Future<void> _selectDateschedule(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateschedule,
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
      setState(() {
        _selectedDateschedule = pickedDate;
        print(_selectedDateschedule);
      });
    }
  }

  String formatTime = "";
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<File> _createFile(Uint8List data) async {
    // Create a temporary directory
    Directory tempDir = await getTemporaryDirectory();

    // Generate a unique file name
    String tempPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Write the data to a file
    File file = File(tempPath);
    await file.writeAsBytes(data);

    return file;
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
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    if (pickedTime != null) {
      _selectedTime = pickedTime;
      formatTime = "${_selectedTime.hour}:${_selectedTime.minute}";
    }
  }

  String pathPickImage = "null";
  String pathFile = "null";

  Future<File> compressImage(XFile img) async {
    pathPickImage = img.path;
    setState(() {
      pathFile = img.path;
    });
    final File imageFile = File(img.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    if (imageBytes.length <= 300 * 1024) {
      return imageFile;
    } else if (imageBytes.length >= 300 * 1024 &&
        imageBytes.length <= 600 * 1024) {
      Uint8List uint8List = Uint8List.fromList(imageBytes);
      List<int> compressedBytes = await FlutterImageCompress.compressWithList(
        uint8List,
        quality: 25,
      );
      Uint8List compressedData = Uint8List.fromList(compressedBytes);
      File compressedFile = await _createFile(compressedData);
      return compressedFile;
    } else if (imageBytes.length >= 600 * 1024 &&
        imageBytes.length <= 999 * 1024) {
      Uint8List uint8List = Uint8List.fromList(imageBytes);
      List<int> compressedBytes = await FlutterImageCompress.compressWithList(
        uint8List,
        quality: 10,
      );
      Uint8List compressedData = Uint8List.fromList(compressedBytes);
      File compressedFile = await _createFile(compressedData);
      return compressedFile;
    } else {
      Uint8List uint8List = Uint8List.fromList(imageBytes);
      List<int> compressedBytes = await FlutterImageCompress.compressWithList(
        uint8List,
        quality: 5,
      );
      Uint8List compressedData = Uint8List.fromList(compressedBytes);
      File compressedFile = await _createFile(compressedData);
      return compressedFile;
    }
  }

  // Future<void> _uploadPicture(File file) async {
  //   final String fileName = '${DateTime.now()}.jpg';
  //   final Reference storageRef = storage.ref().child(fileName);
  //   final UploadTask uploadTask = storageRef.putFile(file);
  //   await uploadTask.whenComplete(() async {
  //     final imageUrl = await storageRef.getDownloadURL();
  //     pathPickImage = imageUrl;
  //     await firebaseFirestore
  //         .collection("UserTransactions")
  //         .doc(userId)
  //         .collection("SchedualTrsanactions")
  //         .doc(id)
  //         .update({
  //       'mainFileUrl': pathPickImage,
  //     });
  //   });
  // }

  String? id;
  String? walletID;
  void postschedule(context) async {
    setState(() {
      isLoading = true;
    });

    if (_formKey.currentState!.validate() &&
        selectcatagorytital != null &&
        walletname != "Select Wallet" &&
        paymentMethod!.isNotEmpty) {
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

      double amount = double.parse(_value.text);
      bool cash;
      if (paymentMethod == "Cash") {
        cash = true;
      } else {
        cash = false;
      }
      int? days;
      if (dropdownvalue == 'Day') {
        days = 1;
      } else if (dropdownvalue == 'Week') {
        days = 7;
      } else if (dropdownvalue == 'Month') {
        days = 30;
      } else if (dropdownvalue == 'Year') {
        days = 365;
      }

      String time =
          "${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year} $formatTime";
      try {
        deo.FormData data = pickImage == null
            ? deo.FormData.fromMap({
                "From": fromcontroller.text,
                "Name": walletname,
                "Amount": amount,
                "Note": notescontroller.text,
                "DateTime":
                    "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                "Type": 0,
                "IsCash": cash,
                "CategoryId": selectedcatId,
                "Days": days,
                "SecondDateTime":
                    "${_selectedDateschedule.day}/${_selectedDateschedule.month}/${_selectedDateschedule.year}",
                "NOT": int.parse(numberoftimescontroller.text),
                "Repeats": int.parse(repeatcontrooler.text),
                "File": null
              })
            : deo.FormData.fromMap({
                "From": fromcontroller.text,
                "Name": walletname,
                "SecondDateTime":
                    "${_selectedDateschedule.day}/${_selectedDateschedule.month}/${_selectedDateschedule.year}",
                "Note": notescontroller.text,
                "NOT": int.parse(numberoftimescontroller.text),
                "Days": days,
                "Amount": amount,
                "DateTime":
                    "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                "Type": 0,
                "IsCash": cash,
                "CategoryId": selectedcatId,
                "Repeats": int.parse(repeatcontrooler.text),
                "File": await deo.MultipartFile.fromFile(
                  pickImage!.path,
                  filename: basename(pickImage!.path),
                ),
              });
        print("Rdata.toString() ${data.fields}");

        var response = await httpFormDataClient()
            .post(StaticValues.addcscheduleTransaction, data: data);
        print("Response status Cose ${response.statusCode}");

        if (response.statusCode == 200) {
          if (response.data != null) {
            print("Response data data ${response.data}");
          }
        }
        return response.data;
      } catch (e) {
        print("Exception = $e");
      }
      setState(() {
        isLoading = true;
      });

      pathFile = "";
    } else {
      showtoast("give all fields");
    }
  }

  Future<void> selectImage(BuildContext context) async {
    final PermissionStatus status = await Permission.camera.request();
    final PermissionStatus status1 = await Permission.storage.request();
    if (status.isGranted && status1.isGranted) {
      // ignore: use_build_context_synchronously
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    AppLocalizations.of(context)!.selectimage,
                    style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.colorPrimary),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .doyouwanttoselectanimagefromgallery,
                    style: TextStyle(
                      fontSize: width * 0.035,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.9,
                    height: height * 0.07,
                    child: Row(
                      children: [
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.gallery,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.colorPrimary)),
                          onPressed: () async {
                            pickImage = await picker.pickImage(
                                source: ImageSource.gallery);

                            // Handle the picked image
                            if (pickImage != null) {
                              File compressedFile =
                                  await compressImage(pickImage as XFile);
                              // _uploadPicture(compressedFile);
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.camera,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.colorPrimary)),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            pickImage = await picker.pickImage(
                                source: ImageSource.camera);
                            // Handle the picked image
                            if (pickImage != null) {
                              pathPickImage = pickImage!.path;

                              setState(() {
                                pathFile = pickImage!.path;
                              });

                              final File imageFile = File(pickImage!.path);

                              // _uploadPicture(imageFile);
                            }
                          },
                        ),
                        TextButton(
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, color: Colors.red),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      // Handle the case where the user denied permission
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.permissiondenied,
            ),
            content: Text(
              AppLocalizations.of(context)!.pleasegrantpermissionphoto,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  await Permission.photos.request();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  IncomeDataCategory? selectcatagorytile;
  List<IncomeData> incomeDatList = [];
  final picker = ImagePicker();

  void deletecatagory(String id) async {
    // await firebaseFirestore
    //     .collection("catagories")
    //     .doc(userId)
    //     .collection("addincomecatagories")
    //     .doc(id)
    //     .delete();
    // showtoast("delete sucessfully");
  }
//function for storing data and passing to another screen

  @override
  void initState() {
    Get.put(TransactionController());
    TransactionController.to.getCatagoriesdata("expense");
    TransactionController.to.fetchAccounts();
    id = const Uuid().v4();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer<BrightnessProvider>(
            builder: (context, brightnessprovider, _) {
          return Form(
            key: _formKey,
            child: SizedBox(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                            color: AppTheme.colorPrimary,
                            borderRadius: const BorderRadius.only(
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            index = 0;
                            fromcontroller.clear();
                            notescontroller.clear();
                            setState(() {});
                          },
                          child: Container(
                            height: height * 0.06,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: index == 0
                                            ? AppTheme.colorPrimary
                                            : Colors.grey))),
                            child: Center(
                                child: Icon(
                              Icons.menu,
                              size: width * 0.06,
                              color: index == 0
                                  ? AppTheme.colorPrimary
                                  : Colors.grey,
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            index = 1;
                            fromcontroller.clear();
                            notescontroller.clear();
                            setState(() {});
                          },
                          child: Container(
                            height: height * 0.06,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: index == 1
                                            ? AppTheme.colorPrimary
                                            : Colors.grey))),
                            child: Center(
                                child: Icon(
                              Icons.schedule_outlined,
                              size: width * 0.06,
                              color: index == 1
                                  ? AppTheme.colorPrimary
                                  : Colors.grey,
                            )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Center(
                        child: SizedBox(
                      width: width * 0.9,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        errorStyle: const TextStyle(
                                            color: Colors.black),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 20),
                                        fillColor: Colors.grey,
                                        hintText:
                                            AppLocalizations.of(context)!.value,
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
                                SizedBox(
                                  width: width * 0.2,
                                ),
                                InkWell(
                                  onTap: () {
                                    CalculatorController.to.clear();
                                    BudgetCalculator
                                        .addSimpleCalculatorBottomSheet(
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
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              AppLocalizations.of(context)!.category,
                              style: TextStyle(
                                fontSize: width * 0.04,
                                color: brightnessprovider.brightness ==
                                        AppBrightness.dark
                                    ? AppTheme.colorWhite
                                    : AppTheme.colorPrimary,
                                fontWeight: FontWeight.w500,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .selectcategory,
                                                  style: TextStyle(
                                                    fontSize: width * 0.035,
                                                    fontWeight: FontWeight.bold,
                                                    color: brightnessprovider
                                                                .brightness ==
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
                                                        color: AppTheme
                                                            .colorPrimary,
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
                                                            child:
                                                                SpinKitCircle(
                                                              color: AppTheme
                                                                  .colorPrimary,
                                                              size: 50.0,
                                                            ),
                                                          )
                                                        : ListView.builder(
                                                            itemCount: obj
                                                                .model!
                                                                .data!
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
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
                                                                              setState(() {
                                                                                selectcatagorytital = obj.model!.data![index].name;
                                                                                selectedcatId = obj.model!.data![index].categoryId;
                                                                              });
                                                                              Navigator.pop(context);
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
                                                                              leading: Container(
                                                                                height: height * 0.05,
                                                                                width: width * 0.1,
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Image(
                                                                                    image: AssetImage(obj.model!.data![index].imageUrl!),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              title: Text(
                                                                                obj.model!.data![index].name!,
                                                                                style: TextStyle(fontSize: width * 0.03, color: brightnessprovider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            obj.model!.data![index].child!.isEmpty
                                                                                ? AppLocalizations.of(context)!.nosubcategory
                                                                                : "Subcatagories of ${obj.model!.data![index].name!}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 10,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: height *
                                                                                0.1 *
                                                                                obj.model!.data![index].child!.length,
                                                                            child:
                                                                                ListView.builder(
                                                                              physics: NeverScrollableScrollPhysics(),
                                                                              itemCount: obj.model!.data![index].child!.length,
                                                                              itemBuilder: (BuildContext context, int i) {
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
                                                                                      style: TextStyle(fontSize: width * 0.03, color: brightnessprovider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          )
                                                                        ])
                                                                  : ListTile(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          selectcatagorytital = obj
                                                                              .model!
                                                                              .data![index]
                                                                              .name;
                                                                          selectedcatId = obj
                                                                              .model!
                                                                              .data![index]
                                                                              .categoryId;
                                                                        });
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      trailing: IconButton(
                                                                          onPressed: () {
                                                                            state(() {
                                                                              clicktile = index;
                                                                              opencatagoryclick = !opencatagoryclick;
                                                                            });
                                                                            setState(() {});
                                                                          },
                                                                          icon: Icon(
                                                                            clicktile == index && clicktile != null
                                                                                ? Icons.arrow_drop_down_outlined
                                                                                : Icons.arrow_drop_up_outlined,
                                                                            color: brightnessprovider.brightness == AppBrightness.dark
                                                                                ? AppTheme.colorWhite
                                                                                : AppTheme.colorPrimary,
                                                                          )),
                                                                      leading:
                                                                          Container(
                                                                        height: height *
                                                                            0.05,
                                                                        width: width *
                                                                            0.1,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Image(
                                                                            image:
                                                                                AssetImage(obj.model!.data![index].imageUrl!),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        obj
                                                                            .model!
                                                                            .data![index]
                                                                            .name!,
                                                                        style: TextStyle(
                                                                            fontSize: width *
                                                                                0.03,
                                                                            color: brightnessprovider.brightness == AppBrightness.dark
                                                                                ? AppTheme.colorWhite
                                                                                : AppTheme.colorPrimary,
                                                                            fontWeight: FontWeight.bold),
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
                                                        subcatagorycontroller
                                                            .text = "";
                                                      });

                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return StatefulBuilder(
                                                                builder:
                                                                    (context,
                                                                        set) {
                                                              return SingleChildScrollView(
                                                                child:
                                                                    AlertDialog(
                                                                  elevation: 10,
                                                                  shadowColor:
                                                                      AppTheme
                                                                          .colorPrimary,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  title: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        AppLocalizations.of(context)!
                                                                            .newsubcategory,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              width * 0.035,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: brightnessprovider.brightness == AppBrightness.dark
                                                                              ? AppTheme.colorWhite
                                                                              : AppTheme.colorPrimary,
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              height * 0.04,
                                                                          width:
                                                                              width * 0.08,
                                                                          decoration: BoxDecoration(
                                                                              color: AppTheme.colorPrimary,
                                                                              shape: BoxShape.circle),
                                                                          child:
                                                                              const Center(
                                                                            child:
                                                                                Icon(
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
                                                                      Stack(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.8,
                                                                        width:
                                                                            width,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
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
                                                                                    style: TextStyle(fontSize: width * 0.03, color: brightnessprovider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
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
                                                                              height: height * 0.08,
                                                                              width: width,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    AppLocalizations.of(context)!.maincategory,
                                                                                    style: TextStyle(fontSize: width * 0.03, color: brightnessprovider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
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
                                                                                                          style: TextStyle(fontSize: width * 0.03, color: brightnessprovider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
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
                                                                                                                    style: TextStyle(fontSize: width * 0.03, color: brightnessprovider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
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
                                                                                        style: TextStyle(fontSize: width * 0.03, color: brightnessprovider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                                      )),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: height * 0.02,
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
                                                                                    style: TextStyle(fontSize: width * 0.03, color: brightnessprovider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
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
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                                          color: AppTheme
                                                              .colorPrimary,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7)),
                                                      child: Center(
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .newsubcategory,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.03,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                        builder: (BuildContext
                                                            context) {
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
                                                                      color: brightnessprovider.brightness ==
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
                                                              content: SizedBox(
                                                                height: height *
                                                                    0.8,
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
                                                                              vertical: height * 0.01,
                                                                            ),
                                                                            child:
                                                                                ListTile(
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
                                                                                style: TextStyle(fontSize: width * 0.03, color: brightnessprovider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
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
                                                                  onPressed:
                                                                      () {
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
                                                                              (context, set) {
                                                                            return SingleChildScrollView(
                                                                              child: AlertDialog(
                                                                                elevation: 10,
                                                                                shadowColor: AppTheme.colorPrimary,
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                title: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.addcatagory,
                                                                                      style: TextStyle(
                                                                                        fontSize: width * 0.035,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: brightnessprovider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary,
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
                                                                                content: SizedBox(
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
                                                                                              style: TextStyle(fontSize: width * 0.03, color: brightnessprovider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
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
                                                                                              style: TextStyle(fontSize: width * 0.03, color: brightnessprovider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
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
                                                          color: AppTheme
                                                              .colorPrimary,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7)),
                                                      child: Center(
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .categorymanagement,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.03,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                      AppLocalizations.of(context)!
                                          .selectcategory,
                                  style: TextStyle(
                                    fontSize: width * 0.035,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_drop_down,
                                  color: brightnessprovider.brightness ==
                                          AppBrightness.dark
                                      ? AppTheme.colorWhite
                                      : AppTheme.colorPrimary,
                                ),
                              );
                            }),

                            SizedBox(
                              height: height * 0.01,
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
                                          value: AppLocalizations.of(context)!
                                              .bank,
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
                            InkWell(
                              onTap: () {
                                showWalletDialog(
                                  context,
                                  height,
                                  width,
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.wallet,
                                    size: width * 0.06,
                                    color: brightnessprovider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                  ),
                                  Text(
                                    "  ${AppLocalizations.of(context)!.wallet} :",
                                    style: TextStyle(
                                      fontSize: width * 0.05,
                                      color: brightnessprovider.brightness ==
                                              AppBrightness.dark
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "  $walletname",
                                    style: TextStyle(
                                      fontSize: width * 0.045,
                                      color: brightnessprovider.brightness ==
                                              AppBrightness.dark
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.4,
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
                                          color:
                                              brightnessprovider.brightness ==
                                                      AppBrightness.dark
                                                  ? AppTheme.colorWhite
                                                  : AppTheme.colorPrimary,
                                          fontWeight: FontWeight.w500),
                                      prefix: Icon(
                                        Icons.calendar_today,
                                        color: brightnessprovider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            ///////////
                            index == 1
                                ? Container(
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Card(
                                            elevation: 7,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: SizedBox(
                                              width: width * 0.4,
                                              child: TextFormField(
                                                controller: repeatcontrooler,
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
                                                      .repeatesevery,
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
                                          Card(
                                            elevation: 7,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              height: height * 0.055,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color:
                                                        AppTheme.colorPrimary,
                                                  )),
                                              width: width * 0.4,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  dropdownColor:
                                                      brightnessprovider
                                                                  .brightness ==
                                                              AppBrightness.dark
                                                          ? AppTheme
                                                              .darkbackground
                                                          : AppTheme.colorWhite,
                                                  focusColor:
                                                      AppTheme.colorPrimary,
                                                  value: dropdownvalue,
                                                  style: TextStyle(
                                                      color:
                                                          AppTheme.colorPrimary,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: width * 0.035),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      dropdownvalue =
                                                          newValue as String;
                                                    });
                                                  },
                                                  items: listdropdown.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: TextStyle(
                                                            color: brightnessprovider
                                                                        .brightness ==
                                                                    AppBrightness
                                                                        .dark
                                                                ? AppTheme
                                                                    .colorWhite
                                                                : AppTheme
                                                                    .colorPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                width * 0.035),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  hint: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .selecttype),
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: brightnessprovider
                                                                .brightness ==
                                                            AppBrightness.dark
                                                        ? AppTheme.colorWhite
                                                        : AppTheme.colorPrimary,
                                                  ),
                                                  elevation: 1,
                                                  isExpanded: true,
                                                  isDense: true,
                                                  selectedItemBuilder:
                                                      (BuildContext context) {
                                                    return listdropdown
                                                        .map<Widget>(
                                                            (String value) {
                                                      return Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Text(
                                                            value,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: brightnessprovider
                                                                            .brightness ==
                                                                        AppBrightness
                                                                            .dark
                                                                    ? AppTheme
                                                                        .colorWhite
                                                                    : AppTheme
                                                                        .colorPrimary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      );
                                                    }).toList();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Card(
                                            elevation: 7,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: SizedBox(
                                              width: width * 0.4,
                                              child: TextFormField(
                                                controller:
                                                    numberoftimescontroller,
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
                                                      .numberoftimes,
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
                                          Text(
                                            AppLocalizations.of(context)!
                                                .zeroimesmeanslimitless,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: brightnessprovider
                                                          .brightness ==
                                                      AppBrightness.dark
                                                  ? AppTheme.colorWhite
                                                  : AppTheme.colorPrimary,
                                            ),
                                          ),
                                        ],
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
                                            keyboardType: TextInputType.text,
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
                                                      .fromoptional,
                                              alignLabelWithHint: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color:
                                                        AppTheme.colorPrimary),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color:
                                                        AppTheme.colorPrimary),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 7,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SizedBox(
                                          width: width * 0.85,
                                          child: TextField(
                                            controller: notescontroller,
                                            keyboardType: TextInputType.text,
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
                                                      .noteoptional,
                                              alignLabelWithHint: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color:
                                                        AppTheme.colorPrimary),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color:
                                                        AppTheme.colorPrimary),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.05),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () =>
                                                    _selectDateschedule(
                                                        context),
                                                child: IgnorePointer(
                                                  child: TextFormField(
                                                    controller:
                                                        TextEditingController(
                                                      text:
                                                          '  ${DateFormat.yMMMd().format(_selectedDateschedule)}',
                                                    ),
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .date,
                                                      labelStyle: TextStyle(
                                                          fontSize:
                                                              width * 0.045,
                                                          color: brightnessprovider
                                                                      .brightness ==
                                                                  AppBrightness
                                                                      .dark
                                                              ? AppTheme
                                                                  .colorWhite
                                                              : AppTheme
                                                                  .colorPrimary,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      prefix: Icon(
                                                        Icons.calendar_today,
                                                        color: brightnessprovider
                                                                    .brightness ==
                                                                AppBrightness
                                                                    .dark
                                                            ? AppTheme
                                                                .colorWhite
                                                            : AppTheme
                                                                .colorPrimary,
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
                                                  const Icon(
                                                    Icons.access_time,
                                                  ),
                                                  const SizedBox(width: 15),
                                                  Text(
                                                    '${_selectedTime.hour}:${_selectedTime.minute}',
                                                    style: TextStyle(
                                                        fontSize: width * 0.045,
                                                        color: brightnessprovider
                                                                    .brightness ==
                                                                AppBrightness
                                                                    .dark
                                                            ? AppTheme
                                                                .colorWhite
                                                            : AppTheme
                                                                .colorPrimary,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                errorStyle: const TextStyle(
                                                    color: Colors.black),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
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
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: AppTheme
                                                          .colorPrimary),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                errorStyle: const TextStyle(
                                                    color: Colors.black),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
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
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: AppTheme
                                                          .colorPrimary),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.05),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Checked",
                                                style: TextStyle(
                                                    fontSize: width * 0.04,
                                                    color:
                                                        AppTheme.colorPrimary,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              FlutterSwitch(
                                                  height: height * 0.032,
                                                  width: width * 0.13,
                                                  toggleSize: width * 0.06,
                                                  activeColor:
                                                      AppTheme.colorPrimary,
                                                  value: status,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      status = val;
                                                    });
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.file_present_outlined,
                                  size: width * 0.065,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: InkWell(
                                    onTap: () {
                                      selectImage(context);
                                    },
                                    child: Container(
                                      height: height * 0.05,
                                      width: width * 0.2,
                                      decoration: BoxDecoration(
                                          color: AppTheme.colorPrimary,
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          AppLocalizations.of(context)!.cancel,
                                          style: TextStyle(
                                              fontSize: width * 0.03,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      postschedule(context);
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
                                          AppLocalizations.of(context)!.save,
                                          style: TextStyle(
                                              fontSize: width * 0.03,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.1,
                            )
                          ]),
                    ))
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> showWalletDialog(
    BuildContext context,
    var height,
    var width,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            elevation: 10,
            shadowColor: AppTheme.colorPrimary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              '${AppLocalizations.of(context)!.select} ${AppLocalizations.of(context)!.wallet}:',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppTheme.colorPrimary),
            ),
            content: SizedBox(
              height: height * 0.3,
              width: width,
              child: FutureBuilder<UserWalletModel>(
                future: TransactionController.to.fetchAccounts(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox(
                      height: height,
                      child: ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          wal.Data account = snapshot.data!.data![index];
                          return InkWell(
                            onTap: () {
                              walletname = account.name!;
                              walletID = account.walletId;
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: SizedBox(
                                height: height * 0.1,
                                child: accountCard(account, index, context)),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ));
      },
    );
  }

  Card accountCard(wal.Data account, int index, context) {
    return Card(
      //color: bgcolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      shadowColor: AppTheme.colorPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              account.name!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                  // "${DashBoardController.to.curency}${TransactionController.to.convertToKMBa(account.amount!)}", // //By Ammar
                  "${DashBoardController.to.curency}${account.amount!}",

                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
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
      ),
    );
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
