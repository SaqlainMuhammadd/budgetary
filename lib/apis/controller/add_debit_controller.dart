import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snab_budget/apis/ApiStore.dart';
import 'package:snab_budget/apis/model/get_categories_model.dart';
import 'package:snab_budget/static_data.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart' as deo;
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/utils/apptheme.dart';

import '../model/add_debit_model.dart';

class AddDebitController extends GetxController {
  static AddDebitController get to => Get.find();
  TextEditingController balanceController = TextEditingController();
  TextEditingController currentDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  DateTime? currentdate = DateTime.now();
  DateTime? duedate = DateTime.now();
  TextEditingController person = TextEditingController();
  TextEditingController noteController = TextEditingController();
  GetCategoriesModel? model;
  DebitCreditModel? debitcreditmodel;
  String? catid;
  bool adloading = false;
  bool isLoading = false;
  Dio dio = Dio();
  String type = "income";

  XFile? pickImage;
  String pathFile = "";
  File? compressedFile;
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

  final picker = ImagePicker();
  Future<File> compressImage(XFile img) async {
    pathFile = img.path;

    final File imageFile = File(img.path);
    // Get the original image bytes
    List<int> imageBytes = await imageFile.readAsBytes();

    // Check if the image is already smaller than 300KB
    if (imageBytes.length <= 300 * 1024) {
      return imageFile;
    } else if (imageBytes.length >= 300 * 1024 &&
        imageBytes.length <= 600 * 1024) {
      Uint8List uint8List = Uint8List.fromList(imageBytes);
      // Compress the image to 75% quality
      List<int> compressedBytes = await FlutterImageCompress.compressWithList(
        uint8List,
        quality: 25,
      );

      // Convert the compressed bytes to a Uint8List
      Uint8List compressedData = Uint8List.fromList(compressedBytes);

      // Create a file from the compressed data
      File compressedFile = await _createFile(compressedData);

      return compressedFile;
    } else if (imageBytes.length >= 600 * 1024 &&
        imageBytes.length <= 999 * 1024) {
      Uint8List uint8List = Uint8List.fromList(imageBytes);
      // Compress the image to 75% quality
      List<int> compressedBytes = await FlutterImageCompress.compressWithList(
        uint8List,
        quality: 10,
      );

      // Convert the compressed bytes to a Uint8List
      Uint8List compressedData = Uint8List.fromList(compressedBytes);

      // Create a file from the compressed data
      File compressedFile = await _createFile(compressedData);

      return compressedFile;
    } else {
      Uint8List uint8List = Uint8List.fromList(imageBytes);
      // Compress the image to 75% quality
      List<int> compressedBytes = await FlutterImageCompress.compressWithList(
        uint8List,
        quality: 5,
      );

      // Convert the compressed bytes to a Uint8List
      Uint8List compressedData = Uint8List.fromList(compressedBytes);

      // Create a file from the compressed data
      File compressedFile = await _createFile(compressedData);

      return compressedFile;
    }
  }

