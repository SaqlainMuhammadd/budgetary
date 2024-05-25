// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserWalletModel {
  String? status;
  List<Data>? data;
  UserWalletModel({
    this.status,
    this.data,
  });

  UserWalletModel copyWith({
    String? status,
    List<Data>? data,
  }) {
    return UserWalletModel(
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

  factory UserWalletModel.fromMap(Map<String, dynamic> map) {
    return UserWalletModel(
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

  factory UserWalletModel.fromJson(String source) =>
      UserWalletModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserWalletModel(status: $status, data: $data)';

  @override
  bool operator ==(covariant UserWalletModel other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}

class Data {
  String? name;
  double? amount;
  String? currency;
  String? note;
  String? walletId;
  bool? transferred;
  Data({
    this.name,
    this.amount,
    this.currency,
    this.note,
    this.walletId,
    this.transferred,
  });

  Data copyWith({
    String? name,
    double? amount,
    String? currency,
    String? note,
    String? walletId,
    bool? transferred,
  }) {
    return Data(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      note: note ?? this.note,
      walletId: walletId ?? this.walletId,
      transferred: transferred ?? this.transferred,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'amount': amount,
      'currency': currency,
      'note': note,
      'walletId': walletId,
      'transferred': transferred,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      name: map['name'] != null ? map['name'] as String : null,
      amount: map['amount'] != null ? map['amount'] as double : null,
      currency: map['currency'] != null ? map['currency'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      walletId: map['walletId'] != null ? map['walletId'] as String : null,
      transferred:
          map['transferred'] != null ? map['transferred'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(name: $name, amount: $amount, currency: $currency, note: $note, walletId: $walletId, transferred: $transferred)';
  }

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.amount == amount &&
        other.currency == currency &&
        other.note == note &&
        other.walletId == walletId &&
        other.transferred == transferred;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        amount.hashCode ^
        currency.hashCode ^
        note.hashCode ^
        walletId.hashCode ^
        transferred.hashCode;
  }
}
