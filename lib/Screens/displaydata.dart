// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../models/IncomeDataMode.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class DisplayIncomeScreen extends StatelessWidget {
  final List<IncomeData> incomeList;

  const DisplayIncomeScreen(this.incomeList);
  double calculatetotalamount() {
    double totalamount = 0;
    for (IncomeData expense in incomeList) {
      totalamount += expense.amount;
    }
    return totalamount;
  }

  @override
  Widget build(BuildContext context) {
    double totalamount = calculatetotalamount();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.incomedetails),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('${AppLocalizations.of(context)!.totalamount}:'),
              trailing: Text(totalamount.toStringAsFixed(2)),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: incomeList.length,
                  itemBuilder: (context, index) {
                    IncomeData income = incomeList[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          income.imageurl,
                          width: 100,
                          height: 100,
                        ),
                        Text(
                            '${AppLocalizations.of(context)!.name}: ${income.name}'),
                        SizedBox(height: 8.0),
                        Text(
                            '${AppLocalizations.of(context)!.amount}: ${income.amount}'),
                        SizedBox(height: 8.0),
                        SizedBox(height: 8.0),
                        Text(
                            '${AppLocalizations.of(context)!.date}: ${DateFormat.yMMMd().format(income.date)}'),
                        Text(
                            '${AppLocalizations.of(context)!.date}: ${(income.time)}'),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
