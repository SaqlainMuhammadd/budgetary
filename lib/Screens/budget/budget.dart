import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/Screens/budget/add_budget.dart';
import 'package:snab_budget/Screens/budget/budgetModalClass.dart';
import 'package:snab_budget/Screens/budget/budget_transaction.dart';
import 'package:snab_budget/apis/ApiStore.dart';
import 'package:snab_budget/models/income_catagery._model.dart';
import 'package:snab_budget/static_data.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import 'package:snab_budget/utils/spinkit.dart';
import 'package:uuid/uuid.dart';

class BudgetScreen extends StatefulWidget {
  static const routeName = "budget-screen";

  const BudgetScreen({super.key});

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedValue = '1 weekly';
  // int selectedWeeks = 1;
  // int selectedMonths = 1;
  // int selectedYears = 1;
  // int selectedOther = 1;

  // void incrementWeeks() {
  //   setState(() {
  //     selectedWeeks++;
  //   });
  // }

  // void decrementWeeks() {
  //   setState(() {
  //     if (selectedWeeks > 1) {
  //       selectedWeeks--;
  //     }
  //   });
  // }

  // void incrementMonths() {
  //   setState(() {
  //     selectedMonths++;
  //   });
  // }

  // void decrementMonths() {
  //   setState(() {
  //     if (selectedMonths > 1) {
  //       selectedMonths--;
  //     }
  //   });
  // }

  // void incrementYears() {
  //   setState(() {
  //     selectedYears++;
  //   });
  // }

  // void decrementYears() {
  //   setState(() {
  //     if (selectedYears > 1) {
  //       selectedYears--;
  //     }
  //   });
  // }

  // void incrementOther() {
  //   setState(() {
  //     selectedOther++;
  //   });
  // }

  // void decrementOther() {
  //   setState(() {
  //     if (selectedOther > 1) {
  //       selectedOther--;
  //     }
  //   });
  // }

  List<BudgetData> displayMonthStatusItems = [];
  List<BudgetData> displayweekStatusItems = [];
  List<BudgetData> displayyearlytatusItems = [];
  List<BudgetData> displayothertatusItems = [];
  void getlists(snapshot) {
    displayMonthStatusItems = snapshot.data.where((item) {
      var date = updateitemdurations(item.duration!);
      DateFormat inputFormat = DateFormat('d/M/y');
      DateTime dateTime = inputFormat.parse(date);
      return item.duration == '1 Month';

      //  &&
      //     dateTime.isAfter(
      //         DateTime.now().subtract(Duration(days: selectedMonths * 30))
      //         );
    }).toList();
    print(
        " displayMonthStatusItemsdisplayMonthStatusItems ${displayMonthStatusItems.length}");
    /////////////////////////
    displayweekStatusItems = snapshot.data.where((item) {
      var date = updateitemdurations(item.duration!);
      DateFormat inputFormat = DateFormat('d/M/y');
      DateTime dateTime = inputFormat.parse(date);
      return item.duration == '1 Week';

      //  &&
      //     dateTime.isAfter(
      //         DateTime.now().subtract(Duration(days: selectedWeeks * 7))

      // );
    }).toList();
    print(" displayweekStatusItems ${displayweekStatusItems.length}");

    ///////////////////////////////////////
    displayyearlytatusItems = snapshot.data.where((item) {
      var date = updateitemdurations(item.duration!);
      DateFormat inputFormat = DateFormat('d/M/y');
      DateTime dateTime = inputFormat.parse(date);
      return item.duration == '1 Year';

      //  &&
      //     dateTime.isAfter(
      //         DateTime.now().subtract(Duration(days: selectedYears * 365))

      // );
    }).toList();
    print(" displayyearlytatusItems ${displayyearlytatusItems.length}");

    ////////////////////////////////
    displayothertatusItems = snapshot.data.where((item) {
      var date = updateitemdurations(item.duration!);
      DateFormat inputFormat = DateFormat('d/M/y');
      DateTime dateTime = inputFormat.parse(date);
      return item.duration == 'Other';
    }).toList();
    print(" displayothertatusItems ${displayothertatusItems.length}");
  }

