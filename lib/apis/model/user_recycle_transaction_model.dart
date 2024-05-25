// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserRecycleTransaction {
  String? status;
  List<Data>? data;
  UserRecycleTransaction({
    this.status,
    this.data,
  });

  UserRecycleTransaction copyWith({
    String? status,
    List<Data>? data,
  }) {
    return UserRecycleTransaction(
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

  factory UserRecycleTransaction.fromMap(Map<String, dynamic> map) {
    return UserRecycleTransaction(
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

  factory UserRecycleTransaction.fromJson(String source) =>
      UserRecycleTransaction.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserRecycleTransaction(status: $status, data: $data)';

  @override
  bool operator ==(covariant UserRecycleTransaction other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}

class Data {
  String? name;
  double? amount;
  String? note;
  String? dateTime;
  String? files;
  int? type;
  String? transactionId;
  String? imageUrl;
  String? category;
  Data({
    this.name,
    this.amount,
    this.note,
    this.dateTime,
    this.files,
    this.type,
    this.transactionId,
    this.imageUrl,
    this.category,
  });

  Data copyWith({
    String? name,
    double? amount,
    String? note,
    String? dateTime,
    String? files,
    int? type,
    String? transactionId,
    String? imageUrl,
    String? category,
  }) {
    return Data(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      dateTime: dateTime ?? this.dateTime,
      files: files ?? this.files,
      type: type ?? this.type,
      transactionId: transactionId ?? this.transactionId,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'amount': amount,
      'note': note,
      'dateTime': dateTime,
      'files': files,
      'type': type,
      'transactionId': transactionId,
      'imageUrl': imageUrl,
      'category': category,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      name: map['name'] != null ? map['name'] as String : null,
      amount: map['amount'] != null ? map['amount'] as double : null,
      note: map['note'] != null ? map['note'] as String : null,
      dateTime: map['dateTime'] != null ? map['dateTime'] as String : null,
      files: map['files'] != null ? map['files'] as String : null,
      type: map['type'] != null ? map['type'] as int : null,
      transactionId:
          map['transactionId'] != null ? map['transactionId'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(name: $name, amount: $amount, note: $note, dateTime: $dateTime, files: $files, type: $type, transactionId: $transactionId, imageUrl: $imageUrl, category: $category)';
  }

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.amount == amount &&
        other.note == note &&
        other.dateTime == dateTime &&
        other.files == files &&
        other.type == type &&
        other.transactionId == transactionId &&
        other.imageUrl == imageUrl &&
        other.category == category;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        amount.hashCode ^
        note.hashCode ^
        dateTime.hashCode ^
        files.hashCode ^
        type.hashCode ^
        transactionId.hashCode ^
        imageUrl.hashCode ^
        category.hashCode;
  }
}
