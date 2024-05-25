import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart' as p;
import 'package:pdf/widgets.dart' as pw;
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/apis/model/add_debit_model.dart';
import 'package:snab_budget/apis/model/user_wallet_model.dart';
import 'package:snab_budget/models/account.dart';
import 'package:snab_budget/models/dept.dart';
import 'package:snab_budget/models/get_transaction_type_model.dart';
import 'package:snab_budget/models/transaction.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:snab_budget/apis/model/user_wallet_model.dart' as wal;

class PDFPreview extends StatefulWidget {
  bool expensestatus;
  bool incomestatus;
  bool derbitCreditstatus;
  bool accountstatus;
  String name;
  String email;
  List<GetTransActionTypeData> incomeTransactions;
  List<GetTransActionTypeData> expanceTransactions;
  List<wal.Data> accountlist;
  List<DebitCreditData> debitcreditlist;
  @override
  PDFPreview(
      {super.key,
      required this.email,
      required this.name,
      required this.accountstatus,
      required this.derbitCreditstatus,
      required this.expensestatus,
      required this.incomestatus,
      required this.accountlist,
      required this.debitcreditlist,
      required this.expanceTransactions,
      required this.incomeTransactions});

  @override
  State<PDFPreview> createState() => _PDFPreviewState();
}

class _PDFPreviewState extends State<PDFPreview> {
  List<pw.Widget> listofPDF = [];
  List<pw.Widget> listofExpencePDF = [];
  List<pw.Widget> listofIncomePDF = [];
  List<pw.Widget> listofCRDRPDF = [];
  List<pw.Widget> listofFinancil = [];
  List<String> listofdays = [];
  double total = 0.0;
  double totale = 0.0;
  double debitTotal = 0;

