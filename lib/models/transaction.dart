import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionType { income, expense }

enum TransactionCat {
  travelling,
  shopping,
  others,
  finance,
  income,
  pets,
  transport,
  home,
  health,
  family,
  foodDrink
}

class Transaction {
  final String id;
  final String name;
  final String time;
  final DateTime date;
  final String imgUrl;
  final String fileUrl;
  String mainFileUrl;
  String note;
  final TransactionType type;
  final String category;
  final int amount;
  String status;

  Transaction({
    required this.id,
    required this.name,
    required this.mainFileUrl,
    required this.time,
    required this.date,
    required this.imgUrl,
    required this.fileUrl,
    required this.type,
    required this.note,
    required this.category,
    required this.amount,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json, String id) {
    final TransactionType type = TransactionType.values.firstWhere(
      (value) => value.toString() == json['type'],
      orElse: () => TransactionType.expense,
    );

    return Transaction(
      id: id,
      name: json['name'],
      time: json['time'].toString(),
      //  date: DateTime.parse(json['date']),
      date: (json['date'] as Timestamp).toDate(),
      imgUrl: json['imgUrl'],
      type: type,
      note: json['note'] ?? "",
      fileUrl: json['fileUrl'],
      category: json['category'],
      amount: json['amount'],
      status: json['status'],
      mainFileUrl: json['mainFileUrl'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'date': date,
      'imgUrl': imgUrl,
      'note': note,
      'fileUrl': fileUrl,
      'type': type.toString(),
      'category': category.toString(),
      'amount': amount,
      'status': status,
      'mainFileUrl': mainFileUrl,
    };
  }
}
