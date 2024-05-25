// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? id;
  final String fname;
  final String email;
  UserModel({
    this.id,
    required this.fname,
    required this.email,
  });

  UserModel copyWith({
    String? id,
    String? fname,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      fname: fname ?? this.fname,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fname': fname,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      fname: map['fname'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(id: $id, fname: $fname, email: $email)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.fname == fname && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ fname.hashCode ^ email.hashCode;
}
