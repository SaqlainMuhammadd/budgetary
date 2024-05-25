// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserLineGraphModel {
  String? status;
  List<int>? data;
  UserLineGraphModel({
    this.status,
    this.data,
  });

  UserLineGraphModel copyWith({
    String? status,
    List<int>? data,
  }) {
    return UserLineGraphModel(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'data': data,
    };
  }

  factory UserLineGraphModel.fromMap(Map<String, dynamic> map) {
    return UserLineGraphModel(
      status: map['status'] != null ? map['status'] as String : null,
      data: map['data'] != null
          ? List<int>.from((map['data'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLineGraphModel.fromJson(String source) =>
      UserLineGraphModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserLineGraphModel(status: $status, data: $data)';

  @override
  bool operator ==(covariant UserLineGraphModel other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}
