import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/apis/ApiStore.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/models/search_summary.dart';
import 'package:snab_budget/static_data.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import 'package:snab_budget/apis/model/get_user_all_transaction.dart' as T;

import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/utils/transaction_card.dart';
import '../models/transaction.dart';

class CategoryWidget extends StatefulWidget {
  final List<Transaction> transactions;
  final List<String> months;
  const CategoryWidget(
      {super.key, required this.transactions, required this.months});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  String? startdate;
  String enddate = "";
  String date = "";
  DateTime now = DateTime.now();
  Future<void> _selectDate(BuildContext context, bool from) async {
    final DateTime? picked = await showDatePicker(
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
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (from) {
      if (picked != null && picked != selectedDateFrom) {
        setState(() {
          selectedDateFrom = picked;
          dateFromPicked = true;
          startdate = "${picked.day}-${picked.month}-${picked.year}";
        });
      }
    } else {
      if (picked != null && picked != selectedDateTo) {
        setState(() {
          selectedDateTo = picked;
          dateToPicked = true;
          enddate = "${picked.day}-${picked.month}-${picked.year}";
        });
      }
    }
    print("start  $startdate---------- end $enddate");
  }

  String selectedType = "All";
  bool dateFromPicked = false;
  bool dateToPicked = false;
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  List<String> types = [
    "All",
    'income',
    'expense',
  ];
  double totalAmount = 0.0;
  // final String userId = FirebaseAuth.instance.currentUser!.uid;

  List<Transaction> getFilteredTransactions() {
    List<Transaction> filteredList = widget.transactions;
    if (selectedType == 'income') {
      filteredList = filteredList
          .where((transaction) => transaction.type == TransactionType.income)
          .toList();
    } else if (selectedType == 'expense') {
      filteredList = filteredList
          .where((transaction) => transaction.type == TransactionType.expense)
          .toList();
    }

    filteredList = filteredList
        .where((transaction) => transaction.date.isAfter(selectedDateFrom))
        .toList();

    filteredList = filteredList
        .where((transaction) => transaction.date.isBefore(selectedDateTo))
        .toList();

    // Calculate the total amount
    // setState(() {
    totalAmount = filteredList.fold(0, (double total, transaction) {
      if (transaction.type == TransactionType.income) {
        return total + transaction.amount;
      } else {
        return total - transaction.amount;
      }
    });
    // });
    return filteredList;
  }

  Future<SearchSummary> getcategory(int type, String start, String end) async {
    var res = await httpClient().get(
        "${StaticValues.searchSummary}$type&StartDate=$start&EndDate=$end");
    print("-------search ${res.data}");
    return SearchSummary.fromMap(res.data);
  }

  double totalBalance = 0.0;
  calculateTotalBalance(List<Data>? a) {
    List<Data> filteredList = a!;

    for (var transaction in filteredList) {
      if (transaction.type == TransactionType.income) {
        totalBalance += transaction.amount!;
      } else {
        totalBalance -= transaction.amount!;
      }
    }
  }

  @override
  void initState() {
    enddate = "${now.day}-${now.month}-${now.year}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Consumer<BrightnessProvider>(
              builder: (context, brightnessProvider, _) {
            return Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.type,
                      style: TextStyle(
                          color: brightnessProvider.brightness ==
                                  AppBrightness.dark
                              ? AppTheme.colorWhite
                              : AppTheme.colorPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.035),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Container(
                    height: size.height * 0.07,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color:
                            brightnessProvider.brightness == AppBrightness.dark
                                ? AppTheme.colorWhite
                                : AppTheme.colorPrimary,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor:
                            brightnessProvider.brightness == AppBrightness.dark
                                ? AppTheme.colorPrimary
                                : Colors.white,
                        focusColor: AppTheme.colorPrimary,
                        value: selectedType,
                        style: TextStyle(
                            color: AppTheme.colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.035),
                        onChanged: (newValue) {
                          setState(() {
                            selectedType = newValue as String;
                          });
                        },
                        items:
                            types.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: brightnessProvider.brightness ==
                                          AppBrightness.dark
                                      ? AppTheme.colorWhite
                                      : AppTheme.colorPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.035),
                            ),
                          );
                        }).toList(),
                        hint: Text(AppLocalizations.of(context)!.selecttype),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: brightnessProvider.brightness ==
                                  AppBrightness.dark
                              ? AppTheme.colorWhite
                              : AppTheme.colorPrimary,
                        ),
                        elevation: 1,
                        isExpanded: true,
                        isDense: true,
                        selectedItemBuilder: (BuildContext context) {
                          return types.map<Widget>((String value) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: brightnessProvider.brightness ==
                                              AppBrightness.dark
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorPrimary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width / 3,
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!.from,
                                style: TextStyle(
                                    color: brightnessProvider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.035),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: size.width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: brightnessProvider.brightness ==
                                        AppBrightness.dark
                                    ? AppTheme.colorWhite
                                    : AppTheme.colorPrimary,
                              ),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  _selectDate(context, true);
                                },
                                child: Text(
                                  !dateFromPicked
                                      ? AppLocalizations.of(context)!.select
                                      : " ${selectedDateFrom.day} ${widget.months[selectedDateFrom.month]} ${selectedDateFrom.year} ",
                                  style: TextStyle(
                                      color: brightnessProvider.brightness ==
                                              AppBrightness.dark
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorPrimary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.width * 0.03),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width / 3,
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!.to,
                                style: TextStyle(
                                    color: brightnessProvider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.035),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: size.width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: brightnessProvider.brightness ==
                                        AppBrightness.dark
                                    ? AppTheme.colorWhite
                                    : AppTheme.colorPrimary,
                              ),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  _selectDate(context, false);
                                },
                                child: Text(
                                  !dateToPicked
                                      ? AppLocalizations.of(context)!.select
                                      : " ${selectedDateTo.day} ${widget.months[selectedDateTo.month]} ${selectedDateFrom.year}",
                                  style: TextStyle(
                                    color: brightnessProvider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            );
          }),
        ),
        Consumer<BrightnessProvider>(builder: (context, brightnessProvider, _) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: size.width * 0.9,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context)!.results,
                            style: TextStyle(
                                color: brightnessProvider.brightness ==
                                        AppBrightness.dark
                                    ? AppTheme.colorWhite
                                    : AppTheme.colorPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.035),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.total,
                            style: TextStyle(
                                color: brightnessProvider.brightness ==
                                        AppBrightness.dark
                                    ? AppTheme.colorWhite
                                    : AppTheme.colorPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.035),
                          ),
                          Text(
                            '${DashBoardController.to.curency} $totalBalance',
                            style: TextStyle(
                                color: totalBalance < 0
                                    ? Colors.red
                                    : Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.035),
                          ),
                        ],
                      ),
                      startdate != null
                          ? FutureBuilder(
                              future: getcategory(
                                  selectedType == "All"
                                      ? 3
                                      : selectedType == "income"
                                          ? 1
                                          : 0,
                                  startdate!,
                                  enddate),
                              builder: (context, snapshot) {
                                return snapshot.hasData
                                    ? Expanded(
                                        child: ListView.builder(
                                          itemCount:
                                              snapshot.data!.data!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            Data snapshotdata =
                                                snapshot.data!.data![index];
                                            calculateTotalBalance(
                                                snapshot.data!.data);

                                            T.Data a = T.Data(
                                                amount: snapshotdata.amount,
                                                category:
                                                    snapshotdata.categoryName,
                                                dateTime: snapshotdata.dateTime,
                                                file: snapshotdata.files,
                                                name: snapshotdata.name,
                                                note: snapshotdata.note,
                                                imageUrl: snapshotdata
                                                    .categoryImageUrl,
                                                type: snapshotdata.type);
                                            return TransactionCard(
                                                transaction: a);
                                          },
                                        ),
                                      )
                                    : snapshot.connectionState ==
                                            ConnectionState.waiting
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 100),
                                            child: Center(
                                                child: Text(
                                              AppLocalizations.of(context)!
                                                  .notransaction,
                                              style: TextStyle(
                                                  color: brightnessProvider
                                                              .brightness ==
                                                          AppBrightness.dark
                                                      ? AppTheme.colorWhite
                                                      : AppTheme.colorPrimary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: size.width * 0.035),
                                              textAlign: TextAlign.center,
                                            )),
                                          );
                              },
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 100),
                              child: Center(
                                  child: Text(
                                AppLocalizations.of(context)!
                                    .noTransactionsforthegivenfilter,
                                style: TextStyle(
                                    color: brightnessProvider.brightness ==
                                            AppBrightness.dark
                                        ? AppTheme.colorWhite
                                        : AppTheme.colorPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.035),
                                textAlign: TextAlign.center,
                              )),
                            ),
                    ],
                  )),
            ),
          );
        })
      ],
    );
  }
}
