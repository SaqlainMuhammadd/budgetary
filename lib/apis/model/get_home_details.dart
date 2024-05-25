// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetHomeDetails {
  String? status;
  Data? data;
  GetHomeDetails({
    this.status,
    this.data,
  });

  GetHomeDetails copyWith({
    String? status,
    Data? data,
  }) {
    return GetHomeDetails(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'data': data?.toMap(),
    };
  }

  factory GetHomeDetails.fromMap(Map<String, dynamic> map) {
    return GetHomeDetails(
      status: map['status'] != null ? map['status'] as String : null,
      data: map['data'] != null
          ? Data.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetHomeDetails.fromJson(String source) =>
      GetHomeDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetHomeDetails(status: $status, data: $data)';

  @override
  bool operator ==(covariant GetHomeDetails other) {
    if (identical(this, other)) return true;

    return other.status == status && other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}

class Data {
  double? balance;
  String? currency;
  double? totalIncome;
  double? totalExpense;
  Data({
    this.balance,
    this.currency,
    this.totalIncome,
    this.totalExpense,
  });

  Data copyWith({
    double? balance,
    String? currency,
    double? totalIncome,
    double? totalExpense,
  }) {
    return Data(
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'balance': balance,
      'currency': currency,
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      balance: map['balance'] != null ? map['balance'] as double : null,
      currency: map['currency'] != null ? map['currency'] as String : null,
      totalIncome:
          map['totalIncome'] != null ? map['totalIncome'] as double : null,
      totalExpense:
          map['totalExpense'] != null ? map['totalExpense'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(balance: $balance, currency: $currency, totalIncome: $totalIncome, totalExpense: $totalExpense)';
  }

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.balance == balance &&
        other.currency == currency &&
        other.totalIncome == totalIncome &&
        other.totalExpense == totalExpense;
  }

  @override
  int get hashCode {
    return balance.hashCode ^
        currency.hashCode ^
        totalIncome.hashCode ^
        totalExpense.hashCode;
  }
}
