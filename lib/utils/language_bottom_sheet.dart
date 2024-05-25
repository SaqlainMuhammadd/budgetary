import 'package:flutter/material.dart';
import 'package:snab_budget/Screens/currency_screen.dart';

class LanguageBottomSheet {
  static void addLanguageBottomSheet({
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
          return SizedBox(
              height: height * 0.9,
              width: width,
              child: const CurrencyScreen());
        });
  }
}
