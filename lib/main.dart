// ignore_for_file: unused_import

import 'package:devicelocale/devicelocale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snab_budget/Screens/addexpanse.dart';
import 'package:snab_budget/Screens/budget/budget.dart';
import 'package:snab_budget/Screens/calender.dart';
import 'package:snab_budget/Screens/dashboard_screen.dart';
import 'package:snab_budget/Screens/home_screen.dart';
import 'package:snab_budget/Screens/preferences.dart';
import 'package:snab_budget/Screens/schedule_transactions.dart';
import 'package:snab_budget/Screens/splash_screen.dart';
import 'package:snab_budget/Screens/summary_screen.dart';
import 'package:snab_budget/Screens/transactions_screen.dart';
import 'package:snab_budget/testingfiles/testsc.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import 'package:snab_budget/utils/custom_drawer.dart';
import 'Screens/accounts.dart';
import 'Screens/addincome.dart';
import 'Screens/debit_credit/deptsscreen.dart';
import 'Screens/setting_screen.dart';
import 'controller/IncomeProvider.dart';
import 'controller/balanceProvider.dart';
import 'l10n/l10n.dart';
import 'utils/materialColor.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:geocoding/geocoding.dart' as p;
import 'package:location/location.dart' as loc;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String? locale = await Devicelocale.currentLocale;
  _getLocation();
  print("----------------");
  print(locale);

  runApp(const MyApp());
}

Locale mainlocale = const Locale("en");

loc.Location location = loc.Location();
loc.LocationData? _locationData;
double? long, lat;
Future<void> _getLocation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString("local");
  if (value == null) {
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (serviceEnabled) {
      _locationData = await location.getLocation();
      long = _locationData!.longitude;
      lat = _locationData!.latitude;
      print("$long ------------ $lat");

      getcurrentlocal(lat!.toDouble(), long!.toDouble());
    }
  } else {
    print("hello");

    if (value.toLowerCase() == "ita") {
      mainlocale = const Locale("it");
    } else if (value.toLowerCase() == "fra") {
      mainlocale = const Locale("fr");
    } else if (value.toLowerCase() == "dnk") {
      mainlocale = const Locale("da");
    } else if (value.toLowerCase() == "deu") {
      mainlocale = const Locale("de");
    } else if (value.toLowerCase() == "esp") {
      mainlocale = const Locale("es");
    } else if (value.toLowerCase() == "pol") {
      mainlocale = const Locale("pl");
    } else if (value.toLowerCase() == "swe") {
      print("hello");
      mainlocale = const Locale("sv");
    } else {
      mainlocale = const Locale("en");
    }
  }
}

Future<void> getcurrentlocal(double lat, double long) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // List<p.Placemark> placemarks = await p.placemarkFromCoordinates(lat, long);
  // String? countryCode = placemarks[0].isoCountryCode;

  // print("----------------m  $countryCode");
  // if (countryCode!.toLowerCase() == "ita") {
  //   mainlocale = const Locale("it");
  //   prefs.setString("local", "ita");
  // } else if (countryCode.toLowerCase() == "fra") {
  //   mainlocale = const Locale("fr");
  //   prefs.setString("local", "fra");
  // } else if (countryCode.toLowerCase() == "dnk") {
  //   mainlocale = const Locale("da");
  //   prefs.setString("local", "dnk");
  // } else if (countryCode.toLowerCase() == "deu") {
  //   mainlocale = const Locale("de");
  //   prefs.setString("local", "deu");
  // } else if (countryCode.toLowerCase() == "esp") {
  //   mainlocale = const Locale("es");
  //   prefs.setString("local", "esp");
  // } else if (countryCode.toLowerCase() == "pol") {
  //   mainlocale = const Locale("pl");
  //   prefs.setString("local", "pol");
  // } else if (countryCode.toLowerCase() == "swe") {
  //   mainlocale = const Locale("sv");
  //   prefs.setString("local", "swe");
  // } else {
  //   mainlocale = const Locale("en");
  //   prefs.setString("local", "en");
  // }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }
}

class _MyAppState extends State<MyApp> {
  // late final Locale _locale = mainlocale;
  setLocale(Locale newLocale) {
    setState(() {
      mainlocale = newLocale;
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setLocale(mainlocale);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lan = AppLocalizations.of(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BalanceProvider>(
          create: (context) => BalanceProvider(),
        ),
        ChangeNotifierProvider<SelectedItemProvider>(
          create: (context) => SelectedItemProvider(),
        ),
        ChangeNotifierProvider<BrightnessProvider>(
          create: (context) => BrightnessProvider(),
        ),
      ],
      child: Consumer<BrightnessProvider>(
        builder: (context, brightnessProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: ThemeData(
              brightness: brightnessProvider.brightness == AppBrightness.light
                  ? Brightness.light
                  : Brightness.dark,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              primaryColor: AppTheme.colorPrimary,
              primarySwatch: generateMaterialColor(
                AppTheme.colorPrimary,
              ),
            ),
            home: const SplashScreen(),
            // : Welcome(),
            supportedLocales: L10n.all,
            locale: mainlocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            routes: {
              CalenderScreen.routeName: (context) => const CalenderScreen(),
              ScheduleTransactions.routeName: (context) =>
                  const ScheduleTransactions(),
              BudgetScreen.routeName: (context) => const BudgetScreen(),
              PreferencesScreen.routeName: (context) =>
                  const PreferencesScreen(),
              Accounts.routeName: (ctx) => const Accounts(),
              HomeScreen.routeName: (ctx) => const HomeScreen(),
              // AddExpanse.routeName: (ctx) => const AddExpanse(),
              // AddIncome.routeName: (ctx) => const AddIncome(),
              BalanceScreen.routeName: (ctx) => BalanceScreen(),
              SettingScreen.routeName: (ctx) => const SettingScreen(),
              SummaryScreen.routeName: (ctx) => SummaryScreen(),
              TransactionsScreen.routeName: (ctx) => const TransactionsScreen(),
            },
          );
        },
      ),
    );
  }
}
