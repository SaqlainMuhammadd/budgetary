import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snab_budget/Screens/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../models/account.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  List<Account> accounts = []; // List to store accounts
  Account? selectedFromAccount;
  Account? selectedToAccount;
  TimeOfDay _selectedTime = TimeOfDay.now();
  String formatTime = "";
  String pathFile = "";
  DateTime _selectedDate = DateTime.now();
  bool isLoading = false;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    fetchAccounts();
  }

  void fetchAccounts() async {
    // Fetch accounts from Firebase Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("UserTransactions")
        .doc(userId)
        .collection("Accounts")
        .get();

    setState(() {
      accounts = querySnapshot.docs.map((doc) {
        String id = doc.id;
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        return Account.fromJson(data!, id);
      }).toList();
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null) {
      _selectedTime = pickedTime;
      formatTime = "${_selectedTime.hour}:${_selectedTime.minute}";
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _selectedDate = pickedDate;
      print(_selectedDate);
    }
  }

  // Future getImage(ImgSource source) async {
  //   var image = await ImagePickerGC.pickImage(
  //       enableCloseButton: true,
  //       closeIcon: const Icon(
  //         Icons.close,
  //         color: Colors.red,
  //         size: 12,
  //       ),
  //       context: context,
  //       source: source,
  //       barrierDismissible: true,
  //       cameraIcon: const Icon(
  //         Icons.camera_alt,
  //         color: Colors.red,
  //       ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
  //       cameraText: const Text(
  //         "From Camera",
  //         style: TextStyle(color: Colors.red),
  //       ),
  //       galleryText: const Text(
  //         "From Gallery",
  //         style: TextStyle(color: Colors.blue),
  //       ));
  //   setState(() {
  //   });
  // }

  void transferAmount() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedFromAccount == null || selectedToAccount == null) {
      return;
    }

    double transferAmount = double.parse(_amount.text);

    if (transferAmount > selectedFromAccount!.amount) {
      // Amount exceeds the balance of the "from" account
      return;
    }

    setState(() {
      isLoading = true;
    });
    String seletedFromId = selectedFromAccount!.id;
    if (selectedFromAccount!.id == "69") {
      seletedFromId = "Budgetary";
    }
    String seletedToId = selectedToAccount!.id;
    if (selectedToAccount!.id == "69") {
      seletedToId = "Budgetary";
    }
    try {
      // Subtract the amount from the "from" account
      double newFromAmount = selectedFromAccount!.amount - transferAmount;
      await FirebaseFirestore.instance
          .collection("UserTransactions")
          .doc(userId)
          .collection("Accounts")
          .doc(seletedFromId)
          .update({'amount': newFromAmount});

      // Add the amount to the "to" account
      double newToAmount = selectedToAccount!.amount + transferAmount;

      await FirebaseFirestore.instance
          .collection("UserTransactions")
          .doc(userId)
          .collection("Accounts")
          .doc(seletedToId)
          .update({'amount': newToAmount});

      // Reset the form and controllers
      _formKey.currentState!.reset();
      _amount.clear();
      _notes.clear();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        ModalRoute.withName('/'),
      );
      // Show a success message or navigate to a new screen
    } catch (error) {
      // Handle any errors that occur during the transfer
      print(error);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        child: Column(
          children: [
            Card(
                child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_rounded)),
                    ),
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.transfermoney}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: size.width / 8.5,
                  ),
                ],
              ),
            )),
            SizedBox(
              height: size.height / 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${AppLocalizations.of(context)!.transfervalue}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .pleaseenteravalidnumber;
                              }
                              if (value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .passwordmustbeatleast1digitlong;
                              }
                              return null;
                            },
                            controller: _amount,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(color: Colors.black),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              fillColor: Colors.black.withOpacity(0.2),
                              hintText: AppLocalizations.of(context)!.amount,
                              alignLabelWithHint: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        const Icon(Icons.attach_money, color: Color(0xff2EA6C1))
                            .pSymmetric(h: 16)
                      ],
                    ),
                    DropdownButton<Account>(
                      value: selectedFromAccount,
                      hint:
                          Text(AppLocalizations.of(context)!.selectacountfrom),
                      onChanged: (newValue) {
                        setState(() {
                          selectedFromAccount = newValue;
                        });
                      },
                      items: accounts.map((Account account) {
                        return DropdownMenuItem<Account>(
                          value: account,
                          child: Row(
                            children: [
                              Text(account.name),
                              const SizedBox(width: 10),
                              Text('${account.amount} ${account.currency}'),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    DropdownButton<Account>(
                      value: selectedToAccount,
                      hint: Text(AppLocalizations.of(context)!.selectacountto),
                      onChanged: (newValue) {
                        setState(() {
                          selectedToAccount = newValue;
                        });
                      },
                      items: accounts
                          .where((account) => account != selectedFromAccount)
                          .map((Account account) {
                        return DropdownMenuItem<Account>(
                          value: account,
                          child: Row(
                            children: [
                              Text(account.name),
                              const SizedBox(width: 10),
                              Text('${account.amount} ${account.currency}'),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDate(context),
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: TextEditingController(
                                  text:
                                      '  ${DateFormat.yMMMd().format(_selectedDate)}',
                                ),
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.date,
                                  prefix: Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: size.width / 3.3),
                        InkWell(
                          onTap: () => _selectTime(context),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.access_time),
                              const SizedBox(width: 15),
                              Text(
                                '${_selectedTime.hour}:${_selectedTime.minute}',
                                style: const TextStyle(
                                    fontSize: 20, color: Color(0xff2EA6C1)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.note_alt_outlined,
                          size: 35,
                        ).pOnly(right: 10),
                        Expanded(
                          child: TextFormField(
                            maxLines: 4,
                            controller: _notes,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(color: Colors.black),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              fillColor: Colors.black.withOpacity(0.2),
                              hintText: AppLocalizations.of(context)!.notes,
                              alignLabelWithHint: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    // Row(
                    //   children: [
                    //     // const Icon(
                    //     //   Icons.file_present_outlined,
                    //     //   size: 30,
                    //     // ),
                    //     // const SizedBox(
                    //     //   width: 20,
                    //     // ),
                    //     // ElevatedButton(
                    //     //     onPressed:() async{
                    //     //       var status = await Permission.photosAddOnly.request();
                    //     //       if(!status.isDenied){
                    //     //         getImage(ImgSource.Both);
                    //     //       }
                    //     //       },
                    //     //     child:
                    //     //         Text(AppLocalizations.of(context)!.addFile)),
                    //     SizedBox(
                    //         width: 200,
                    //         child: Text(
                    //           pathFile,
                    //           softWrap: true,
                    //         )),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: size.height / 20,
                    // ),
                    !isLoading
                        ? Center(
                            child: SizedBox(
                              width: size.width / 2,
                              child: ElevatedButton(
                                onPressed: transferAmount,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                child: Text(
                                    AppLocalizations.of(context)!.transfer),
                              ),
                            ),
                          )
                        : CircularProgressIndicator(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("${AppLocalizations.of(context)!.cancel}"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
