import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/utils/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class DailyStats extends StatefulWidget {
  DailyStats({
    super.key,
  });

  @override
  State<DailyStats> createState() => _DailyStatsState();
}

class _DailyStatsState extends State<DailyStats> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<TransactionController>(builder: (obj) {
      return Scaffold(
          key: scaffoldKey,
          body: SafeArea(
              child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                GetBuilder<DashBoardController>(builder: (dbOBj) {
                  return Card(
                      child: SizedBox(
                    height: 50,
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
                        Text(
                          AppLocalizations.of(context)!.daily,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 50,
                        )
                      ],
                    ),
                  ));
                }),
                statCard(
                    size,
                    "Budgetary ${AppLocalizations.of(context)!.wallet}",
                    AppLocalizations.of(context)!.balance,
                    "${DashBoardController.to.curency}${obj.balance.toString()}",
                    Colors.green),
              ],
            ),
          )));
    });
  }

  Column statCard(
      Size size, String name, String unitName, String amount, Color color) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: size.height / 8.5,
            width: size.width - 22,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              //color: const Color.fromRGBO(245, 246, 255,1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(unitName,
                            style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold,
                              //color: Colors.grey
                            )),
                        Text(
                          amount,
                          style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
