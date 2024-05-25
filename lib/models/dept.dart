// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Dept {
  String? id;
  String? status;
  int? amount;
  DateTime? date;
  DateTime? backDate;
  String? to;
  int? paidamount;
  String? imgUrl;
  String? note;
  String? type;

  Dept({
    this.id,
    this.status,
    this.amount,
    this.date,
    this.backDate,
    this.to,
    this.paidamount,
    this.imgUrl,
    this.note,
    this.type,
  });

  factory Dept.fromJson(Map<String, dynamic> json, String id) {
    return Dept(
      id: id,
      status: json['status'],
      amount: json['amount'],
      date: (json['date'] as Timestamp).toDate(),
      backDate: (json['backDate'] as Timestamp).toDate(),
      to: json['to'],
      paidamount: json['paidamount'],
      imgUrl: json['imgUrl'],
      type: json['type'],
      note: json['note'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'amount': amount,
      'date': date,
      'backDate': backDate,
      'to': to,
      'paidamount': paidamount,
      'imgUrl': imgUrl,
      'type': type,
      'note': note,
    };
  }
}
