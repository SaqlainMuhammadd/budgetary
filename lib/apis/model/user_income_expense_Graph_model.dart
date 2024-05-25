// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserIncomeExpenceGraphModel {
  String? status;
  List<Data>? data;
  UserIncomeExpenceGraphModel({
    this.status,
    this.data,
  });

  UserIncomeExpenceGraphModel copyWith({
    String? status,
    List<Data>? data,
  }) {
    return UserIncomeExpenceGraphModel(
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

  factory UserIncomeExpenceGraphModel.fromMap(Map<String, dynamic> map) {
    return UserIncomeExpenceGraphModel(
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

  factory UserIncomeExpenceGraphModel.fromJson(String source) =>
      UserIncomeExpenceGraphModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserIncomeExpenceGraphModel(status: $status, data: $data)';

  @override
  bool operator ==(covariant UserIncomeExpenceGraphModel other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}

class Data {
  double? income;
  double? expense;
  Data({
    this.income,
    this.expense,
  });

  Data copyWith({
    double? income,
    double? expense,
  }) {
    return Data(
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

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      income: map['income'] != null ? map['income'] as double : null,
      expense: map['expense'] != null ? map['expense'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Data(income: $income, expense: $expense)';

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.income == income && other.expense == expense;
  }

  @override
  int get hashCode => income.hashCode ^ expense.hashCode;
}
