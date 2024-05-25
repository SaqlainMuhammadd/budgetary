import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snab_budget/controller/calculator_controller.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';

class BudgetCalculator {
  static void addSimpleCalculatorBottomSheet({
    context,
    height,
    width,
  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return GetBuilder<CalculatorController>(builder: (obj) {
            return SizedBox(
              height: height * 0.85,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: height * 0.04,
                                width: width * 0.08,
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
                            Text(
                              "${AppLocalizations.of(context)!.snabbbudgetcalculator}",
                              style: TextStyle(
                                  color: AppTheme.colorPrimary,
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, right: 15.0),
                      child: Text(
                        obj.history,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w200,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, right: 15.0, bottom: 15.0),
                      child: Text(
                        obj.output,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.w100,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: obj.clear,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: AppTheme.colorPrimary,
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.block,
                                color: Colors.white,
                                size: width * 0.1,
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.sign,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: AppTheme.colorPrimary,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "±",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.percent,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: AppTheme.colorPrimary,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "%",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.div,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: AppTheme.colorPrimary,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "÷",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: obj.click1,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.black45,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.click2,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.black45,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.click3,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.black45,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "3",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.mul,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: AppTheme.colorPrimary,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "×",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: obj.click4,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.black45,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "4",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.click5,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.black45,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "5",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.click6,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.black45,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "6",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.sub,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: AppTheme.colorPrimary,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "-",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: obj.click7,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.black45,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "7",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.click8,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.black45,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "8",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.click9,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.black45,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "9",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.add,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: AppTheme.colorPrimary,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "+",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 5.0, bottom: 6.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: obj.click0,
                              constraints:
                                  const BoxConstraints.tightFor(width: 170.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45.0)),
                              elevation: 2.0,
                              fillColor: Colors.black45,
                              padding: const EdgeInsets.only(
                                  left: 18.0,
                                  top: 15.0,
                                  bottom: 15.0,
                                  right: 15.0),
                              child: const Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.clickDot,
                              shape: CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.black45,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                ".",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: obj.equals,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: AppTheme.colorPrimary,
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                "=",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ]),
                    ),
                  ]),
            );
          });
        });
  }
}
//   static void addPercentageCalculatorBottomSheet({
//     context,
//     height,
//     width,
//   }) {
//     showModalBottomSheet(
//         isScrollControlled: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
//         ),
//         context: context,
//         builder: (BuildContext bc) {});
//   }
// }