  var height, width;
  void showDeleteConfirmationDialog(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<BrightnessProvider>(builder: (context, value, v) {
          return AlertDialog(
            title: Text(
              'Confirm Delete',
              style: TextStyle(
                color: value.brightness == AppBrightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this budget?',
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
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(
                          255, 17, 41, 73)), // Set the custom color here
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isLoading = true;
                  });
                  // Call the deleteBudget function when Delete is pressed
                  deletebudget(id);
                  // Close the dialog
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
  }

  Map<String, String> categories = {};
  String? currency = "";
  int? clicktile;

  int remaingAmount = 0;
  final storage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<SubCatagoriesModel> dummysubcatagorylist = [];
  List<SubCatagoriesModel> subcatagorylistview = [];
  String? getimage;
  CatagoryModel? catagorymodel;
  BudgetResponse? budgetModel;
  String? selectcatagorytital;
  String? selectcatagoryurl;
  String? selectedcat;
  bool opencatagoryclick = false;
  final TextEditingController subcatagorycontroller = TextEditingController();
  bool isLoading = false;
  String? maingetimage;
  final TextEditingController controller = TextEditingController();

  int currentMonth = DateTime.now().month;
  int currentYear = DateTime.now().year;
  // final String userId = FirebaseAuth.instance.currentUser!.uid;

  Stream<List<BudgetData>> getbudgets() async* {
    while (true) {
      var result = await httpClient().get(StaticValues.getBudgets);
      budgetModel = BudgetResponse.fromJson(result.data);
      yield budgetModel!.data!;
      await Future.delayed(
          const Duration(seconds: 1)); // Adjust the delay as needed.
    }
  }

  DateTime currentDate = DateTime.now();
  DateTime? newDurationDate;
  String? formattedDate;
  void updateDurationDate(String selectedOption) {
    switch (selectedOption) {
      case '1 Week':
        newDurationDate = currentDate.add(const Duration(days: 7));
        break;
      case '1 Month':
        newDurationDate = currentDate.add(const Duration(days: 30));
        break;
      case '1 Year':
        newDurationDate = currentDate.add(const Duration(days: 365));
        break;
      default:
        // Handle other cases if needed
        break;
    }
    DateTime originalDate = DateTime.parse(newDurationDate.toString());
    formattedDate = DateFormat('d/M/yyyy').format(originalDate);
  }

  String updateitemdurations(String selectedOption) {
    String d;
    switch (selectedOption) {
      case '1 Week':
        newDurationDate = currentDate.add(const Duration(days: 7));
        break;
      case '1 Month':
        newDurationDate = currentDate.add(const Duration(days: 30));
        break;
      case '1 Year':
        newDurationDate = currentDate.add(const Duration(days: 365));
        break;
      default:
        // Handle other cases if needed
        break;
    }
    DateTime originalDate = DateTime.parse(newDurationDate.toString());
    d = DateFormat('d/M/yyyy').format(originalDate);
    // print("formattedDate $formattedDate");
    return d;
  }

  double sliderCurrentValue = 0.5;
  @override
  void initState() {
    getbudgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    categories = {
      AppLocalizations.of(context)!.travel: 'assets/images/travel.png',
      AppLocalizations.of(context)!.shopping: 'assets/images/shopping.png',
      AppLocalizations.of(context)!.transportation:
          'assets/images/transport.png',
      AppLocalizations.of(context)!.home: 'assets/images/home.png',
      AppLocalizations.of(context)!.healthsport: 'assets/images/health.png',
      AppLocalizations.of(context)!.family: 'assets/images/family.png',
      AppLocalizations.of(context)!.fooddrink: 'assets/images/food.png',
    };

    int currentIndex = 1;
    List<String> values = ['1 Week', '1 Month', '1 Year', 'Other'];

    return SafeArea(
        child: Scaffold(
            body: Center(
      child: SizedBox(
        child: Column(
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
                  Expanded(
                    flex: 0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddBudget(),
                              ));
                          // showAddDialog(context);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SizedBox(
                height: height,
                width: width,
                child: StreamBuilder<List<BudgetData>>(
                    stream: getbudgets(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return isLoading == false
                            ? Center(
                                child: Center(
                                child: SizedBox(
                                  height: height * 0.1,
                                  width: width * 0.2,
                                  child: SpinKit.loadSpinkit,
                                ),
                              ))
                            : const SizedBox();
                      } else if (snapshot.data!.isEmpty) {
                        return Center(
                            child: Text(
                          AppLocalizations.of(context)!.notransaction,
                        ));
                      } else {
                        getlists(snapshot);
                        return Stack(
                          children: [
                            SizedBox(
                              height: height,
                              width: width,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    displayweekStatusItems.isEmpty
                                        ? const SizedBox()
                                        : Container(
                                            height: height * 0.05,
                                            width: width * 0.9,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                color: AppTheme.colorPrimary),
                                            child: const Row(
                                              children: [
                                                // Expanded(
                                                //   child: IconButton(
                                                //       onPressed: () {
                                                //         decrementWeeks();
                                                //       },
                                                //       icon: const Icon(
                                                //         Icons
                                                //             .arrow_back_ios_rounded,
                                                //         color: Colors.white,
                                                //       )),
                                                // ),
                                                Expanded(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.0),
                                                      child: Center(
                                                        child: Text(
                                                          'Weekly',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16),
                                                        ),
                                                      )),
                                                ),
                                                // Expanded(
                                                //   child: IconButton(
                                                //       onPressed: () {
                                                //         incrementWeeks();
                                                //       },
                                                //       icon: const Icon(
                                                //           Icons
                                                //               .arrow_forward_ios_rounded,
                                                //           color: Colors.white)),
                                                // ),
                                              ],
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    displayweekStatusItems.isEmpty
                                        ? const SizedBox()
                                        : ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount:
                                                displayweekStatusItems.length,
                                            itemBuilder: (context, index) {
                                              updateDurationDate(
                                                  displayweekStatusItems[index]
                                                      .duration!);
                                              return customListTile(
                                                transactions:
                                                    displayweekStatusItems[
                                                            index]
                                                        .transactions!,
                                                id: displayweekStatusItems[
                                                        index]
                                                    .budgetId!,
                                                duration:
                                                    displayweekStatusItems[
                                                            index]
                                                        .duration!,
                                                category:
                                                    displayweekStatusItems[
                                                            index]
                                                        .category!,
                                                image: displayweekStatusItems[
                                                        index]
                                                    .image!,
                                                date: formattedDate!,
                                                amount: displayweekStatusItems[
                                                        index]
                                                    .amount!,
                                                payable: displayweekStatusItems[
                                                        index]
                                                    .paidAmount!,
                                              );
                                            },
                                          ),
                                    displayMonthStatusItems.isEmpty
                                        ? const SizedBox()
                                        : SizedBox(
                                            height: height * 0.02,
                                          ),
                                    ///////////////////////////////////
                                    displayMonthStatusItems.isEmpty
                                        ? const SizedBox()
                                        : Container(
                                            height: height * 0.05,
                                            width: width * 0.9,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                color: AppTheme.colorPrimary),
                                            child: Row(
                                              children: [
                                                // Expanded(
                                                //   child: IconButton(
                                                //       onPressed: () {
                                                //         decrementMonths();
                                                //       },
                                                //       icon: const Icon(
                                                //         Icons
                                                //             .arrow_back_ios_rounded,
                                                //         color: Colors.white,
                                                //       )),
                                                // ),
                                                Expanded(
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15.0),
                                                      child: Center(
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .monthly,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                        ),
                                                      )),
                                                ),
                                                // Expanded(
                                                //   child: IconButton(
                                                //       onPressed: () {
                                                //         incrementMonths();
                                                //       },
                                                //       icon: const Icon(
                                                //           Icons
                                                //               .arrow_forward_ios_rounded,
                                                //           color: Colors.white)),
                                                // ),
                                              ],
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ListView.builder(
                                      primary: false,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: displayMonthStatusItems.length,
                                      itemBuilder: (context, index) {
                                        updateDurationDate(
                                            displayMonthStatusItems[index]
                                                .duration!);
                                        return customListTile(
                                          transactions:
                                              displayMonthStatusItems[index]
                                                  .transactions!,
                                          id: displayMonthStatusItems[index]
                                              .budgetId!,
                                          duration:
                                              displayMonthStatusItems[index]
                                                  .duration!,
                                          category:
                                              displayMonthStatusItems[index]
                                                  .category!,
                                          image: displayMonthStatusItems[index]
                                              .image!,
                                          date: formattedDate!,
                                          amount: displayMonthStatusItems[index]
                                              .amount!,
                                          payable:
                                              displayMonthStatusItems[index]
                                                  .paidAmount!,
                                        );
                                      },
                                    ),
                                    displayyearlytatusItems.isEmpty
                                        ? const SizedBox()
                                        : SizedBox(
                                            height: height * 0.02,
                                          ),
                                    // /////////////////////// yearly
                                    displayyearlytatusItems.isEmpty
                                        ? const SizedBox()
                                        : Container(
                                            height: height * 0.05,
                                            width: width * 0.9,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                color: AppTheme.colorPrimary),
                                            child: Row(
                                              children: [
                                                // Expanded(
                                                //   child: IconButton(
                                                //       onPressed: () {
                                                //         decrementYears();
                                                //       },
                                                //       icon: const Icon(
                                                //         Icons
                                                //             .arrow_back_ios_rounded,
                                                //         color: Colors.white,
                                                //       )),
                                                // ),
                                                Expanded(
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15.0),
                                                      child: Center(
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .yearly,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                        ),
                                                      )),
                                                ),
                                                // Expanded(
                                                //   child: IconButton(
                                                //       onPressed: () {
                                                //         incrementYears();
                                                //       },
                                                //       icon: const Icon(
                                                //           Icons
                                                //               .arrow_forward_ios_rounded,
                                                //           color: Colors.white)),
                                                // ),
                                              ],
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    displayyearlytatusItems.isEmpty
                                        ? const SizedBox()
                                        : ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                displayyearlytatusItems.length,
                                            itemBuilder: (context, index) {
                                              updateDurationDate(
                                                  displayyearlytatusItems[index]
                                                      .duration!);
                                              return customListTile(
                                                transactions:
                                                    displayyearlytatusItems[
                                                            index]
                                                        .transactions!,
                                                id: displayyearlytatusItems[
                                                        index]
                                                    .budgetId!,
                                                duration:
                                                    displayyearlytatusItems[
                                                            index]
                                                        .duration!,
                                                category:
                                                    displayyearlytatusItems[
                                                            index]
                                                        .category!,
                                                image: displayyearlytatusItems[
                                                        index]
                                                    .image!,
                                                date: formattedDate!,
                                                amount: displayyearlytatusItems[
                                                        index]
                                                    .amount!,
                                                payable:
                                                    displayyearlytatusItems[
                                                            index]
                                                        .paidAmount!,
                                              );
                                            },
                                          ),
                                    displayothertatusItems.isEmpty
                                        ? const SizedBox()
                                        : SizedBox(
                                            height: height * 0.02,
                                          ),
                                    /////////////////// otherrrr
                                    displayothertatusItems.isEmpty
                                        ? const SizedBox()
                                        : Container(
                                            height: height * 0.05,
                                            width: width * 0.9,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                color: AppTheme.colorPrimary),
                                            child: Row(
                                              children: [
                                                // Expanded(
                                                //   child: IconButton(
                                                //       onPressed: () {
                                                //         decrementOther();
                                                //       },
                                                //       icon: const Icon(
                                                //         Icons
                                                //             .arrow_back_ios_rounded,
                                                //         color: Colors.white,
                                                //       )),
                                                // ),
                                                Expanded(
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15.0),
                                                      child: Center(
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .other,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                        ),
                                                      )),
                                                ),
                                                // Expanded(
                                                //   child: IconButton(
                                                //       onPressed: () {
                                                //         incrementOther();
                                                //       },
                                                //       icon: const Icon(
                                                //           Icons
                                                //               .arrow_forward_ios_rounded,
                                                //           color: Colors.white)),
                                                // ),
                                              ],
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    displayothertatusItems.isEmpty
                                        ? const SizedBox()
                                        : ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                displayothertatusItems.length,
                                            itemBuilder: (context, index) {
                                              updateDurationDate(
                                                  displayothertatusItems[index]
                                                      .duration!);
                                              return customListTile(
                                                transactions:
                                                    displayothertatusItems[
                                                            index]
                                                        .transactions!,
                                                id: displayothertatusItems[
                                                        index]
                                                    .budgetId!,
                                                duration:
                                                    displayothertatusItems[
                                                            index]
                                                        .duration!,
                                                category:
                                                    displayothertatusItems[
                                                            index]
                                                        .category!,
                                                image: displayothertatusItems[
                                                        index]
                                                    .image!,
                                                date: formattedDate!,
                                                amount: displayothertatusItems[
                                                        index]
                                                    .amount!,
                                                payable: displayothertatusItems[
                                                        index]
                                                    .paidAmount!,
                                              );
                                            },
                                          )
                                  ],
                                ),
                              ),
                            ),
                            isLoading == true
                                ? Expanded(
                                    child: Container(
                                      height: height,
                                      width: width,
                                      color: AppTheme.colorPrimary
                                          .withOpacity(0.2),
                                      child: Center(
                                        child: SpinKit.loadSpinkit,
                                      ),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    )));
  }

  Widget customListTile({
    required String category,
    required List<BudgetTransactions> transactions,
    required String image,
    required String duration,
    required String date,
    required double payable,
    required String id,
    required double amount,
  }) {
    var provider = Provider.of<BrightnessProvider>(context);
    var persentage = (((payable / amount) * 100)).toInt();
    var residual = amount - payable;

    sliderCurrentValue = persentage / 100;

    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
      child: Card(
        elevation: 2,
        shadowColor: AppTheme.colorPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            if (payable < amount) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => bugetTransaction(
                      data: BudgetData(
                    amount: amount,
                    budgetId: id,
                    category: category,
                    image: image,
                    paidAmount: payable,
                    transactions: transactions,
                    duration: duration,

                    // date: date,
                    // budgetAmount: amount.toInt(),
                    // payableamount: payable.toInt(),
                    // duration: duration,
                    // ctagoryName: category,
                    // ctagoryImage: image,
                    // budgetID: id,
                    // from: '',
                    // notes: '',
                  )),
                ),
              );
            } else {
              showtoast("Budget Limit Full");
            }
          },
          child: Container(
            height: height * 0.12,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: height,
                  width: width * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(category, style: TextStyle(fontSize: width * 0.03)),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      CircleAvatar(child: Image.asset(image)),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(dateString(),
                                  style: TextStyle(
                                    color: provider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                    fontSize: 12,
                                  )),
                              Text('$persentage %',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                              Text(date,
                                  style: TextStyle(
                                    color: provider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SliderTheme(
                            data: const SliderThemeData(
                                trackHeight: 3,
                                overlayShape:
                                    RoundSliderOverlayShape(overlayRadius: 0),
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 0)),
                            child: Slider(
                              inactiveColor: Colors.grey,
                              activeColor: AppTheme.colorPrimary,
                              value: sliderCurrentValue,
                              onChanged: (double value) {},
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text('0',
                                  style: TextStyle(
                                    color: provider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                    fontSize: 12,
                                  )),
                              Text(payable.toString(),
                                  style: TextStyle(
                                    color: provider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                    fontSize: 12,
                                  )),
                              Text(amount.toString(),
                                  style: TextStyle(
                                    color: provider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                  '${AppLocalizations.of(context)!.residualamount}: $residual',
                                  style: TextStyle(
                                    color: provider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: height,
                  width: width * 0.1,
                  child: IconButton(
                      onPressed: () {
                        showDeleteConfirmationDialog(context, id);
                      },
                      icon: const Icon(Icons.delete_forever)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String dateString() {
    return '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  }

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
  //         .doc("userId")
  //         .collection("usercatagories")
  //         .doc(catagorymodel!.id)
  //         .update({'subcatagories': dynamicList});
  //     showtoast("added sucessfully");
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Navigator.pop(context);
  //   }
  // }

  Widget showspinkit(context) {
    var widget = Container(
      height: height,
      width: width,
      color: Colors.black.withOpacity(0.1),
      child: Center(
        child: SpinKitCircle(
          color: AppTheme.colorPrimary,
          size: 50.0,
        ),
      ),
    );
    return widget;
  }

  void showtoast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: AppTheme.colorPrimary,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: width * 0.03,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG);
  }

  void deletebudget(String id) async {
    // firebaseFirestore
    //     .collection("Budgets")
    //     .doc("userId")
    //     .collection("userbudget")
    //     .doc(id)
    //     .delete();..
    var result = await httpClient().delete('${StaticValues.deleteBudgets}/$id');
    setState(() {
      isLoading = false;
    });
    showtoast("delete succesfully");
  }

  void deletecatagory(String id) async {
    await firebaseFirestore
        .collection("catagories")
        .doc("userId")
        .collection("usercatagories")
        .doc(id)
        .delete();
    showtoast("delete sucessfully");
  }

  void postCatgoriestoDB() async {
    setState(() {
      isLoading = true;
    });
    if (controller.text.isNotEmpty && maingetimage != null) {
      String id = const Uuid().v4();

      ////// mainget image
      CatagoryModel model = CatagoryModel(
        id: id,
        name: controller.text,
        image: maingetimage,
        subcatagories: null,
      );
      await firebaseFirestore
          .collection("catagories")
          .doc("userId")
          .collection("usercatagories")
          .doc(id)
          .set(model.toMap());
      showtoast("Added succesfully");
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    } else {
      showtoast("give all fields");
      setState(() {
        isLoading = false;
      });
    }
  }
}

List<String> iconList = [
  "assets/snabbicons/water  bill.png",
  "assets/snabbicons/shopping.png",
  "assets/snabbicons/tech.png",
  "assets/snabbicons/travel.png",
  "assets/snabbicons/rent.png",
  "assets/snabbicons/salary.png",
  "assets/snabbicons/rent.png",
  "assets/snabbicons/pet.png",
  "assets/snabbicons/personal savings.png",
  "assets/snabbicons/pension.png",
  "assets/snabbicons/others.png",
  "assets/snabbicons/clothing.png",
  "assets/snabbicons/children.png",
  "assets/snabbicons/others.png",
  "assets/snabbicons/entertainment.png",
  "assets/snabbicons/family.png",
  "assets/snabbicons/food drink.png",
  "assets/snabbicons/food drink(eating out).png",
  "assets/snabbicons/others.png",
  "assets/snabbicons/accomodation.png",
  "assets/snabbicons/others.png",
];
