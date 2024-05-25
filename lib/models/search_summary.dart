// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SearchSummary {
  String? status;
  List<Data>? data;
  SearchSummary({
    this.status,
    this.data,
  });

  SearchSummary copyWith({
    String? status,
    List<Data>? data,
  }) {
    return SearchSummary(
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

  factory SearchSummary.fromMap(Map<String, dynamic> map) {
    return SearchSummary(
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

  factory SearchSummary.fromJson(String source) =>
      SearchSummary.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SearchSummary(status: $status, data: $data)';

  @override
  bool operator ==(covariant SearchSummary other) {
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
  String? categoryImageUrl;
  String? categoryName;
  Data({
    this.name,
    this.amount,
    this.note,
    this.dateTime,
    this.files,
    this.type,
    this.transactionId,
    this.categoryImageUrl,
    this.categoryName,
  });

  Data copyWith({
    String? name,
    double? amount,
    String? note,
    String? dateTime,
    String? files,
    int? type,
    String? transactionId,
    String? categoryImageUrl,
    String? categoryName,
  }) {
    return Data(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      dateTime: dateTime ?? this.dateTime,
      files: files ?? this.files,
      type: type ?? this.type,
      transactionId: transactionId ?? this.transactionId,
      categoryImageUrl: categoryImageUrl ?? this.categoryImageUrl,
      categoryName: categoryName ?? this.categoryName,
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
      'categoryImageUrl': categoryImageUrl,
      'categoryName': categoryName,
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
      categoryImageUrl: map['categoryImageUrl'] != null
          ? map['categoryImageUrl'] as String
          : null,
      categoryName:
          map['categoryName'] != null ? map['categoryName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(name: $name, amount: $amount, note: $note, dateTime: $dateTime, files: $files, type: $type, transactionId: $transactionId, categoryImageUrl: $categoryImageUrl, categoryName: $categoryName)';
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
        other.categoryImageUrl == categoryImageUrl &&
        other.categoryName == categoryName;
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
        categoryImageUrl.hashCode ^
        categoryName.hashCode;
  }
}
