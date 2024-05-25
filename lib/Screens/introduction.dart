import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snab_budget/Screens/auth/login.dart';
import 'package:snab_budget/main.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/utils/currency_model.dart';
import 'package:vector_math/vector_math.dart' as math;

class IntroductionScreensPage extends StatefulWidget {
  const IntroductionScreensPage({Key? key}) : super(key: key);

  @override
  _IntroductionScreensPageState createState() =>
      _IntroductionScreensPageState();
}

class _IntroductionScreensPageState extends State<IntroductionScreensPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  }

  Widget _buildImage(String assetName) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Image.asset(
          assetName,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  void changeLocale(value, context, height, width, String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.rotate(
          angle: math.radians(a1.value * 360),
          child: AlertDialog(
            elevation: 10,
            shadowColor: AppTheme.colorPrimary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              height: height * 0.3,
              width: width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context)!.changelanguage,
                    style: TextStyle(
                        fontSize: width * 0.04,
                        color: AppTheme.colorPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppLocalizations.of(context)!.changelanguage,
                    style: TextStyle(
                        fontSize: width * 0.03,
                        color: AppTheme.colorPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.2,
                    width: width * 0.2,
                    child: Lottie.asset('assets/lottie_files/success.json'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: const TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.confirm,
                  style: TextStyle(color: AppTheme.colorPrimary),
                ),
                onPressed: () {
                  MyApp.setLocale(context, Locale(value));
                  lang = value;
                  if (value!.toString().toLowerCase() == "it") {
                    prefs.setString("local", "ita");
                  } else if (value!.toString().toLowerCase() == "fr") {
                    prefs.setString("local", "fra");
                  } else if (value!.toString().toLowerCase() == "da") {
                    prefs.setString("local", "dnk");
                  } else if (value!.toString().toLowerCase() == "de") {
                    prefs.setString("local", "deu");
                  } else if (value!.toString().toLowerCase() == "es") {
                    prefs.setString("local", "esp");
                  } else if (value!.toString().toLowerCase() == "pl") {
                    prefs.setString("local", "pol");
                  } else if (value!.toString().toLowerCase() == "sv") {
                    prefs.setString("local", "swe");
                  } else {
                    mainlocale = const Locale("en");
                    prefs.setString("local", "en");
                  }

                  Navigator.pop(context);
                  Future.delayed(const Duration(milliseconds: 600), () {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 600),
    );
  }

  Future<void> showLanguageConfirmationDialog(
      BuildContext context, String lang) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10,
          shadowColor: AppTheme.colorPrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            AppLocalizations.of(context)!.language,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppTheme.colorPrimary),
          ),
          content: Text(
              "${AppLocalizations.of(context)!.yourselectedlanis} : ${AppLocalizations.of(context)!.languagename}"),
          actions: <Widget>[
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.changelanguage,
                style: const TextStyle(color: Colors.green),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15.0)),
                  ),
                  builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.68,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(children: [
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
                                size: 30,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.choseyourlanguage,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: CountryModell.currencyList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        CountryModell.currencyList[index].name!,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03)),
                                    StatefulBuilder(builder: (context, state) {
                                      return Radio(
                                        value: CountryModell
                                            .currencyList[index].value!,
                                        activeColor: AppTheme.colorPrimary,
                                        groupValue: lang,
                                        onChanged: (value) {
                                          state(() {
                                            lang = value.toString();
                                          });
                                          print("valuee $lang");
                                          changeLocale(
                                              value,
                                              context,
                                              MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              MediaQuery.of(context).size.width,
                                              lang);
                                        },
                                      );
                                    }),
                                  ],
                                );
                              },
                            ),
                          )
                        ]),
                      ),
                    );
                  },
                );
              },
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.confirm,
                style: TextStyle(color: AppTheme.colorPrimary),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  String? lang;
  int check = 0;
  @override
  Widget build(BuildContext context) {
    check++;
    lang = Localizations.localeOf(context).toString();
    if (check == 1) {
      Future.delayed(const Duration(seconds: 1), () {
        showLanguageConfirmationDialog(context, lang!);
      });
    }
    const bodyStyle = TextStyle(fontSize: 16.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      // descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          bodyWidget: SizedBox(
            width: MediaQuery.of(context).size.width / 1.6,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.montserrat(
                    fontSize: 17, color: AppTheme.colorPrimary),
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.theappthat,
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context)!.actually,
                    style: GoogleFonts.montserrat(
                        color: AppTheme.colorPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context)!.helps,
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context)!.youtosave,
                  ),
                ],
              ),
            ),
          ),
          title: AppLocalizations.of(context)!.welltosnabbbbudget,
          image: _buildImage('assets/images/intro_two.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          bodyWidget: SizedBox(
            width: MediaQuery.of(context).size.width / 1.6,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.montserrat(
                    fontSize: 17, color: AppTheme.colorPrimary),
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.viewallyour,
                  ),
                  TextSpan(
                    text: " ${AppLocalizations.of(context)!.expense} ",
                    style: GoogleFonts.montserrat(
                        color: AppTheme.colorPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context)!.and,
                  ),
                  TextSpan(
                    text: "  ${AppLocalizations.of(context)!.income}",
                    style: GoogleFonts.montserrat(
                        color: AppTheme.colorPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "  ${AppLocalizations.of(context)!.report}",
                  ),
                ],
              ),
            ),
          ),
          title: AppLocalizations.of(context)!.stayontopofyourexpenese,
          image: _buildImage('assets/images/intro_one.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          bodyWidget: SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.montserrat(
                    fontSize: 17, color: AppTheme.colorPrimary),
                children: [
                  TextSpan(
                    text: "${AppLocalizations.of(context)!.analyzeyour} ",
                  ),
                  TextSpan(
                    text: "${AppLocalizations.of(context)!.finance} ",
                    style: GoogleFonts.montserrat(
                        color: AppTheme.colorPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context)!.withsimple,
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context)!.andeverytounderstand,
                  ),
                ],
              ),
            ),
          ),
          title: AppLocalizations.of(context)!.understandyourfinancialhabits,
          image: _buildImage('assets/images/intro_three.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      // skipFlex: 0,
      nextFlex: 0,
      skip: Text(
        AppLocalizations.of(context)!.skip,
        style: GoogleFonts.montserrat(color: AppTheme.colorPrimary),
      ),
      next: Icon(Icons.arrow_forward, color: AppTheme.colorPrimary),
      done: Text(AppLocalizations.of(context)!.done,
          style: TextStyle(
              fontWeight: FontWeight.w600, color: AppTheme.colorPrimary)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(30.0, 10.0),
        activeColor: Color(0xFF112949),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
