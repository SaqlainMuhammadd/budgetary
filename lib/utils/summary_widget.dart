import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:snab_budget/Screens/summary/summary_detail.dart';
import 'package:snab_budget/Screens/transactions_screen.dart';
import 'package:snab_budget/apis/ApiStore.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/models/summarymodel.dart';
import 'package:snab_budget/static_data.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../models/transaction.dart';

// ignore: must_be_immutable
class SummaryWidget extends StatefulWidget {
  const SummaryWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SummaryWidget> createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  // final String userId = FirebaseAuth.instance.currentUser!.uid;
  Map<DateTime, List<Transaction>> transactionsByMonth = {};
  List<DateTime> monthsWithTransactions = [];
  DateTime now = DateTime.now();
  SummaryModel? model;

  Future<SummaryModel> getSummery(String date) async {
    var res = await httpClient().get("${StaticValues.getSummary}$date");
    model = SummaryModel.fromMap(res.data as Map<String, dynamic>);
    print("date ${date}");
    return model!;
    // Adjust the delay as needed.
  }

  Future<void> showImageDialog(
    double totalIncome,
    double totalExpense,
    BuildContext context,
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
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TransactionsScreen(),
                              ));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: AppTheme.colorPrimary,
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.trancactions,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SummaryDetailsPage(
                                  ammount: totalIncome,
                                  type: "income",
                                  curency: DashBoardController.to.curency,
                                ),
                              ));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: AppTheme.colorPrimary,
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.categoriesincome,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SummaryDetailsPage(
                                  ammount: totalExpense,
                                  type: "expence",
                                  curency: DashBoardController.to.curency,
                                ),
                              ));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: AppTheme.colorPrimary,
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.categoriesexpensis,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.08,
                        decoration: BoxDecoration(
                            color: AppTheme.colorPrimary,
                            shape: BoxShape.circle),
                        child: const Center(
                          child: Icon(
                            Icons.clear,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    getSummery("${now.year}-${now.month}-${now.day}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height - 150,
        child: FutureBuilder<SummaryModel>(
            future: getSummery("${now.year}-${now.month}-${now.day}"),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        // DateTime selectedMonth = monthsWithTransactions[index];
                        // List<Transaction> transactionsForMonth =
                        //     transactionsByMonth[selectedMonth] ?? [];

                        // for (var transaction in transactionsForMonth) {
                        //   if (transaction.type == TransactionType.income) {
                        //     totalIncome += transaction.amount;
                        //   } else if (transaction.type == TransactionType.expense) {
                        //     totalExpense += transaction.amount;
                        //   }
                        // }
                        num balance = snapshot
                                .data!.data![index].transactions!.income! -
                            snapshot.data!.data![index].transactions!.expense!;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              showImageDialog(
                                  snapshot
                                      .data!.data![index].transactions!.income!,
                                  snapshot.data!.data![index].transactions!
                                      .expense!,
                                  context);
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          model!.data![index].month.toString(),
                                          // "${widget.months[selectedMonth.month - 1]} ${selectedMonth.year}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: PieChart(
                                            dataMap: {
                                              "expense": double.parse(
                                                  "${snapshot.data!.data![index].transactions!.expense!}"),
                                              "income": double.parse(
                                                  "${snapshot.data!.data![index].transactions!.income!}"),
                                            },
                                            colorList: const [
                                              Color.fromRGBO(255, 59, 59, 1),
                                              Color.fromRGBO(124, 179, 66, 1)
                                            ],
                                            legendOptions: const LegendOptions(
                                              showLegends: false,
                                            ),
                                            chartValuesOptions:
                                                const ChartValuesOptions(
                                              showChartValues: false,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.income,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.expense,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.total,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          " ${DashBoardController.to.curency}${snapshot.data!.data![index].transactions!.income!}",
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "-${DashBoardController.to.curency}${model!.data![index].transactions!.expense!}",
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          balance > 0
                                              ? "+${DashBoardController.to.curency}$balance"
                                              : "${DashBoardController.to.curency}$balance",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: balance > 0
                                                  ? Colors.green
                                                  : Colors.red),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }
}
