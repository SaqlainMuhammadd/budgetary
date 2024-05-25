import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/utils/currency_model.dart';

import '../models/currency_controller.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<TransactionController>(builder: (obj) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.clear,
                  color: AppTheme.colorPrimary,
                  size: size.width * 0.07,
                ),
              ),
            ),
            Center(
              child: Text(
                AppLocalizations.of(context)!.chooseyourcurrency,
                style: TextStyle(
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.colorPrimary),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: ListView.builder(
                  itemCount: CurrencyModell.currencyList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(CurrencyModell.currencyList[index].name!,
                            style: TextStyle(fontSize: size.width * 0.03)),
                        Radio(
                          value: CurrencyModell.currencyList[index].value!,
                          activeColor: AppTheme.colorPrimary,
                          groupValue: DashBoardController.to.curency,
                          onChanged: (value) {
                            obj.changeCurrency(
                                value, context, size.height, size.width);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
