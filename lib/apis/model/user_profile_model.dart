// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfileModel {
  String? status;
  Data? data;
  UserProfileModel({
    this.status,
    this.data,
  });

  UserProfileModel copyWith({
    String? status,
    Data? data,
  }) {
    return UserProfileModel(
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

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      status: map['status'] != null ? map['status'] as String : null,
      data: map['data'] != null
          ? Data.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserProfileModel(status: $status, data: $data)';

  @override
  bool operator ==(covariant UserProfileModel other) {
    if (identical(this, other)) return true;

    return other.status == status && other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}

class Data {
  String? userId;
  String? name;
  String? email;
  Data({
    this.userId,
    this.name,
    this.email,
  });

  Data copyWith({
    String? userId,
    String? name,
    String? email,
  }) {
    return Data(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      userId: map['userId'] != null ? map['userId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Data(userId: $userId, name: $name, email: $email)';

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.name == name && other.email == email;
  }

  @override
  int get hashCode => userId.hashCode ^ name.hashCode ^ email.hashCode;
}
