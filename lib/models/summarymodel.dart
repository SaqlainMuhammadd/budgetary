// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SummaryModel {
  String? status;
  List<Data>? data;
  SummaryModel({
    this.status,
    this.data,
  });

  SummaryModel copyWith({
    String? status,
    List<Data>? data,
  }) {
    return SummaryModel(
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

  factory SummaryModel.fromMap(Map<String, dynamic> map) {
    return SummaryModel(
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

  factory SummaryModel.fromJson(String source) =>
      SummaryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SummaryModel(status: $status, data: $data)';

  @override
  bool operator ==(covariant SummaryModel other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}

class Data {
  String? month;
  Transactions? transactions;
  Data({
    this.month,
    this.transactions,
  });

  Data copyWith({
    String? month,
    Transactions? transactions,
  }) {
    return Data(
      month: month ?? this.month,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'month': month,
      'transactions': transactions?.toMap(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      month: map['month'] != null ? map['month'] as String : null,
      transactions: map['transactions'] != null
          ? Transactions.fromMap(map['transactions'] as Map<String, dynamic>)
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

    return other.month == month && other.transactions == transactions;
  }

  @override
  int get hashCode => month.hashCode ^ transactions.hashCode;
}

class Transactions {
  double? income;
  double? expense;
  Transactions({
    this.income,
    this.expense,
  });

  Transactions copyWith({
    double? income,
    double? expense,
  }) {
    return Transactions(
      income: income ?? this.income,
      expense: expense ?? this.expense,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'income': income,
      'expense': expense,
    };
  }

  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions(
      income: map['income'] != null ? map['income'] as double : null,
      expense: map['expense'] != null ? map['expense'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transactions.fromJson(String source) =>
      Transactions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Transactions(income: $income, expense: $expense)';

  @override
  bool operator ==(covariant Transactions other) {
    if (identical(this, other)) return true;

    return other.income == income && other.expense == expense;
  }

  @override
  int get hashCode => income.hashCode ^ expense.hashCode;
}
