// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_element, no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snab_budget/Screens/auth/forgot.dart';
import 'package:snab_budget/Screens/auth/verification.dart';
import 'package:snab_budget/apis/controller/login_signup_controller.dart';
import 'package:snab_budget/apis/model/signup_model.dart';
import 'package:snab_budget/clipper/login_clipper.dart';
import 'package:snab_budget/models/registerviewmodel.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/spinkit.dart';
import '../../models/loginviewmodel.dart';
import '../home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obsCheck = false;
  bool isLogin = true;
  bool islodding = false;

  String errMsg = "";
  //? Login Work Start
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool isLoggingIn = false;
  final LoginViewModel _loginVM = LoginViewModel();
  final RegisterViewModel _registerVM = RegisterViewModel();
  //! # 2
  //? Sign Up Work Start
  TextEditingController mEmail = TextEditingController();
  TextEditingController mName = TextEditingController();
  TextEditingController mPassword = TextEditingController();
  TextEditingController mPhoneNo = TextEditingController();

  final FocusNode mEmailFocusNode = FocusNode();
  final FocusNode mPasswordFocusNode = FocusNode();
  final FocusNode mNameFocusNode = FocusNode();
  final FocusNode mPhoneNumberFocusNode = FocusNode();

  //* For Password Show Or Not
  bool obscureText = true;

  Widget setLoginUnderLineColor() {
    if (isLogin == true) {
      return Container(
        width: 50,
        height: 2,
        color: AppTheme.colorPrimary,
      );
    } else {
      return Container(
        width: 20,
        height: 2,
        color: AppTheme.colorWhite,
      );
    }
  }

