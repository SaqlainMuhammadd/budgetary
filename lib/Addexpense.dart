import 'package:budgetary_your_personal_finance_manager/Clipperr.dart';
import 'package:budgetary_your_personal_finance_manager/themeclass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddExpense_Screen extends StatefulWidget {
  const AddExpense_Screen({super.key});

  @override
  State<AddExpense_Screen> createState() => _AddExpense_ScreenState();
}

class _AddExpense_ScreenState extends State<AddExpense_Screen> {
  DateTime selectedDateTime = DateTime.now();

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
          ),
          Container(
            height: height * 0.35,
            width: width,
            color: Colors.transparent,
            child: CustomPaint(
              painter: adminclipper(),
            ),
          ),
          Center(
            child: Positioned(
              top: height * 0.05,
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.13,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: MythemeClass.whitecolor,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Text(
                    'Add Expense',
                    style: GoogleFonts.aBeeZee(
                        color: MythemeClass.whitecolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: MythemeClass.whitecolor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.18,
            left: width * 0.1,
            child: Container(
              height: height * 0.73,
              width: width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: MythemeClass.whitecolor),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: GoogleFonts.aBeeZee(
                          color: MythemeClass.black54color,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          hintText: 'Expense Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon:
                              const Icon(Icons.keyboard_arrow_down_rounded)),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Amount',
                      style: GoogleFonts.aBeeZee(
                          color: MythemeClass.black54color,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          hintText: 'Rs 1000',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon:
                              const Icon(Icons.keyboard_arrow_down_rounded)),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),

                    Text(
                      ' Date',
                      style: GoogleFonts.aBeeZee(
                          color: MythemeClass.black54color,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectDateTime(context);
                        });
                      },
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: MythemeClass.black54color)),
                        child: Center(
                          child: Text(
                            'Sat 15 Nov 2003',
                            style: GoogleFonts.aBeeZee(
                                color: MythemeClass.black54color,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () => _selectDateTime(context),
                    //   child: Text('Select Date and Time'),
                    // ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Invice',
                      style: GoogleFonts.aBeeZee(
                          color: MythemeClass.black54color,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.add,
                          color: MythemeClass.blackcolor,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        hintText: 'Add Invice',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              textStyle: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Add Expense",
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
