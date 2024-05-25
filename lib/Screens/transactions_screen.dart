// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/utils/apptheme.dart';
import '../utils/daily_transactions.dart';
import '../utils/monthly_transactions.dart';
import '../utils/yearly_transactions.dart';

class TransactionsScreen extends StatefulWidget {
  static const routeName = "transactions-screen";

  const TransactionsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  int _currentSelection = 0;
  int check = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    const List<String> month = [
      "Jan",
      "Feb",
      "March",
      "April",
      "May",
      "June",
      "July",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec"
    ];
    List<String> dates = List.from({
      ...TransactionController.to.transactions.map((transaction) =>
          "${month[transaction.date.month - 1]}, ${transaction.date.day}, ${transaction.date.year}")
    });
    List<Widget> pagechildren = [
      DailyTransactions(
        dates: dates,
        month: month,
      ),
      const MonthlyTransactions(),
      const YearlyTransactions(),
    ];

    final Map<int, Widget> _children = {
      0: Text(
        AppLocalizations.of(context)!.daily,
        style: GoogleFonts.montserrat(),
      ),
      1: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            AppLocalizations.of(context)!.monthly,
            style: GoogleFonts.montserrat(),
          )),
      2: Text(
        AppLocalizations.of(context)!.yearly,
        style: GoogleFonts.montserrat(),
      ),
    };

    return Scaffold(
        body: SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            height: height * 0.25,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: AppTheme.colorPrimary,
            ),
            width: width,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          )),
                      Expanded(
                        child: Container(
                          height: height,
                          width: width,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: width * 0.1, top: height * 0.05),
                            child: Text(
                              AppLocalizations.of(context)!.transactions,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                MaterialSegmentedControl(
                  verticalOffset: height * 0.02,
                  children: _children,
                  selectionIndex: _currentSelection,
                  borderColor: Colors.white,
                  selectedColor: AppTheme.colorPrimary,
                  unselectedColor: Colors.white.withOpacity(0.3),
                  selectedTextStyle: const TextStyle(color: Colors.white),
                  unselectedTextStyle: const TextStyle(color: Colors.white),
                  borderWidth: 0.7,
                  borderRadius: 10.0,
                  disabledChildren: const [3],
                  onSegmentTapped: (index) {
                    setState(() {
                      _currentSelection = index;
                    });
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: height * 0.75,
              width: width,
              child: pagechildren[_currentSelection],
            ),
          ),
        ],
      ),
    ));
  }
}
