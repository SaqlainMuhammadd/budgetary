import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/utils/brighness_provider.dart';

class PreferencesScreen extends StatefulWidget {
  static const routeName = "preference-Screen";

  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Consumer<BrightnessProvider>(
            builder: (context, brightnessProvider, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                        "${AppLocalizations.of(context)!.preferences}",
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: width * 0.21,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 41, right: 30),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.basicaccount,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.04,
                              color: brightnessProvider.brightness ==
                                      AppBrightness.dark
                                  ? AppTheme.colorWhite
                                  : AppTheme.colorPrimary),
                        )),
                    Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(
                          AppLocalizations.of(context)!.current,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.035,
                              color: brightnessProvider.brightness ==
                                      AppBrightness.light
                                  ? AppTheme.colorPrimary
                                  : Colors.white),
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)!.dataSavedOnDevice,
                          style: TextStyle(
                              color: brightnessProvider.brightness ==
                                      AppBrightness.light
                                  ? AppTheme.colorPrimary
                                  : Colors.white),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(AppLocalizations.of(context)!.free,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: brightnessProvider.brightness ==
                                          AppBrightness.dark
                                      ? AppTheme.colorWhite
                                      : AppTheme.colorPrimary))),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.superioraccount,
                          style: TextStyle(
                            color: brightnessProvider.brightness ==
                                    AppBrightness.dark
                                ? AppTheme.colorWhite
                                : AppTheme.colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.04,
                          ),
                        )),
                    Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(
                          "${AppLocalizations.of(context)!.current}",
                          style: TextStyle(
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.bold,
                              color: brightnessProvider.brightness ==
                                      AppBrightness.light
                                  ? AppTheme.colorPrimary
                                  : Colors.white),
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)!.clouddatastorage,
                          style: TextStyle(
                              color: brightnessProvider.brightness ==
                                      AppBrightness.light
                                  ? AppTheme.colorPrimary
                                  : Colors.white),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(AppLocalizations.of(context)!.fiveeuro,
                              style: TextStyle(
                                color: brightnessProvider.brightness ==
                                        AppBrightness.dark
                                    ? AppTheme.colorWhite
                                    : AppTheme.colorPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.elegantaccount,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.04,
                              color: brightnessProvider.brightness ==
                                      AppBrightness.dark
                                  ? AppTheme.colorWhite
                                  : AppTheme.colorPrimary),
                        )),
                    Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(
                          "${AppLocalizations.of(context)!.current}",
                          style: TextStyle(
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)!.unlimitedFileRestore,
                          style: TextStyle(
                              color: brightnessProvider.brightness ==
                                      AppBrightness.light
                                  ? AppTheme.colorPrimary
                                  : Colors.white),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(AppLocalizations.of(context)!.fifteeneuro,
                              style: TextStyle(
                                color: brightnessProvider.brightness ==
                                        AppBrightness.dark
                                    ? AppTheme.colorWhite
                                    : AppTheme.colorPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      )),
    );
  }
}