  generatelist() {
    listofdays.clear();
    listofFinancil.clear();
    listofPDF.clear();
    listofExpencePDF.clear();
    listofIncomePDF.clear();
    listofCRDRPDF.clear();
/////////

    DateTime currentDate = DateTime.now();
    DateTime startingdate = DateTime.now();
    print('starting Date: ${startingdate.toString()}');

    currentDate.subtract(const Duration(days: 1));
    listofdays.add(startingdate.toString().substring(0, 10));
    for (int i = 01; i < int.parse(currentDate.day.toString()); i++) {
      startingdate = startingdate.subtract(const Duration(days: 1));
      listofdays.add(startingdate.toString().substring(0, 10));
    }
    // print("list of days $listofdays");
    // ///////////////////////
    listofPDF.add(
      pw.Header(
        level: 0,
        child: pw.Text(
          "BUDGETARY",
          style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: p.PdfColor.fromHex("#132b4b")),
        ),
      ),
    );
    listofPDF.add(pw.Column(children: [
      pw.Row(children: [
        pw.Text(
          'Name:    ',
          style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold,
              color: p.PdfColor.fromHex("#132b4b")),
        ),
        pw.Text(
          DashBoardController.to.userNAme.toUpperCase(),
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.normal,
              color: p.PdfColor.fromHex("#132b4b")),
        ),
      ]),
      pw.Row(children: [
        pw.Text(
          'Email:    ',
          style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold,
              color: p.PdfColor.fromHex("#132b4b")),
        ),
        pw.Text(
          DashBoardController.to.email.toUpperCase(),
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.normal,
              color: p.PdfColor.fromHex("#132b4b")),
        ),
      ])
    ]));
    if (widget.incomestatus && widget.incomeTransactions.isNotEmpty) {
      listofIncomePDF.add(pw.SizedBox(
        height: 50,
      ));
      listofIncomePDF.add(pw.Center(
        child: pw.Text(
          'Income Transactions',
          style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: p.PdfColor.fromHex("#132b4b")),
        ),
      ));
      listofIncomePDF.add(pw.SizedBox(
        height: 15,
      ));
      listofIncomePDF.add(pw.Table(children: [
        pw.TableRow(children: [
          pw.Container(
              height: 50,
              color: p.PdfColor.fromHex("#132b4b"),
              child: pw.Row(children: [
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
                  width: 72,
                  child: pw.Center(
                    child: pw.Text(
                      'Date',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
                  width: 122,
                  child: pw.Center(
                    child: pw.Text(
                      'Description',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
                  width: 78,
                  child: pw.Center(
                    child: pw.Text(
                      'Category',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
                pw.Column(children: [
                  pw.Container(
                    decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(color: p.PdfColors.grey, width: 3)),
                    width: 102,
                    height: 30,
                    child: pw.Center(
                      child: pw.Text(
                        'Payment',
                        style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColors.white),
                      ),
                    ),
                  ),
                  pw.Row(children: [
                    pw.Container(
                      decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: p.PdfColors.grey, width: 3)),
                      width: 51,
                      height: 20,
                      child: pw.Center(
                        child: pw.Text(
                          'Cash',
                          style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: p.PdfColors.white),
                        ),
                      ),
                    ),
                    pw.Container(
                      decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: p.PdfColors.grey, width: 3)),
                      width: 51,
                      height: 20,
                      child: pw.Center(
                        child: pw.Text(
                          'Card',
                          style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: p.PdfColors.white),
                        ),
                      ),
                    ),
                  ])
                ]),
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
                  width: 53,
                  child: pw.Center(
                    child: pw.Text(
                      'Total',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border:
                          pw.Border.all(color: p.PdfColors.grey, width: 2.5)),
                  width: 53,
                  child: pw.Center(
                    child: pw.Text(
                      'Balance',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
              ]))
        ])
      ]));
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
      for (var element in widget.incomeTransactions) {
        total = total + element.amount!;
        listofIncomePDF.add(
          pw.Table(
              border: pw.TableBorder.all(color: p.PdfColors.grey, width: 2),
              children: [
                pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.SizedBox(
                        width: 80,
                        height: 20,
                        child: pw.Center(
                          child: pw.Text(
                            element.dateTime.toString().substring(0, 9),
                            style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.normal,
                                color: p.PdfColor.fromHex("#132b4b")),
                          ),
                        ),
                      ),
                      pw.SizedBox(
                        width: 140,
                        height: 20,
                        child: pw.Center(
                          child: pw.Text(
                            element.note.toString(),
                            style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.normal,
                                color: p.PdfColor.fromHex("#132b4b")),
                          ),
                        ),
                      ),
                      pw.SizedBox(
                        width: 85,
                        height: 20,
                        child: pw.Center(
                          child: pw.Text(
                            element.category!.contains("TransactionCat")
                                ? element.category.toString().substring(15)
                                : element.category.toString(),
                            style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.normal,
                                color: p.PdfColor.fromHex("#132b4b")),
                          ),
                        ),
                      ),
                      pw.SizedBox(
                          width: 60,
                          height: 20,
                          child: pw.Center(
                            child: pw.Text(
                              element.amount.toString(),
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.normal,
                                  color: p.PdfColor.fromHex("#132b4b")),
                            ),
                          )),
                      pw.SizedBox(
                          width: 60,
                          height: 20,
                          child: pw.Center(
                            child: pw.Text(
                              element.amount.toString(),
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.normal,
                                  color: p.PdfColor.fromHex("#132b4b")),
                            ),
                          )),
                      ////
                      pw.SizedBox(
                          width: 60,
                          height: 20,
                          child: pw.Center(
                            child: pw.Text(
                              element.amount.toString(),
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.normal,
                                  color: p.PdfColor.fromHex("#132b4b")),
                            ),
                          )),

                      /////
                      pw.SizedBox(
                          width: 60,
                          height: 20,
                          child: pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                              total.toString(),
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.normal,
                                  color: p.PdfColor.fromHex("#132b4b")),
                            ),
                          )),
                    ])
              ]),
          // pw.Column(children: [
          //   pw.Container(
          //       height: 25,
          //       child: pw.Row(
          //         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
          //         children: [

          //         ],
          //       )),
          //   pw.SizedBox(
          //     height: 10,
          //   ),
          // ]
          // )
        );
      }
    }

    listofIncomePDF.add(pw.Table(
        border: pw.TableBorder.all(color: p.PdfColors.grey, width: 2),
        children: [
          pw.TableRow(children: [
            pw.Container(
              height: 20,
              color: p.PdfColors.grey200,
              child: pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Total Income",
                  style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      color: p.PdfColors.black),
                ),
              ),
            ),
            pw.Container(
                height: 20,
                color: p.PdfColors.grey200,
                child: pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    "$total  ${DashBoardController.to.curency}",
                    style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        color: p.PdfColors.black),
                  ),
                )),
          ]),
        ]));

    if (widget.expensestatus && widget.expanceTransactions.isNotEmpty) {
      listofExpencePDF.add(pw.SizedBox(
        height: 50,
      ));
      listofExpencePDF.add(pw.Center(
        child: pw.Text(
          'Expense Transactions',
          style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: p.PdfColor.fromHex("#132b4b")),
        ),
      ));
      listofExpencePDF.add(pw.SizedBox(
        height: 15,
      ));
      listofExpencePDF.add(pw.Table(children: [
        pw.TableRow(children: [
          pw.Container(
              height: 50,
              color: p.PdfColor.fromHex("#132b4b"),
              child: pw.Row(children: [
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
                  width: 72,
                  child: pw.Center(
                    child: pw.Text(
                      'Date',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
                  width: 122,
                  child: pw.Center(
                    child: pw.Text(
                      'Description',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
                  width: 78,
                  child: pw.Center(
                    child: pw.Text(
                      'Category',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
                pw.Column(children: [
                  pw.Container(
                    decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(color: p.PdfColors.grey, width: 3)),
                    width: 102,
                    height: 30,
                    child: pw.Center(
                      child: pw.Text(
                        'Payment',
                        style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColors.white),
                      ),
                    ),
                  ),
                  pw.Row(children: [
                    pw.Container(
                      decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: p.PdfColors.grey, width: 3)),
                      width: 51,
                      height: 20,
                      child: pw.Center(
                        child: pw.Text(
                          'Cash',
                          style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: p.PdfColors.white),
                        ),
                      ),
                    ),
                    pw.Container(
                      decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: p.PdfColors.grey, width: 3)),
                      width: 51,
                      height: 20,
                      child: pw.Center(
                        child: pw.Text(
                          'Card',
                          style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: p.PdfColors.white),
                        ),
                      ),
                    ),
                  ])
                ]),
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
                  width: 53,
                  child: pw.Center(
                    child: pw.Text(
                      'Total',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border:
                          pw.Border.all(color: p.PdfColors.grey, width: 2.5)),
                  width: 53,
                  child: pw.Center(
                    child: pw.Text(
                      'Balance',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
              ]))
        ])
      ]));

      for (var element in widget.expanceTransactions) {
        totale = totale + element.amount!;
        listofExpencePDF.add(
          pw.Table(
              border: pw.TableBorder.all(color: p.PdfColors.grey, width: 2),
              children: [
                pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.SizedBox(
                        width: 80,
                        height: 20,
                        child: pw.Center(
                          child: pw.Text(
                            element.dateTime.toString().substring(0, 10),
                            style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.normal,
                                color: p.PdfColor.fromHex("#132b4b")),
                          ),
                        ),
                      ),
                      pw.SizedBox(
                        width: 140,
                        height: 20,
                        child: pw.Center(
                          child: pw.Text(
                            element.note.toString(),
                            style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.normal,
                                color: p.PdfColor.fromHex("#132b4b")),
                          ),
                        ),
                      ),
                      pw.SizedBox(
                        width: 85,
                        height: 20,
                        child: pw.Center(
                          child: pw.Text(
                            element.category!.contains("TransactionCat")
                                ? element.category.toString().substring(15)
                                : element.category.toString(),
                            style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.normal,
                                color: p.PdfColor.fromHex("#132b4b")),
                          ),
                        ),
                      ),
                      pw.SizedBox(
                          width: 60,
                          height: 20,
                          child: pw.Center(
                            child: pw.Text(
                              element.amount.toString(),
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.normal,
                                  color: p.PdfColor.fromHex("#132b4b")),
                            ),
                          )),

                      pw.SizedBox(
                          width: 60,
                          height: 20,
                          child: pw.Center(
                            child: pw.Text(
                              element.amount.toString(),
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.normal,
                                  color: p.PdfColor.fromHex("#132b4b")),
                            ),
                          )),

                      ////
                      pw.SizedBox(
                          width: 60,
                          height: 20,
                          child: pw.Center(
                            child: pw.Text(
                              element.amount.toString(),
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.normal,
                                  color: p.PdfColor.fromHex("#132b4b")),
                            ),
                          )),

                      /////
                      pw.SizedBox(
                          width: 60,
                          height: 20,
                          child: pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                              totale.toString(),
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.normal,
                                  color: p.PdfColor.fromHex("#132b4b")),
                            ),
                          )),
                    ])
              ]),
        );
      }
    }

    listofExpencePDF.add(pw.Table(
        border: pw.TableBorder.all(color: p.PdfColors.grey, width: 2),
        children: [
          pw.TableRow(children: [
            pw.Container(
              height: 20,
              color: p.PdfColors.grey200,
              child: pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Total Expense",
                  style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      color: p.PdfColors.black),
                ),
              ),
            ),
            pw.Container(
                height: 20,
                color: p.PdfColors.grey200,
                child: pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    "$totale  ${DashBoardController.to.curency}",
                    style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        color: p.PdfColors.black),
                  ),
                )),
          ]),
        ]));

    print(widget.accountstatus);
    if (widget.accountstatus) {
      listofPDF.add(pw.SizedBox(
        height: 50,
      ));
      listofPDF.add(pw.Center(
        child: pw.Text(
          'Accounts Information',
          style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: p.PdfColor.fromHex("#132b4b")),
        ),
      ));
      listofPDF.add(pw.SizedBox(
        height: 15,
      ));
      listofPDF.add(pw.Header(
          level: 0,
          child: pw.Container(
              height: 50,
              color: p.PdfColor.fromHex("#132b4b"),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  pw.SizedBox(
                    width: 160,
                    child: pw.Center(
                      child: pw.Text(
                        'Account Id',
                        style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColors.white),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: 100,
                    child: pw.Center(
                      child: pw.Text(
                        'Amount',
                        style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColors.white),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: 100,
                    child: pw.Center(
                      child: pw.Text(
                        'Name',
                        style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColors.white),
                      ),
                    ),
                  ),
                ],
              ))));
      for (var element in widget.accountlist) {
        listofPDF.add(pw.Column(children: [
          pw.Container(
              height: 25,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  pw.SizedBox(
                    width: 180,
                    height: 50,
                    child: pw.Center(
                      child: pw.Text(
                        element.walletId.toString(),
                        style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColor.fromHex("#132b4b")),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: 180,
                    height: 50,
                    child: pw.Center(
                      child: pw.Text(
                        "${element.amount.toString()} ${DashBoardController.to.curency}",
                        style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColor.fromHex("#132b4b")),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                      width: 180,
                      height: 50,
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20),
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            element.name.toString(),
                            style: pw.TextStyle(
                                fontSize: 15,
                                fontWeight: pw.FontWeight.bold,
                                color: p.PdfColor.fromHex("#132b4b")),
                          ),
                        ),
                      )),
                ],
              )),
          pw.SizedBox(
            height: 10,
          )
        ]));
      }
    }

    if (widget.derbitCreditstatus) {
      listofCRDRPDF.add(pw.SizedBox(
        height: 50,
      ));
      listofCRDRPDF.add(pw.Center(
        child: pw.Text(
          'Credit/Debit Transactions',
          style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: p.PdfColor.fromHex("#132b4b")),
        ),
      ));
      listofCRDRPDF.add(pw.SizedBox(
        height: 15,
      ));
      listofCRDRPDF.add(pw.Header(
          level: 0,
          child: pw.Container(
              height: 50,
              color: p.PdfColor.fromHex("#132b4b"),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.SizedBox(
                    width: 90,
                    child: pw.Center(
                      child: pw.Text(
                        'Type',
                        style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColors.white),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: 90,
                    child: pw.Center(
                      child: pw.Text(
                        'Date',
                        style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColors.white),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: 90,
                    child: pw.Center(
                      child: pw.Text(
                        'Amount',
                        style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColors.white),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: 90,
                    child: pw.Center(
                      child: pw.Text(
                        'Name',
                        style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColors.white),
                      ),
                    ),
                  ),
                ],
              ))));
      for (var element in widget.debitcreditlist) {
        listofCRDRPDF.add(pw.Column(children: [
          pw.Container(
              height: 25,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  pw.SizedBox(
                    width: 90,
                    child: pw.Center(
                      child: pw.Text(
                        element.type.toString(),
                        style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColor.fromHex("#132b4b")),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: 90,
                    child: pw.Center(
                      child: pw.Text(
                        element.date.toString().substring(0, 10),
                        style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColor.fromHex("#132b4b")),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: 90,
                    child: pw.Center(
                      child: pw.Text(
                        "${element.amount.toString()} ${DashBoardController.to.curency}",
                        style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: p.PdfColor.fromHex("#132b4b")),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                      width: 90,
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20),
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            element.person.toString(),
                            style: pw.TextStyle(
                                fontSize: 15,
                                fontWeight: pw.FontWeight.bold,
                                color: p.PdfColor.fromHex("#132b4b")),
                          ),
                        ),
                      )),
                ],
              )),
          pw.SizedBox(
            height: 10,
          )
        ]));
        debitTotal += element.amount!;
      }
    }

    listofCRDRPDF.add(pw.Container(
        height: 40,
        color: p.PdfColor.fromHex("#132b4b"),
        child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              pw.Text(
                "Total CR/DR",
                style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                    color: p.PdfColors.white),
              ),
              pw.Text(
                "${debitTotal / 3} ${DashBoardController.to.curency}",
                style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                    color: p.PdfColors.white),
              ),
            ])));

    if (widget.expensestatus &&
        widget.incomestatus &&
        widget.expanceTransactions.isNotEmpty &&
        widget.incomeTransactions.isNotEmpty) {
      listofFinancil.add(pw.SizedBox(
        height: 50,
      ));
      listofFinancil.add(
        pw.Center(
          child: pw.Text(
            'Financil Snapshot',
            style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
                color: p.PdfColor.fromHex("#132b4b")),
          ),
        ),
      );
      listofFinancil.add(pw.SizedBox(
        height: 15,
      ));
      listofFinancil.add(pw.Container(
          height: 50,
          color: p.PdfColor.fromHex("#132b4b"),
          child: pw.Row(children: [
            pw.Container(
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
              width: 130,
              child: pw.Center(
                child: pw.Text(
                  'Date',
                  style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      color: p.PdfColors.white),
                ),
              ),
            ),
            pw.Column(children: [
              pw.Row(children: [
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
                  width: 110,
                  height: 25,
                  child: pw.Center(
                    child: pw.Text(
                      'Cash Inflows',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
                  width: 110,
                  height: 25,
                  child: pw.Center(
                    child: pw.Text(
                      'Cash Outflows',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
              ]),
              pw.Row(children: [
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
                  width: 110,
                  height: 25,
                  child: pw.Center(
                    child: pw.Text(
                      'Income',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
                pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
                  width: 110,
                  height: 25,
                  child: pw.Center(
                    child: pw.Text(
                      'Expense',
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: p.PdfColors.white),
                    ),
                  ),
                ),
              ])
            ]),
            pw.Container(
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: p.PdfColors.grey, width: 3)),
              width: 130,
              child: pw.Center(
                child: pw.Text(
                  'Closing Balance',
                  style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      color: p.PdfColors.white),
                ),
              ),
            ),
          ])));

      // listofFinancil.add();
    }
  }

  DateTime getPreviousDateOfCurrentMonth(DateTime currentDate) {
    int currentDay = currentDate.day;
    int previousMonthDays = currentDay;
    return currentDate.subtract(Duration(days: previousMonthDays));
  }

  Uint8List? savelist;
  Future<Uint8List> createPDF(List<Transaction> transactions) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return listofPDF;
        },
      ),
    );

    if (widget.incomestatus) {
      pdf.addPage(pw.MultiPage(
        build: (context) {
          return listofIncomePDF;
        },
      ));
    }
    if (widget.expensestatus) {
      pdf.addPage(pw.MultiPage(
        build: (context) {
          return listofExpencePDF;
        },
      ));
    }

    if (widget.expensestatus && widget.incomestatus) {
      pdf.addPage(pw.MultiPage(
        build: (context) {
          return listofFinancil;
        },
      ));
    }
    if (widget.derbitCreditstatus) {
      pdf.addPage(pw.MultiPage(
        build: (context) {
          return listofCRDRPDF;
        },
      ));
    }

    savelist = await pdf.save();
    // print("savelist ${savelist}");
    return savelist!;
  }

  Future<void> saveToDevice(Uint8List savelist) async {
    bool granted = await Permission.storage.request().isGranted;
    print("dsd");
    if (!granted) {
      granted = await Permission.storage.request().isGranted;
    }
    print("sf");
    if (granted) {
      final rand = Random().nextInt(10000000);
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String path = "$dir/SnabBudget$rand.pdf";
      final File file = File(path);
      print("dfghst");
      try {
        await file.writeAsBytes(savelist);
        print("PDF saved successfully.");
      } catch (e) {
        print("Error saving PDF: $e");
      }
    } else {
      print("Permission not granted. Unable to save PDF.");
    }
  }

  PrintingInfo? info;
  Future init() async {
    final i = await Printing.info();
    setState(() {
      info = i;
    });
  }

  @override
  void initState() {
    Get.put(DashBoardController());
    init();
    generatelist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
        actions: [
          PdfPreviewAction(
              icon: const Icon(Icons.save_alt_rounded),
              onPressed: (context, build, pageFormat) async {
                print("object");
                await saveToDevice(savelist!);
                print("fda");
              })
        ],
        allowPrinting: false,
        allowSharing: true,
        canChangePageFormat: false,
        canChangeOrientation: false,
        build: (format) => createPDF(TransactionController.to.transactions));
  }
}
