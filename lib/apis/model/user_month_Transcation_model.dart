// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserMonthTransaction {
  String? status;
  List<Data>? data;
  UserMonthTransaction({
    this.status,
    this.data,
  });

  UserMonthTransaction copyWith({
    String? status,
    List<Data>? data,
  }) {
    return UserMonthTransaction(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'data': data!.map((x) => x.toMap()).toList(),
    };
  }

  factory UserMonthTransaction.fromMap(Map<String, dynamic> map) {
    return UserMonthTransaction(
      status: map['status'] != null ? map['status'] as String : null,
      data: map['data'] != null
          ? List<Data>.from(
              (map['data'] as List<dynamic>).map<Data?>(
                (x) => Data.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserMonthTransaction.fromJson(String source) =>
      UserMonthTransaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserMonthTransaction(status: $status, data: $data)';

  @override
  bool operator ==(covariant UserMonthTransaction other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}

class Data {
  String? month;
  List<Transactions>? transactions;
  Data({
    this.month,
    this.transactions,
  });

  Data copyWith({
    String? month,
    List<Transactions>? transactions,
  }) {
    return Data(
      month: month ?? this.month,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'month': month,
      'transactions': transactions!.map((x) => x.toMap()).toList(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      month: map['month'] != null ? map['month'] as String : null,
      transactions: map['transactions'] != null
          ? List<Transactions>.from(
              (map['transactions'] as List<dynamic>).map<Transactions?>(
                (x) => Transactions.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Data(month: $month, transactions: $transactions)';

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.month == month && listEquals(other.transactions, transactions);
  }

  @override
  int get hashCode => month.hashCode ^ transactions.hashCode;
}

class Transactions {
  String? name;
  double? amount;
  String? note;
  String? dateTime;
  int? type;
  String? imageUrl;
  String? file;
  String? category;
  Transactions({
    this.name,
    this.amount,
    this.note,
    this.dateTime,
    this.type,
    this.imageUrl,
    this.file,
    this.category,
  });

  Transactions copyWith({
    String? name,
    double? amount,
    String? note,
    String? dateTime,
    int? type,
    String? imageUrl,
    String? file,
    String? category,
  }) {
    return Transactions(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      file: file ?? this.file,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'amount': amount,
      'note': note,
      'dateTime': dateTime,
      'type': type,
      'imageUrl': imageUrl,
      'file': file,
      'category': category,
    };
  }

  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions(
      name: map['name'] != null ? map['name'] as String : null,
      amount: map['amount'] != null ? map['amount'] as double : null,
      note: map['note'] != null ? map['note'] as String : null,
      dateTime: map['dateTime'] != null ? map['dateTime'] as String : null,
      type: map['type'] != null ? map['type'] as int : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      file: map['file'] != null ? map['file'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transactions.fromJson(String source) =>
      Transactions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transactions(name: $name, amount: $amount, note: $note, dateTime: $dateTime, type: $type, imageUrl: $imageUrl, file: $file, category: $category)';
  }

  @override
  bool operator ==(covariant Transactions other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.amount == amount &&
        other.note == note &&
        other.dateTime == dateTime &&
        other.type == type &&
        other.imageUrl == imageUrl &&
        other.file == file &&
        other.category == category;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        amount.hashCode ^
        note.hashCode ^
        dateTime.hashCode ^
        type.hashCode ^
        imageUrl.hashCode ^
        file.hashCode ^
        category.hashCode;
  }
}
