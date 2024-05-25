import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snab_budget/Screens/theme_screen.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/main.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import 'package:snab_budget/utils/currency_model.dart';
import 'package:snab_budget/utils/currency_model_bootom_sheet.dart';
import 'package:snab_budget/utils/pdf/pdfpreview.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column hide Row;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/utils/apptheme.dart';
import '../models/transaction.dart';
import 'package:vector_math/vector_math.dart' as math;

class SettingScreen extends StatefulWidget {
  static const routeName = "settings-screen";

  const SettingScreen({
    super.key,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // final String userId = FirebaseAuth.instance.currentUser!.uid;
  List<Transaction> transactions = [];
  bool expensestatus = false;
  bool incomestatus = false;
  bool derbitCreditstatus = false;
  bool accountstatus = false;
  String? name;
  String? email;
  String? lang;
  getuserdata() async {
    // final userId = FirebaseAuth.instance.currentUser!.uid;
    // var collection = FirebaseFirestore.instance.collection('UsersData');
    // var docSnapshot = await collection.doc(userId).get();
    // if (docSnapshot.exists) {
    //   print("ok");
    //   Map<String, dynamic>? data = docSnapshot.data();
    //   setState(() {
    //     name = data?["First Name"];
    //     email = data?["Email"];
    //     //  print("$name  ----------- $email");
    //   });
    // }
  }

  @override
  void initState() {
    getuserdata();
    Get.put(TransactionController());
    TransactionController.to.fetchTransaction();
    super.initState();

    //getCurrency();
  }

  void changeLocale(value, context, height, width) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              height: height * 0.3,
              width: width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context)!.changelanguage,
                    style: TextStyle(
                        fontSize: width * 0.04,
                        color: AppTheme.colorPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppLocalizations.of(context)!.changelanguage,
                    style: TextStyle(
                        fontSize: width * 0.03,
                        color: AppTheme.colorPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.2,
                    width: width * 0.2,
                    child: Lottie.asset('assets/lottie_files/success.json'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: const TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.confirm,
                  style: TextStyle(color: AppTheme.colorPrimary),
                ),
                onPressed: () {
                  MyApp.setLocale(context, Locale(value));
                  lang = value;
                  if (value!.toString().toLowerCase() == "it") {
                    prefs.setString("local", "ita");
                  } else if (value!.toString().toLowerCase() == "fr") {
                    prefs.setString("local", "fra");
                  } else if (value!.toString().toLowerCase() == "da") {
                    prefs.setString("local", "dnk");
                  } else if (value!.toString().toLowerCase() == "de") {
                    prefs.setString("local", "deu");
                  } else if (value!.toString().toLowerCase() == "es") {
                    prefs.setString("local", "esp");
                  } else if (value!.toString().toLowerCase() == "pl") {
                    prefs.setString("local", "pol");
                  } else if (value!.toString().toLowerCase() == "sv") {
                    prefs.setString("local", "swe");
                  } else {
                    mainlocale = const Locale("en");
                    prefs.setString("local", "en");
                  }

                  Navigator.pop(context);
                  Future.delayed(const Duration(milliseconds: 600), () {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 600),
    );
  }

  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
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
            AppLocalizations.of(context)!.deleteall,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppTheme.colorPrimary),
          ),
          content: Text(AppLocalizations.of(context)!.areyousuredeletedata),
          actions: <Widget>[
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: const TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.delete,
                style: TextStyle(color: AppTheme.colorPrimary),
              ),
              onPressed: () async {
                // await FirebaseFirestore.instance
                //     .collection("UserTransactions")
                //     .doc(userId)
                //     .collection("transactions")
                //     .get()
                //     .then((snapshot) {
                //   for (DocumentSnapshot ds in snapshot.docs) {
                //     ds.reference.delete();
                //   }
                // });
                // await FirebaseFirestore.instance
                //     .collection("UserTransactions")
                //     .doc(userId)
                //     .collection("data")
                //     .doc("userData")
                //     .update({
                //   "balance": 0,
                //   "currency": "\$",
                // });
                // await FirebaseFirestore.instance
                //     .collection("UserTransactions")
                //     .doc(userId)
                //     .collection("SchedualTrsanactions")
                //     .get()
                //     .then((snapshot) {
                //   for (DocumentSnapshot ds in snapshot.docs) {
                //     ds.reference.delete();
                //   }
                // });
                // await FirebaseFirestore.instance
                //     .collection("UserTransactions")
                //     .doc(userId)
                //     .collection("Accounts")
                //     .get()
                //     .then((snapshot) {
                //   for (DocumentSnapshot ds in snapshot.docs) {
                //     if (ds.id == "snabbWallet") {
                //       FirebaseFirestore.instance
                //           .collection("UserTransactions")
                //           .doc(userId)
                //           .collection("Accounts")
                //           .doc("snabbWallet")
                //           .update({'amount': 0});
                //     } else {
                //       ds.reference.delete();
                //     }
                // }
                // }
                //             );
                //             Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                          '${AppLocalizations.of(context)!.includereport} :',
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
                              '${AppLocalizations.of(context)!.debit}/${AppLocalizations.of(context)!.credit}',
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
                                Navigator.pop(context);
                                print(
                                    "============${TransactionController.to.transactions.length}");
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

  Future<void> createExcel(List<Transaction> transactions) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    // Set header "Snabb Budget"
    sheet.getRangeByName('A1').setText(' Budgetary!');

    // Set column headers
    sheet.getRangeByIndex(2, 1).setText('Serial Number');
    sheet.getRangeByIndex(2, 2).setText('Date');
    sheet.getRangeByIndex(2, 3).setText('Transaction Category');
    sheet.getRangeByIndex(2, 4).setText('Amount');
    sheet.getRangeByIndex(2, 5).setText('Note');

    // Add transaction data
    for (int i = 0; i < transactions.length; i++) {
      final Transaction transaction = transactions[i];
      final int row = i + 3; // Starting from row 3

      // Serial Number
      sheet.getRangeByIndex(row, 1).setNumber(i + 1);

      // Date
      sheet.getRangeByIndex(row, 2).setDateTime(transaction.date);

      // Transaction Category
      sheet
          .getRangeByIndex(row, 3)
          .setText(transaction.category.toString().split('.').last);

      // Amount
      sheet.getRangeByIndex(row, 4).setNumber(transaction.amount.toDouble());

      // Note (if exists)
      if (transaction.name.isNotEmpty) {
        sheet.getRangeByIndex(row, 5).setText(transaction.name);
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }

  Future<void> generateExcel() async {
    // Create a new Excel document
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    // Set column widths
    sheet.getRangeByName('A1:D1').columnWidth = 15;

    // Apply formatting to the header cells
    final Style headerStyle = workbook.styles.add('headerStyle');
    headerStyle.fontColorRgb = Colors.white;
    headerStyle.backColorRgb = Colors.black;
    headerStyle.bold = true;
    headerStyle.hAlign = HAlignType.center;
    headerStyle.vAlign = VAlignType.center;
    sheet.getRangeByName('A1:D1').cellStyle = headerStyle;

    // Set header row values
    sheet.getRangeByName('A1').setText('S. No');
    sheet.getRangeByName('B1').setText('Date');
    sheet.getRangeByName('C1').setText('Type');
    sheet.getRangeByName('D1').setText('Details');
    sheet.getRangeByName('E1').setText('Amount');

    // Set account rows
    final List<List<dynamic>> accountData = [
      [1, '300,000'],
      [2, '200,000'],
      [3, '60,000'],
      [4, '100,000'],
    ];
    for (int i = 0; i < accountData.length; i++) {
      final List<dynamic> row = accountData[i];
      sheet.getRangeByIndex(i + 2, 1).setText(row[0].toString());
      sheet.getRangeByIndex(i + 2, 5).setText(row[1].toString());
    }

    // Set total income and total expense rows
    sheet.getRangeByIndex(6, 1).setText('Total Income');
    sheet.getRangeByIndex(6, 5).setText('120,000');
    sheet.getRangeByIndex(7, 1).setText('Total Expense');
    sheet.getRangeByIndex(7, 5).setText('116,000');

    // Set transaction rows
    final List<List<dynamic>> transactionData = [
      [1, 'Income', 'Rent', '50,000'],
      [2, 'Income', 'Salary', '70,000'],
      [1, 'Expense', 'Utilities', '30,000'],
      [2, 'Expense', 'Phone Bill', '10,000'],
      [3, 'Expense', 'Water Bill', '1,000'],
      [4, 'Expense', 'Gas Bill', '20,000'],
      [5, 'Expense', 'Electricity Bill', '15,000'],
      [6, 'Expense', 'WiFi Bill', '15,000'],
      [7, 'Expense', 'Education', '5,000'],
      [8, 'Expense', 'Registration fee', '20,000'],
    ];
    for (int i = 0; i < transactionData.length; i++) {
      final List<dynamic> row = transactionData[i];
      sheet.getRangeByIndex(i + 9, 1).setText(row[0].toString());
      sheet.getRangeByIndex(i + 9, 2).setText(row[1].toString());
      sheet.getRangeByIndex(i + 9, 3).setText(row[2].toString());
      sheet.getRangeByIndex(i + 9, 5).setText(row[3].toString());
    }

    // Save the Excel document
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    // Save the Excel document to a temporary file
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final String filePath = '$tempPath/excel.xlsx';
    final File file = File(filePath);
    await file.writeAsBytes(bytes);
    print('Excel file generated at: $filePath');

    // Open the Excel file
    OpenFile.open(filePath);
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    lang = Localizations.localeOf(context).toString();
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        // drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Consumer<BrightnessProvider>(builder: (context, provider, bv) {
            return Column(
              children: [
                SafeArea(child: Consumer<BrightnessProvider>(
                    builder: (context, brightnessProvider, _) {
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                                  AppLocalizations.of(context)!.settings,
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 41, right: 30),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .basicsettings,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width * 0.045,
                                          color:
                                              brightnessProvider.brightness ==
                                                      AppBrightness.dark
                                                  ? AppTheme.colorWhite
                                                  : AppTheme.colorPrimary),
                                    ),
                                  )),
                              GetBuilder<TransactionController>(builder: (obj) {
                                return Card(
                                  elevation: 7,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    title: Text(
                                      AppLocalizations.of(context)!.language,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(AppLocalizations.of(context)!
                                        .languagename),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(15.0)),
                                        ),
                                        builder: (context) {
                                          return SizedBox(
                                            height: height * 0.68,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListView(children: [
                                                Container(
                                                  height: 40,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                      Icons.clear,
                                                      color:
                                                          AppTheme.colorPrimary,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .choseyourlanguage,
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: height,
                                                  width: width,
                                                  child: ListView.builder(
                                                    itemCount: CountryModell
                                                        .currencyList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              CountryModell
                                                                  .currencyList[
                                                                      index]
                                                                  .name!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.03)),
                                                          StatefulBuilder(
                                                              builder: (context,
                                                                  state) {
                                                            return Radio(
                                                              value: CountryModell
                                                                  .currencyList[
                                                                      index]
                                                                  .value!,
                                                              activeColor: AppTheme
                                                                  .colorPrimary,
                                                              groupValue: lang,
                                                              onChanged:
                                                                  (value) {
                                                                lang = null;
                                                                state(() {
                                                                  lang = value;
                                                                });
                                                                print(
                                                                    "valuee $lang");
                                                                changeLocale(
                                                                    value,
                                                                    context,
                                                                    height,
                                                                    width);
                                                              },
                                                            );
                                                          }),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                )

                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     const Text("Espanol",
                                                //         style: TextStyle(
                                                //             fontSize: 16)),
                                                //     Radio(
                                                //       value: "es",
                                                //       activeColor:
                                                //           AppTheme.colorPrimary,
                                                //       groupValue: obj.lang,
                                                //       onChanged: (value) {
                                                //         obj.changeLocale(
                                                //             value,
                                                //             context,
                                                //             height,
                                                //             width);
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     const Text("Polish",
                                                //         style: TextStyle(
                                                //             fontSize: 16)),
                                                //     Radio(
                                                //       value: "pl",
                                                //       activeColor:
                                                //           AppTheme.colorPrimary,
                                                //       groupValue: obj.lang,
                                                //       onChanged: (value) {
                                                //         obj.changeLocale(
                                                //             value,
                                                //             context,
                                                //             height,
                                                //             width);
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     const Text("Francias",
                                                //         style: TextStyle(
                                                //             fontSize: 16)),
                                                //     Radio(
                                                //       value: "fr",
                                                //       activeColor:
                                                //           AppTheme.colorPrimary,
                                                //       groupValue: obj.lang,
                                                //       onChanged: (value) {
                                                //         obj.changeLocale(
                                                //             value,
                                                //             context,
                                                //             height,
                                                //             width);
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     const Text("English",
                                                //         style: TextStyle(
                                                //             fontSize: 16)),
                                                //     Radio(
                                                //       activeColor:
                                                //           AppTheme.colorPrimary,
                                                //       value: "en",
                                                //       groupValue: obj.lang,
                                                //       onChanged: (value) {
                                                //         obj.changeLocale(
                                                //             value,
                                                //             context,
                                                //             height,
                                                //             width);
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     const Text("Italiano",
                                                //         style: TextStyle(
                                                //             fontSize: 16)),
                                                //     Radio(
                                                //       activeColor:
                                                //           AppTheme.colorPrimary,
                                                //       value: "it",
                                                //       groupValue: obj.lang,
                                                //       onChanged: (value) {
                                                //         obj.changeLocale(
                                                //             value,
                                                //             context,
                                                //             height,
                                                //             width);
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     const Text("Danish",
                                                //         style: TextStyle(
                                                //             fontSize: 16)),
                                                //     Radio(
                                                //       value: "da",
                                                //       activeColor:
                                                //           AppTheme.colorPrimary,
                                                //       groupValue: obj.lang,
                                                //       onChanged: (value) {
                                                //         obj.changeLocale(
                                                //             value,
                                                //             context,
                                                //             height,
                                                //             width);
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     const Text("Finnish",
                                                //         style: TextStyle(
                                                //             fontSize: 16)),
                                                //     Radio(
                                                //       value: "fi",
                                                //       activeColor:
                                                //           AppTheme.colorPrimary,
                                                //       groupValue: obj.lang,
                                                //       onChanged: (value) {
                                                //         obj.changeLocale(
                                                //             value,
                                                //             context,
                                                //             height,
                                                //             width);
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     const Text("Swedish",
                                                //         style: TextStyle(
                                                //             fontSize: 16)),
                                                //     Radio(
                                                //       value: "sv",
                                                //       activeColor:
                                                //           AppTheme.colorPrimary,
                                                //       groupValue: obj.lang,
                                                //       onChanged: (value) {
                                                //         obj.changeLocale(
                                                //             value,
                                                //             context,
                                                //             height,
                                                //             width);
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     const Text("German",
                                                //         style: TextStyle(
                                                //             fontSize: 16)),
                                                //     Radio(
                                                //       value: "de",
                                                //       activeColor:
                                                //           AppTheme.colorPrimary,
                                                //       groupValue: obj.lang,
                                                //       onChanged: (value) {
                                                //         obj.changeLocale(
                                                //             value,
                                                //             context,
                                                //             height,
                                                //             width);
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                              ]),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                              }),
                              GetBuilder<TransactionController>(builder: (obj) {
                                return Card(
                                  elevation: 7,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    title: Text(
                                      AppLocalizations.of(context)!.currency,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle:
                                        Text(DashBoardController.to.curency),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    onTap: () {
                                      CureencyBottomSheet
                                          .addCurrencyBottomSheet(
                                              context: context,
                                              height: height,
                                              width: width);
                                    },
                                  ),
                                );
                              }),
                              Card(
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)!.chosetheme,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle:
                                      Text(AppLocalizations.of(context)!.light),
                                  trailing: const Icon(
                                      Icons.arrow_forward_ios_rounded),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              backgroundColor:
                                                  brightnessProvider
                                                              .brightness ==
                                                          AppBrightness.dark
                                                      ? AppTheme.darkbackground
                                                      : Colors.white,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                              content:
                                                  const ThemeChangeScreen());
                                        });
                                  },
                                ),
                              ),
                              // Card(
                              //   elevation: 7,
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(12)),
                              //   child: ListTile(
                              //     title: Text(
                              //       AppLocalizations.of(context)!.eraseAll,
                              //       style: const TextStyle(
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     subtitle: Text(
                              //         AppLocalizations.of(context)!.eraseAllData),
                              //     trailing:
                              //         const Icon(Icons.arrow_forward_ios_rounded),
                              //     onTap: () {
                              //       showDeleteConfirmationDialog(context);
                              //     },
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 41, right: 30),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .databasesettings,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.045,
                                        color: brightnessProvider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                      ),
                                    ),
                                  )),
                              Card(
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)!.report,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(AppLocalizations.of(context)!
                                      .generatereport),
                                  trailing: const Icon(
                                      Icons.arrow_forward_ios_rounded),
                                  onTap: () {
                                    TransactionController.to
                                        .fetchDebtsCredits();
                                    TransactionController.to.fetchAccounts();
                                    TransactionController.to
                                        .fetchexpensetransaction();
                                    TransactionController.to
                                        .fetchincometransaction();

                                    showPDFDialog(context, height, width,
                                        brightnessProvider);
                                  },
                                ),
                              ),
                              // Card(
                              //   elevation: 7,
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(12)),
                              //   child: ListTile(
                              //     title: const Text(
                              //       "Export ",
                              //       style: TextStyle(fontWeight: FontWeight.bold),
                              //     ),
                              //     subtitle: const Text("xls"),
                              //     trailing:
                              //         const Icon(Icons.arrow_forward_ios_rounded),
                              //     onTap: () {
                              //       //generateExcel();
                              //       createExcel(transactions);
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 41, right: 30),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.help,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.045,
                                        color: brightnessProvider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                      ),
                                    ),
                                  )),
                              Card(
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)!.feedback,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(AppLocalizations.of(context)!
                                      .givefeedbacksupport),
                                  trailing: const Icon(
                                      Icons.arrow_forward_ios_rounded),
                                  onTap: () {},
                                ),
                              ),
                              Card(
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)!.help,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      AppLocalizations.of(context)!.askhelp),
                                  trailing: const Icon(
                                      Icons.arrow_forward_ios_rounded),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })),
              ],
            );
          }),
        ),
      ),
    );
  }
}
