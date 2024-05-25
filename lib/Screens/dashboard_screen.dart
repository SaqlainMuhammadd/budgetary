import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:provider/provider.dart';
import 'package:snab_budget/Screens/recycle_screen.dart';
import 'package:snab_budget/Screens/summary_screen.dart';
import 'package:snab_budget/Screens/transactions_screen.dart';
import 'package:snab_budget/apis/model/get_user_all_transaction.dart';
import 'package:snab_budget/controller/calculator_controller.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../utils/transaction_card.dart';
import 'notification_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final double width = 7;

  static late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  int touchedGroupIndex = -1;

  List<Color> gradientColors = [
    Colors.red,
    Colors.green,
  ];
  bool showAvg = false;
  int check = 0;

  List<FlSpot> list = [];
  List<int> list1 = [];

  @override
  void initState() {
    super.initState();
    list.clear();

    Get.put(TransactionController());
    Get.put(CalculatorController());
    // TransactionController.to.fetchTransaction();
    // TransactionController.to.mounthamount;
    print("#### ${TransactionController.to.item}");

    super.initState();

    print("list17890:$list");

    BarChartGroupData makeGroupData(int x, double y1, double y2) {
      return BarChartGroupData(
        barsSpace: 4,
        x: x,
        barRods: [
          BarChartRodData(
            toY: y1,
            color: Colors.red,
            width: width,
          ),
          BarChartRodData(
            toY: y2,
            color: Colors.green,
            width: width,
          ),
        ],
      );
    }

    rawBarGroups = TransactionController.to.item;
    setState(() {
      showingBarGroups = rawBarGroups;
    });
  }

  checking() {
    list = [const FlSpot(0, 0)];
    print("--------------");
    print(TransactionController.to.mounthamount.length);
    print("--------------");
    for (var v = 0; v < TransactionController.to.mounthamount.length; v++) {
      int monthIndex = v + 1;
      int count = TransactionController.to.mounthamount[v];
      list.add(FlSpot(monthIndex.toDouble(), count.toDouble()));
    }
    print("this is list $list");
    setState(() {});
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      '',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12'
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
          color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 9),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  // BarChartGroupData makeGroupData(int x, double y1, double y2) {
  //   return BarChartGroupData(
  //     barsSpace: 4,
  //     x: x,
  //     barRods: [
  //       BarChartRodData(
  //         toY: y1,
  //         color: Colors.red,
  //         width: width,
  //       ),
  //       BarChartRodData(
  //         toY: y2,
  //         color: Colors.green,
  //         width: width,
  //       ),
  //       BarChartRodData(
  //         toY: 0,
  //         color: Colors.grey,
  //         width: width,
  //       ),
  //     ],
  //   );
  // }

  num balance = 0.0;

  // void getInfo() async {
  //   var docSnapshot = await FirebaseFirestore.instance
  //       .collection("UserTransactions")
  //       .doc(userId)
  //       .collection("data")
  //       .doc("userData")
  //       .get();
  //   if (docSnapshot.exists) {
  //     Map<String, dynamic>? data = docSnapshot.data();
  //     setState(() {
  //       balance = data!["balance"];
  //     });
  //   }
  // }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // if (check == 0) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
    //   check++;
    // }
    // double totalIncomeAmount = 0;
    // double totalexpAmount = 0;
    String convertToKMB(int value) {
      double value1 = TransactionController.to.maxvalue * value / 10;

      if (value1 >= 1000000000000000) {
        return '${(value1 / 1000000000000000).toStringAsFixed(0)}Q';
      } else if (value1 >= 10000000000000) {
        return '${(value1 / 10000000000000).toStringAsFixed(0)}T';
      } else if (value1 >= 1000000000) {
        return '${(value1 / 1000000000).toStringAsFixed(0)}B';
      } else if (value1 >= 1000000) {
        return '${(value1 / 1000000).toStringAsFixed(0)}M';
      } else if (value1 >= 1000) {
        return '${(value1 / 1000).toStringAsFixed(0)}K';
      } else if (value1 >= 100) {
        return '${(value1 / 100).toStringAsFixed(0)}H';
      } else {
        return value1.toString();
      }
    }

    Widget leftTitles(double value, TitleMeta meta) {
      const style = TextStyle(
          color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 9);

      String text;
      switch (value.toInt()) {
        case 2:
          text = convertToKMB(2);
          break;

        case 6:
          text = convertToKMB(6);
          break;
        case 10:
          text = convertToKMB(10);
        default:
          return Container();
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 0,
        child: Text(text, style: style),
      );
    }

    String convertToKBchart(int value) {
      double value1 = TransactionController.to.incomemax * value / 10;

      if (value1 >= 1000000000000000) {
        return '${(value1 / 1000000000000000).toStringAsFixed(0)}Q';
      } else if (value1 >= 10000000000000) {
        return '${(value1 / 10000000000000).toStringAsFixed(0)}T';
      } else if (value1 >= 1000000000) {
        return '${(value1 / 1000000000).toStringAsFixed(0)}B';
      } else if (value1 >= 1000000) {
        return '${(value1 / 1000000).toStringAsFixed(0)}M';
      } else if (value1 >= 1000) {
        return '${(value1 / 1000).toStringAsFixed(0)}K';
      } else if (value1 >= 100) {
        return '${(value1 / 100).toStringAsFixed(0)}H';
      } else {
        return value1.toString();
      }
    }

    Widget leftTitlesWidget(double value, TitleMeta meta) {
      const style = TextStyle(
          color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 9);

      String text;
      switch (value.toInt()) {
        case 2:
          text = convertToKBchart(2);
          break;

        case 6:
          text = convertToKBchart(6);
          break;
        case 10:
          text = convertToKBchart(10);
        default:
          return Container();
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 0,
        child: Text(text, style: style),
      );
    }

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

    // for (Transaction transaction in TransactionController.to.transactions) {
    //   if (transaction.type == TransactionType.income) {
    //     totalIncomeAmount += transaction.amount;
    //   }
    //   if (transaction.type == TransactionType.expense) {
    //     totalexpAmount += transaction.amount;
    //   }
    // }

    Size size = MediaQuery.of(context).size;
    // double devidor = totalIncomeAmount / 5000;

    return Scaffold(
        key: scaffoldKey,
        extendBody: true,
        body: Consumer<BrightnessProvider>(builder: (child, provider, _) {
          return GetBuilder<TransactionController>(builder: (obj) {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<DashBoardController>(initState: (state) {
                  DashBoardController.to.getHomeDetailsdata();
                  DashBoardController.to.getProfileDetailsdata();
                }, builder: (dbOBj) {
                  return Column(children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Card(
                      elevation: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dbOBj.isDrawerOpen
                              ? IconButton(
                                  onPressed: () {
                                    dbOBj.movePage(false, 0, 0, 1);
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 40,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    dbOBj.movePage(true, 230, 150, 0.6);
                                  },
                                  icon: const ImageIcon(
                                    AssetImage("assets/images/menu.png"),
                                    size: 40,
                                  )),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: Text(
                              AppLocalizations.of(context)!.snabbudget,
                              style: TextStyle(
                                  color:
                                      provider.brightness == AppBrightness.dark
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: width * 0.01),
                            child: SizedBox(
                              width: size.width * 0.22,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const NotificationScreen(),
                                        ));
                                      },
                                      icon: ImageIcon(
                                        const AssetImage(
                                            "assets/images/bell.png"),
                                        size: size.width * 0.06,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const RecycleScreen(),
                                        ));
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        size: size.width * 0.05,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: size.height * 0.23,
                      width: size.width - 40,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Card(
                                elevation: 10,
                                shadowColor: AppTheme.colorPrimary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  height: size.height * 0.2,
                                  width: size.width - 70,
                                  decoration: BoxDecoration(
                                      color: AppTheme.colorPrimary
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Card(
                                elevation: 10,
                                shadowColor: AppTheme.colorPrimary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  height: size.height * 0.2,
                                  width: size.width - 60,
                                  decoration: BoxDecoration(
                                      color: AppTheme.colorPrimary
                                          .withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Card(
                              elevation: 10,
                              shadowColor: AppTheme.colorPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                height: size.height * 0.2,
                                width: size.width - 40,
                                decoration: BoxDecoration(
                                    color: AppTheme.colorPrimary,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: size.height,
                                          width: size.width,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .totalamount,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: size.width * 0.03,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              dbOBj.isDataLoad == true
                                                  ? Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .balance,
                                                      style:
                                                          TextStyle(
                                                              letterSpacing: 3,
                                                              color: Colors
                                                                  .white,
                                                              fontSize: size
                                                                      .width *
                                                                  0.03,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      textAlign: TextAlign.left)
                                                  : Text(
                                                      "${dbOBj.curency} ${dbOBj.balance}",
                                                      style: TextStyle(
                                                          letterSpacing: 3,
                                                          color: Colors.white,
                                                          fontSize:
                                                              size.width * 0.03,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign: TextAlign.left)
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: size.height,
                                          width: size.width,
                                          alignment: Alignment.center,
                                          child: Text(
                                              dbOBj.userNAme.toUpperCase(),
                                              maxLines: 2,
                                              style: TextStyle(
                                                  letterSpacing: 3,
                                                  color: Colors.white,
                                                  fontSize: size.width * 0.035,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 15,
                                                      backgroundColor: Colors
                                                          .white
                                                          .withOpacity(0.3),
                                                      child: Icon(
                                                        Icons
                                                            .arrow_downward_rounded,
                                                        color: Colors.white,
                                                        size: size.width * 0.05,
                                                      )),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${AppLocalizations.of(context)!.income} ${month[(DateTime.now().month) - 1]}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.03,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              dbOBj.isDataLoad == true
                                                  ? Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .income,
                                                      style: TextStyle(
                                                          letterSpacing: 3,
                                                          color: Colors.white,
                                                          fontSize:
                                                              size.width * 0.03,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign: TextAlign.left)
                                                  : Text(
                                                      "${dbOBj.curency} ${dbOBj.tIncomeAmount}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              size.width * 0.03,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 15,
                                                      backgroundColor: Colors
                                                          .white
                                                          .withOpacity(0.3),
                                                      child: Icon(
                                                        Icons
                                                            .arrow_upward_rounded,
                                                        color: Colors.white,
                                                        size: size.width * 0.05,
                                                      )),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${AppLocalizations.of(context)!.expense} ${month[(DateTime.now().month) - 1]}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.03,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              dbOBj.isDataLoad == true
                                                  ? Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .expense,
                                                      style:
                                                          TextStyle(
                                                              letterSpacing: 3,
                                                              color: Colors
                                                                  .white,
                                                              fontSize: size
                                                                      .width *
                                                                  0.03,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      textAlign: TextAlign.left)
                                                  : Text(
                                                      "${dbOBj.curency} ${dbOBj.tExpenceAmount}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              size.width * 0.03,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: size.width - 40,
                        height: size.height,
                        child: ListView(
                          children: [
                            SizedBox(
                              height: size.height * 0.2,
                              width: width,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.2,
                                    width: size.width * 0.25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${month[(DateTime.now().month) - 1]} ${(DateTime.now().year)}",
                                          style: TextStyle(
                                            fontSize: size.width * 0.035,
                                            color: provider.brightness ==
                                                    AppBrightness.dark
                                                ? AppTheme.colorWhite
                                                : AppTheme.colorPrimary,
                                          ),
                                        ),
                                        dbOBj.isDataLoad == true
                                            ? SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppTheme.colorPrimary,
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            SummaryScreen(),
                                                      ));
                                                },
                                                child: Container(
                                                  height: size.height * 0.15,
                                                  width: size.width * 0.8,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.grey[200]),
                                                  child: Center(
                                                    child: dbOBj.dataMap == null
                                                        ? CircularProgressIndicator(
                                                            color: AppTheme
                                                                .colorPrimary,
                                                          )
                                                        : pie.PieChart(
                                                            ringStrokeWidth:
                                                                15.0,
                                                            chartRadius:
                                                                size.width *
                                                                    0.17,
                                                            animationDuration:
                                                                const Duration(
                                                                    seconds: 1),
                                                            chartValuesOptions:
                                                                const pie
                                                                    .ChartValuesOptions(
                                                              showChartValueBackground:
                                                                  true,
                                                              showChartValues:
                                                                  true,
                                                              showChartValuesInPercentage:
                                                                  true,
                                                              showChartValuesOutside:
                                                                  false,
                                                              decimalPlaces: 1,
                                                            ),
                                                            legendOptions:
                                                                const pie
                                                                    .LegendOptions(
                                                                    showLegends:
                                                                        false),
                                                            dataMap:
                                                                dbOBj.dataMap,
                                                            chartType: pie
                                                                .ChartType.ring,
                                                            baseChartColor:
                                                                Colors
                                                                    .grey[300]!,
                                                            colorList:
                                                                dbOBj.colorList,
                                                          ),
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: 2,
                                      shadowColor: AppTheme.colorPrimary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SizedBox(
                                        height: size.height,
                                        width: size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: size.height * 0.2,
                                                    width: size.width * 0.5,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .income,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.width *
                                                                          0.03,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                            Text(
                                                              "/",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.width *
                                                                          0.035,
                                                                  color: AppTheme
                                                                      .colorPrimary),
                                                            ),
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .expense,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.width *
                                                                          0.03,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ],
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const TransactionsScreen(),
                                                                ));
                                                          },
                                                          child: SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.14,
                                                              width:
                                                                  size.width *
                                                                      0.8,
                                                              child: BarChart(
                                                                BarChartData(
                                                                  minY: 0,
                                                                  maxY: 10,
                                                                  barTouchData:
                                                                      BarTouchData(
                                                                    touchTooltipData:
                                                                        BarTouchTooltipData(
                                                                      // tooltipBgColor:
                                                                      //     Colors
                                                                      //         .grey,
                                                                      getTooltipItem: (a,
                                                                              b,
                                                                              c,
                                                                              d) =>
                                                                          null,
                                                                    ),
                                                                    touchCallback:
                                                                        (FlTouchEvent
                                                                                event,
                                                                            response) {
                                                                      if (response ==
                                                                              null ||
                                                                          response.spot ==
                                                                              null) {
                                                                        setState(
                                                                            () {
                                                                          touchedGroupIndex =
                                                                              -1;
                                                                          showingBarGroups =
                                                                              List.of(rawBarGroups);
                                                                        });
                                                                        return;
                                                                      }

                                                                      touchedGroupIndex = response
                                                                          .spot!
                                                                          .touchedBarGroupIndex;

                                                                      setState(
                                                                          () {
                                                                        if (!event
                                                                            .isInterestedForInteractions) {
                                                                          touchedGroupIndex =
                                                                              -1;
                                                                          showingBarGroups =
                                                                              List.of(rawBarGroups);
                                                                          return;
                                                                        }
                                                                        showingBarGroups =
                                                                            List.of(rawBarGroups);
                                                                        if (touchedGroupIndex !=
                                                                            -1) {
                                                                          var sum =
                                                                              0.0;
                                                                          for (final rod
                                                                              in showingBarGroups[touchedGroupIndex].barRods) {
                                                                            sum +=
                                                                                rod.toY;
                                                                          }
                                                                          final avg =
                                                                              sum / showingBarGroups[touchedGroupIndex].barRods.length;

                                                                          showingBarGroups[touchedGroupIndex] =
                                                                              showingBarGroups[touchedGroupIndex].copyWith(
                                                                            barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                                                                              return rod.copyWith(
                                                                                toY: avg,
                                                                                color: Colors.grey,
                                                                              );
                                                                            }).toList()
                                                                              ..add(
                                                                                BarChartRodData(
                                                                                  fromY: 0,
                                                                                  color: Colors.grey,
                                                                                  toY: 0,
                                                                                ),
                                                                              ),
                                                                          );
                                                                        }
                                                                      });
                                                                    },
                                                                  ),
                                                                  titlesData:
                                                                      FlTitlesData(
                                                                    show: true,
                                                                    rightTitles:
                                                                        const AxisTitles(
                                                                      sideTitles:
                                                                          SideTitles(
                                                                              showTitles: false),
                                                                    ),
                                                                    topTitles:
                                                                        const AxisTitles(
                                                                      sideTitles:
                                                                          SideTitles(
                                                                              showTitles: false),
                                                                    ),
                                                                    bottomTitles:
                                                                        AxisTitles(
                                                                      sideTitles:
                                                                          SideTitles(
                                                                        showTitles:
                                                                            true,
                                                                        getTitlesWidget:
                                                                            bottomTitles,
                                                                        reservedSize:
                                                                            42,
                                                                      ),
                                                                    ),
                                                                    leftTitles:
                                                                        AxisTitles(
                                                                      sideTitles:
                                                                          SideTitles(
                                                                        showTitles:
                                                                            true,
                                                                        reservedSize:
                                                                            40,
                                                                        interval:
                                                                            1,
                                                                        getTitlesWidget:
                                                                            leftTitles,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  borderData:
                                                                      FlBorderData(
                                                                          show:
                                                                              false),
                                                                  barGroups:
                                                                      showingBarGroups,
                                                                  gridData:
                                                                      const FlGridData(
                                                                          show:
                                                                              false),
                                                                ),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 2,
                              shadowColor: AppTheme.colorPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: SizedBox(
                                  height: size.height * 0.22,
                                  width: size.width * 0.86,
                                  child: Stack(
                                    children: <Widget>[
                                      GetBuilder<TransactionController>(
                                          builder: (obbj) {
                                        return SizedBox(
                                          height: size.height * 0.22,
                                          width: size.width * 0.86,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 18,
                                              left: 12,
                                              top: 24,
                                              bottom: 7,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const TransactionsScreen(),
                                                    ));
                                              },
                                              child: LineChart(showAvg
                                                  ? LineChartData()
                                                  : LineChartData(
                                                      lineTouchData:
                                                          const LineTouchData(
                                                              enabled: false),
                                                      gridData: FlGridData(
                                                        show: true,
                                                        drawHorizontalLine:
                                                            true,
                                                        verticalInterval: 1,
                                                        horizontalInterval: 1,
                                                        getDrawingVerticalLine:
                                                            (value) {
                                                          return const FlLine(
                                                            color: Color(
                                                                0xff37434d),
                                                            strokeWidth: 0.5,
                                                          );
                                                        },
                                                        getDrawingHorizontalLine:
                                                            (value) {
                                                          return const FlLine(
                                                            color: Color(
                                                                0xff37434d),
                                                            strokeWidth: 0.05,
                                                          );
                                                        },
                                                      ),
                                                      titlesData: FlTitlesData(
                                                        show: true,
                                                        bottomTitles:
                                                            AxisTitles(
                                                          sideTitles:
                                                              SideTitles(
                                                            showTitles: true,
                                                            reservedSize: 30,
                                                            getTitlesWidget:
                                                                bottomTitles,
                                                            interval: 1,
                                                          ),
                                                        ),
                                                        leftTitles: AxisTitles(
                                                          sideTitles:
                                                              SideTitles(
                                                            showTitles: true,
                                                            getTitlesWidget:
                                                                leftTitlesWidget,
                                                            reservedSize: 45,
                                                            interval: 1,
                                                          ),
                                                        ),
                                                        topTitles:
                                                            const AxisTitles(
                                                          sideTitles:
                                                              SideTitles(
                                                                  showTitles:
                                                                      false),
                                                        ),
                                                        rightTitles:
                                                            const AxisTitles(
                                                          sideTitles:
                                                              SideTitles(
                                                                  showTitles:
                                                                      false),
                                                        ),
                                                      ),
                                                      borderData: FlBorderData(
                                                        show: true,
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xff37434d)),
                                                      ),
                                                      minX: 0,
                                                      maxX: 12,
                                                      minY: -0.58,
                                                      maxY: 14,
                                                      lineBarsData: [
                                                        LineChartBarData(
                                                          spots: obbj.list,
                                                          isCurved: true,
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              gradientColors[0],
                                                              gradientColors[1],
                                                            ],
                                                          ),
                                                          barWidth: 2,
                                                          isStrokeJoinRound:
                                                              false,
                                                          preventCurveOverShooting:
                                                              false,
                                                          isStrokeCapRound:
                                                              false,
                                                          dotData:
                                                              const FlDotData(
                                                            show: false,
                                                          ),
                                                          belowBarData:
                                                              BarAreaData(
                                                            show: true,
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                ColorTween(
                                                                        begin: gradientColors[
                                                                            0],
                                                                        end: gradientColors[
                                                                            1])
                                                                    .lerp(0.2)!
                                                                    .withOpacity(
                                                                        0.1),
                                                                ColorTween(
                                                                        begin: gradientColors[
                                                                            0],
                                                                        end: gradientColors[
                                                                            1])
                                                                    .lerp(0.2)!
                                                                    .withOpacity(
                                                                        0.1),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                            ),
                                          ),
                                        );
                                      }),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: SizedBox(
                                          width: 60,
                                          height: 34,
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                showAvg = !showAvg;
                                              });
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!.avg,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: showAvg
                                                    ? Colors.white
                                                        .withOpacity(0.5)
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            if (obj.userAllTransaction.isNotEmpty)
                              Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          " ${AppLocalizations.of(context)!.transactions}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextButton(
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .seeall,
                                              style: TextStyle(
                                                  fontSize: size.width * 0.035,
                                                  color: Colors.grey)),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const TransactionsScreen(),
                                                ));
                                          },
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    children: List.generate(
                                        obj.userAllTransaction.length, (index) {
                                      Data transaction =
                                          obj.userAllTransaction[index];
                                      return TransactionCard(
                                          transaction: transaction);
                                    }),
                                  ),
                                ],
                              )
                            else
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .notransactions,
                                          textAlign: TextAlign.center,
                                        )),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ]);
                }),
              ),
            );
          });
        }));
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}

class ChartData {
  ChartData(this.xData, this.yData, this.text);

  String xData;
  num yData;
  String text;
}