  Future<void> selectImage(BuildContext context) async {
    final PermissionStatus status = await Permission.camera.request();
    final PermissionStatus status1 = await Permission.storage.request();
    if (status.isGranted && status1.isGranted) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.selectimage,
            ),
            content: Text(AppLocalizations.of(context)!
                .doyouwanttoselectanimagefromgallery),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.gallery,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.colorPrimary)),
                onPressed: () async {
                  //Navigator.of(context).pop();
                  //getImage(ImgSource.Gallery);
                  pickImage =
                      await picker.pickImage(source: ImageSource.gallery);

                  // Handle the picked image
                  if (pickImage != null) {
                    compressedFile = await compressImage(pickImage as XFile);
                    //    _uploadPicture(compressedFile);
                    // Do something with the picked image
                    // For example, you can display it in an Image widget
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
                  pickImage =
                      await picker.pickImage(source: ImageSource.camera);
                  // Handle the picked image
                  if (pickImage != null) {
                    compressedFile = File(pickImage!.path);
                    pathFile = pickImage!.path;

                    //_uploadPicture(imageFile);
                    // Do something with the picked image
                    // For example, you can display it in an Image widget
                  }
                },
              ),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
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
            title: Text(AppLocalizations.of(context)!.permissiondenied),
            content:
                Text(AppLocalizations.of(context)!.pleasegrantpermissionphoto),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.ok),
                onPressed: () async {
                  await Permission.photos.request();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future getCatagoriesdata(type) async {
    var res = await httpClient().get("${StaticValues.getCategories}$type");
    // final a = jsonDecode(res.data as Map<String, dynamic>);
    // print("model = ${res.data}");
    model = GetCategoriesModel.fromJson(res.data);
    update();
    //  print("tocken id ${StaticValues.token}");
    print("model he meda = $model");
    catid = model!.data![0].categoryId;
    update();
  }

  // Future addDebit(DebitCreditModel model) async {
  //   try {

  Future addDebit(String person, String note, num amount, String datetime,
      String backdate, int type, bool iscash, String catId) async {
    String result;
    isLoading = true;
    update();
    // deo.FormData data = deo.FormData.fromMap({
    //   "Person": person,
    //   "Amount": amount,
    //   "Note": note,
    //   "Date": datetime,
    //   "PayBackDate": backdate,
    //   "Type": type,
    //   "IsCash": iscash,
    //   "File": await deo.MultipartFile.fromFile(
    //     image.path,
    //     filename: basename(image.path),
    //   ),
    //   "CategoryId": catId,
    // });
    // print("...............FormData............. = ${data.fields}");
    print("...............url............. = ${StaticValues.addTransaction}");
    try {
      deo.FormData data = pathFile == ""
          ? deo.FormData.fromMap({
              "Person": person,
              "Amount": amount,
              "Note": note,
              "Date": datetime,
              "PayBackDate": backdate,
              "Type": type,
              "IsCash": iscash,
              "CategoryId": catId,
            })
          : deo.FormData.fromMap({
              "Person": person,
              "Amount": amount,
              "Note": note,
              "Date": datetime,
              "PayBackDate": backdate,
              "Type": type,
              "IsCash": iscash,
              "File": await deo.MultipartFile.fromFile(
                pickImage!.path,
                filename: basename(pickImage!.path),
              ),
              "CategoryId": catId,
            });
      print("...............FormData............. = ${data.fields}");
      print("...............url............. = ${StaticValues.adddebitcredit}");
      var response = await httpFormDataClient()
          .post(StaticValues.adddebitcredit, data: data);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        print("Response status Cose ${response.statusCode}");
        if (response.data != null) {
          print(".................${response.data}........");
        }
      }
      pathFile = "";
      isLoading = false;

      clearfield();
      update();
      return response.data;
    } catch (e) {
      print("Exception = $e");
    }
  }

  clearfield() {
    balanceController.clear();
    noteController.clear();
    person.clear();
    dueDateController.clear();
    currentDateController.clear();
  }

  //// updateddebit credit data
  ///
  Future editDebitCredit(
    String person,
    String note,
    num amount,
    String datetime,
    String backdate,
    String id,
  ) async {
    isLoading = true;
    update();

    // print("...............FormData............. = ${data.fields}");
    // print("...............url............. = ${StaticValues.addTransaction}");
    try {
      deo.FormData data = pathFile == ""
          ? deo.FormData.fromMap({
              "person": person,
              "amount": amount,
              "note": note,
              "date": datetime,
              "payBackDate": backdate,
            })
          : deo.FormData.fromMap({
              "person": person,
              "amount": amount,
              "note": note,
              "date": datetime,
              "payBackDate": backdate,
              "file":
                  // _image == null
                  //     ? null
                  //     :
                  await deo.MultipartFile.fromFile(
                pickImage!.path,
                filename: basename(pickImage!.path),
              ),
            });
      ;

      print("...............FormData............. = ${data.fields}");
      print(
          "...............url............. = ${StaticValues.updatedebitcredit}/$id");
      var response = await httpFormDataClient()
          .post("${StaticValues.updatedebitcredit}/$id", data: data);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        print("Response status Cose ${response.statusCode}");
        if (response.data != null) {
          print(".................${response.data}........");
        }
      }

      pathFile = "";

      clearfield();
      update();
      return response.data;
    } catch (e) {
      print("Exception = $e");
    }
  }

//  paydebitcredit
  Future paydebitcredit(Map<String, dynamic> data, context) async {
    isLoading = true;
    update();
    var res = await httpClient().post(StaticValues.paydebitcredit, data: data);

    isLoading = false;
    update();
    Navigator.pop(context);
  }

//  delete debit credit
  Future deleteDebitCredit(String? debitcreditID) async {
    print("idsjhds $debitcreditID");
    try {
      var response = await httpClient()
          .delete('${StaticValues.deletedebitcredit}/$debitcreditID');

      print("Response status Code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        if (response.data != null) {
          print("Response data: ${response.data}");
        }
      } else {
        print("Bad response: ${response.statusCode}");
        print("Error message: ${response.data}");
      }

      return response.data;
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> selectDate(BuildContext context,
      TextEditingController controller, DateTime initialDate) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      controller.text = DateFormat.yMMMd().format(selectedDate);
      if (controller == currentDateController) {
        currentdate = selectedDate;
      } else if (controller == dueDateController) {
        duedate = selectedDate;
      }
      update();
      print("date $currentdate");
      print("due date $duedate");
      // print("date1 $currentDateController");
      // print("due date1 $dueDateController");
    }
  }

  //// get debit /credit list
  ///

  Stream<DebitCreditModel> getdebitcredit() async* {
    while (true) {
      var result = await httpClient().get(StaticValues.getdebitcredit);
      debitcreditmodel = DebitCreditModel.fromJson(result.data);
      yield debitcreditmodel!;
      await Future.delayed(
          const Duration(seconds: 1)); // Adjust the delay as needed.
    }
  }
}
