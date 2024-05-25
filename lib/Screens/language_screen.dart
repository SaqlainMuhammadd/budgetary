import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../main.dart';

class LanguageScreen extends StatefulWidget {
  static const routeName = "language-screen";
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  void changeLocale(value) {
    MyApp.setLocale(context, Locale(value));
  }

  @override
  Widget build(BuildContext context) {
    String lang = Localizations.localeOf(context).toString();
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.choseyourlanguage,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Espanol", style: TextStyle(fontSize: 16)),
                Radio(value: "es", groupValue: lang, onChanged: changeLocale),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Polish", style: TextStyle(fontSize: 16)),
                Radio(value: "pl", groupValue: lang, onChanged: changeLocale),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Francias", style: TextStyle(fontSize: 16)),
                Radio(value: "fr", groupValue: lang, onChanged: changeLocale),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("English", style: TextStyle(fontSize: 16)),
                Radio(value: "en", groupValue: lang, onChanged: changeLocale),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Italiano", style: TextStyle(fontSize: 16)),
                Radio(value: "it", groupValue: lang, onChanged: changeLocale),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Danish", style: TextStyle(fontSize: 16)),
                Radio(value: "da", groupValue: lang, onChanged: changeLocale),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Finnish", style: TextStyle(fontSize: 16)),
                Radio(value: "fi", groupValue: lang, onChanged: changeLocale),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Swedish", style: TextStyle(fontSize: 16)),
                Radio(value: "sv", groupValue: lang, onChanged: changeLocale),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("German", style: TextStyle(fontSize: 16)),
                Radio(value: "de", groupValue: lang, onChanged: changeLocale),
              ],
            ),
          ]),
        ),
      )),
    );
  }
}
