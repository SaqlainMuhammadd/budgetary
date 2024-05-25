import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../utils/brighness_provider.dart';

class ThemeChangeScreen extends StatefulWidget {
  const ThemeChangeScreen({super.key});

  @override
  State<ThemeChangeScreen> createState() => _ThemeChangeScreenState();
}

class _ThemeChangeScreenState extends State<ThemeChangeScreen> {
  @override
  Widget build(BuildContext context) {
    final brightnessProvider = Provider.of<BrightnessProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.chosetheme,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.colorPrimary),
            ),
            Expanded(
              child: RadioListTile<AppBrightness>(
                title: Text(AppLocalizations.of(context)!.light),
                value: AppBrightness.light,
                activeColor: AppTheme.colorPrimary,
                groupValue: brightnessProvider.brightness,
                onChanged: (value) {
                  brightnessProvider.brightness = value!;
                },
              ),
            ),
            Expanded(
              child: RadioListTile<AppBrightness>(
                title: Text(AppLocalizations.of(context)!.dark),
                value: AppBrightness.dark,
                activeColor: AppTheme.colorPrimary,
                groupValue: brightnessProvider.brightness,
                onChanged: (value) {
                  brightnessProvider.brightness = value!;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
