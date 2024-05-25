import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import '../utils/category_widget.dart';
import '../utils/summary_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SummaryScreen extends StatefulWidget {
  static const routeName = "summary-screen";
  num? snabbWallet;
  SummaryScreen({super.key, this.snabbWallet});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int check = 0;
  List<String> months = [
    "Janvary",
    "Feburary",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  int _currentSelection = 0;

  var height, width;
  @override
  Widget build(BuildContext context) {
    var providerr = Provider.of<BrightnessProvider>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final Map<int, Widget> children0 = {
      0: Text(
        AppLocalizations.of(context)!.summary,
        style: GoogleFonts.montserrat(),
      ),
      1: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            AppLocalizations.of(context)!.category,
            style: GoogleFonts.montserrat(),
          )),
    };
    List<Widget> children = [
      SummaryWidget(),
      CategoryWidget(
          transactions: TransactionController.to.transactions, months: months)
    ];
    return SafeArea(
      child: Scaffold(
          backgroundColor: providerr.brightness == AppBrightness.dark
              ? const Color(0xff474746)
              : AppTheme.colorWhite,
          key: scaffoldKey,
          body: SizedBox(
            width: double.infinity,
            child: Consumer<BrightnessProvider>(
                builder: (context, brightnessProvider, _) {
              return Column(
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
                            AppLocalizations.of(context)!.summary,
                            style: TextStyle(
                                fontSize: width * 0.04,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: width * 0.23,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MaterialSegmentedControl(
                    verticalOffset: 12,
                    selectionIndex: _currentSelection,
                    borderColor: AppTheme.colorPrimary,
                    selectedColor: AppTheme.colorPrimary,
                    unselectedColor: providerr.brightness == AppBrightness.dark
                        ? const Color(0xff474746)
                        : AppTheme.colorWhite,
                    selectedTextStyle: TextStyle(
                      // ignore: unrelated_type_equality_checks
                      color: Colors.white == AppBrightness.dark
                          ? const Color(0xff474746)
                          : AppTheme.colorWhite,
                    ),
                    unselectedTextStyle: TextStyle(
                      color: AppTheme.colorPrimary,
                    ),
                    borderWidth: 0.7,
                    borderRadius: 32.0,
                    disabledChildren: const [3],
                    onSegmentTapped: (index) {
                      setState(() {
                        _currentSelection = index;
                      });
                    },
                    children: children0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(child: children[_currentSelection])
                ],
              );
            }),
          )),
    );
  }
}