//* For Password Show Or Not
  bool _obscureText = true;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //* Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //* For Password Sufix icon color
  Color setIconColor(var truee) {
    if (true == truee) {
      return AppTheme.colorHint;
    } else {
      return AppTheme.colorPrimary;
    }
  }

  //! Set Sign Up Button Underline Color
  Widget setSignUpUnderLineColor() {
    if (isLogin == false) {
      return Container(
        width: 60,
        height: 2,
        color: AppTheme.colorPrimary,
      );
    } else {
      return Container(
        width: 20,
        height: 2,
        color: AppTheme.colorWhite,
      );
    }
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return AppLocalizations.of(context)!.pleaseenteravalidemailaddress;
    }
    return "null";
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return "null";
  }

  @override
  void initState() {
    Get.put(LoginSignUPController());
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        textOpacity = true;
      });
    });

    super.initState();
  }

  String message = "";
  // login(context, String email, String password) async {
  //   changeLodingStatus(true);
  //   try {
  //     print("$email efn $password");
  //     final userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     if (userCredential.user != null) {
  //       changeLodingStatus(false);
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (ctx) => const HomeScreen()),
  //           (Route<dynamic> route) => false);
  //     }
  //     print("-----------------${userCredential.user}");
  //   } on FirebaseAuthException catch (e) {
  //     message = e.code;
  //     Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //     );
  //     changeLodingStatus(false);
  //   } catch (e) {
  //     changeLodingStatus(false);
  //     Fluttertoast.showToast(
  //       msg: e.toString(),
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //     );
  //     print(e);
  //   }
  // }

  changeLodingStatus(bool v) {
    setState(() {
      islodding = v;
    });
  }

  bool textOpacity = false;
  bool singUpAnimation = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                height: height,
                width: width,
                color: AppTheme.colorWhite,
                child: Form(
                  key: _formKey,
                  child: Stack(children: [
                    ClipPath(
                      clipper: LoginClipper(),
                      child: Container(
                        height: height * 0.45,
                        color: AppTheme.colorPrimary,
                        width: width,
                        child: Center(
                          child: SizedBox(
                            height: height * 0.2,
                            width: width * 0.4,
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.contain,
                              height: height * 0.6,
                              width: width * 0.6,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: height * 0.15, right: width * 0.03),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                            height: height * 0.05,
                            width: width * 0.5,
                            child: Row(children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isLogin = true;
                                    setLoginUnderLineColor();
                                    setSignUpUnderLineColor();
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    width: width * 0.22,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            AppLocalizations.of(context)!
                                                .signin,
                                            style: TextStyle(
                                                fontSize: width * 0.04,
                                                color: isLogin == true
                                                    ? AppTheme.colorPrimary
                                                    : Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: setLoginUnderLineColor(),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    singUpAnimation = true;
                                    isLogin = false;
                                    setLoginUnderLineColor();
                                    setSignUpUnderLineColor();
                                  });
                                },
                                child: SizedBox(
                                  width: width * 0.22,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(AppLocalizations.of(context)!.signup,
                                          style: TextStyle(
                                              fontSize: width * 0.035,
                                              color: isLogin == false
                                                  ? AppTheme.colorPrimary
                                                  : Colors.grey,
                                              fontWeight: FontWeight.bold)),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: setSignUpUnderLineColor(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ])),
                      ),
                    ),
                    Center(
                      child: isLogin == true
                          ? SizedBox(
                              height: height * 0.17,
                              width: width * 0.85,
                              child: Column(
                                children: [
                                  AnimatedOpacity(
                                    duration: Duration(seconds: 2),
                                    curve: Curves.easeIn,
                                    opacity: textOpacity == false ? 0 : 1,
                                    child: AnimatedContainer(
                                      padding: EdgeInsets.only(
                                        top: 50,
                                        left: textOpacity == false ? 100 : 20,
                                      ),
                                      duration: Duration(seconds: 2),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          AppLocalizations.of(context)!.welcome,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              color: AppTheme.colorPrimary,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    duration: Duration(seconds: 2),
                                    curve: Curves.easeIn,
                                    opacity: textOpacity == false ? 0 : 1,
                                    child: AnimatedContainer(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        left: textOpacity == false ? 100 : 20,
                                      ),
                                      duration: Duration(seconds: 2),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${AppLocalizations.of(context)!.enteryouremailaddress} \n${AppLocalizations.of(context)!.andpasswordforlogin}",
                                          style: GoogleFonts.montserrat(
                                              color: AppTheme.colorPrimary,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              height: height * 0.17,
                              width: width * 0.85,
                              child: Column(
                                children: [
                                  AnimatedOpacity(
                                    duration: Duration(seconds: 2),
                                    opacity: singUpAnimation == false ? 0 : 1,
                                    child: AnimatedContainer(
                                      padding: EdgeInsets.only(
                                          top: 30,
                                          left: singUpAnimation == false
                                              ? 100
                                              : 20),
                                      duration: Duration(seconds: 2),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .hellodear,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 25,
                                              color: AppTheme.colorPrimary,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    duration: Duration(seconds: 2),
                                    opacity: singUpAnimation == false ? 0 : 1,
                                    child: AnimatedContainer(
                                      duration: Duration(seconds: 2),
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          left: singUpAnimation == false
                                              ? 100
                                              : 20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${AppLocalizations.of(context)!.enteryourinformmationbelow} \n${AppLocalizations.of(context)!.tocreateanaccount}",
                                          style: GoogleFonts.montserrat(
                                              color: AppTheme.colorPrimary,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: isLogin == true ? height * 0.35 : height * 0.4),
                      child: Center(
                        child: isLogin == true
                            ? SizedBox(
                                height: height * 0.3,
                                width: width * 0.85,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AnimatedContainer(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 30),
                                      curve: Curves.bounceOut,
                                      duration: Duration(seconds: 2),
                                      width: textOpacity == false
                                          ? 0
                                          : MediaQuery.of(context).size.width,
                                      child: Theme(
                                        data: ThemeData(
                                          primaryColor: AppTheme.colorPrimary,
                                          splashColor:
                                              AppTheme.colorPrimaryDark,
                                        ),
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          cursorColor: AppTheme.colorPrimary,
                                          focusNode: emailFocusNode,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(
                                              color: AppTheme.colorPrimary),
                                          onFieldSubmitted: (term) {
                                            _fieldFocusChange(
                                                context,
                                                emailFocusNode,
                                                passwordFocusNode);
                                          },
                                          controller: userController,
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)!
                                                    .emailaddress,
                                            labelStyle: GoogleFonts.montserrat(
                                                color: AppTheme
                                                    .colorPlaceholderText),
                                          ),
                                        ),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      duration: Duration(seconds: 2),
                                      width: textOpacity == false
                                          ? 0
                                          : MediaQuery.of(context).size.width,
                                      curve: Curves.bounceOut,
                                      child: Theme(
                                        data: ThemeData(
                                          primaryColor: AppTheme.colorPrimary,
                                          splashColor:
                                              AppTheme.colorPrimaryDark,
                                        ),
                                        child: TextFormField(
                                          cursorColor: AppTheme.colorPrimary,
                                          style: TextStyle(
                                              color: AppTheme.colorPrimary),
                                          obscureText: _obscureText,
                                          focusNode: passwordFocusNode,
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)!
                                                    .enteryourpassword,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obscureText
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                size: 15,
                                                color:
                                                    setIconColor(_obscureText),
                                              ),
                                              onPressed: () {
                                                _toggle();
                                              },
                                            ),
                                          ),
                                          controller: passwordController,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: width * 0.05),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgitPassword(),
                                                ));
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .forgetpassword,
                                            style: GoogleFonts.montserrat(
                                                color: AppTheme.colorPrimary),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                height: height * 0.35,
                                width: width * 0.85,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AnimatedContainer(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      duration: Duration(seconds: 2),
                                      width: textOpacity == false
                                          ? 0
                                          : MediaQuery.of(context).size.width,
                                      curve: Curves.bounceOut,
                                      child: Theme(
                                        data: ThemeData(
                                          primaryColor: AppTheme.colorPrimary,
                                          splashColor:
                                              AppTheme.colorPrimaryDark,
                                        ),
                                        child: TextFormField(
                                          cursorColor: AppTheme.colorPrimary,
                                          style: TextStyle(
                                              color: AppTheme.colorPrimary),
                                          focusNode: mNameFocusNode,
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)!
                                                    .fullname,
                                          ),
                                          controller: mName,
                                        ),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 30),
                                      curve: Curves.bounceOut,
                                      duration: Duration(seconds: 2),
                                      width: textOpacity == false
                                          ? 0
                                          : MediaQuery.of(context).size.width,
                                      child: Theme(
                                        data: ThemeData(
                                          primaryColor: AppTheme.colorPrimary,
                                          splashColor:
                                              AppTheme.colorPrimaryDark,
                                        ),
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          cursorColor: AppTheme.colorPrimary,
                                          focusNode: mEmailFocusNode,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(
                                              color: AppTheme.colorPrimary),
                                          onFieldSubmitted: (term) {
                                            _fieldFocusChange(
                                                context,
                                                emailFocusNode,
                                                passwordFocusNode);
                                          },
                                          controller: mEmail,
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)!
                                                    .emailaddress,
                                            labelStyle: GoogleFonts.montserrat(
                                                color: AppTheme
                                                    .colorPlaceholderText),
                                          ),
                                        ),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      duration: Duration(seconds: 2),
                                      width: textOpacity == false
                                          ? 0
                                          : MediaQuery.of(context).size.width,
                                      curve: Curves.bounceOut,
                                      child: Theme(
                                        data: ThemeData(
                                          primaryColor: AppTheme.colorPrimary,
                                          splashColor:
                                              AppTheme.colorPrimaryDark,
                                        ),
                                        child: TextFormField(
                                          cursorColor: AppTheme.colorPrimary,
                                          style: TextStyle(
                                              color: AppTheme.colorPrimary),
                                          obscureText: _obscureText,
                                          focusNode: mPasswordFocusNode,
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)!
                                                    .enteryourpassword,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obscureText
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                size: 15,
                                                color:
                                                    setIconColor(_obscureText),
                                              ),
                                              onPressed: () {
                                                _toggle();
                                              },
                                            ),
                                          ),
                                          controller: mPassword,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    isLogin == true
                        ? Padding(
                            padding: EdgeInsets.only(bottom: height * 0.05),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: isLoggingIn
                                    ? null
                                    : () async {
                                        if (_formKey.currentState!.validate()) {
                                          changeLodingStatus(true);
                                          Map<String, dynamic> map = {
                                            "email": userController.text,
                                            "password": passwordController.text
                                          };
                                          LoginSignUPController.to
                                              .login(map, context)
                                              .then((value) {
                                            if (value) {
                                              changeLodingStatus(false);
                                            } else {
                                              changeLodingStatus(false);
                                            }
                                          });
                                        }
                                      },
                                child: Container(
                                  height: height * 0.07,
                                  width: width * 0.6,
                                  decoration: BoxDecoration(
                                      color: AppTheme.colorPrimary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    AppLocalizations.of(context)!.signin,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(bottom: height * 0.03),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: islodding
                                    ? null
                                    : () async {
                                        if (_formKey.currentState!.validate()) {
                                          changeLodingStatus(true);

                                          SignupModel model = SignupModel(
                                              email: mEmail.text.trim(),
                                              name: mName.text.trim(),
                                              password: mPassword.text.trim());
                                          LoginSignUPController.to
                                              .signUp(model)
                                              .then((value) {
                                            changeLodingStatus(false);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        LoginScreen()));
                                          });
                                        }
                                      },
                                child: Container(
                                  height: height * 0.07,
                                  width: width * 0.6,
                                  decoration: BoxDecoration(
                                      color: AppTheme.colorPrimary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    AppLocalizations.of(context)!.signin,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                            ),
                          ),
                    islodding == true
                        ? Container(
                            height: height,
                            width: width,
                            color: AppTheme.colorPrimary.withOpacity(0.5),
                            child: Padding(
                              padding: EdgeInsets.only(top: height * 0.4),
                              child: Center(
                                child: SizedBox(
                                  height: height * 0.1,
                                  width: width * 0.2,
                                  child: SpinKit.loadSpinkit,
                                ),
                              ),
                            ),
                          )
                          
                        : SizedBox()
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
