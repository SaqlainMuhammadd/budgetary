// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CatagoryModel {
  String? name;
  String? id;
  List<dynamic>? subcatagories;
  String? image;
  CatagoryModel({
    this.name,
    this.id,
    this.subcatagories,
    this.image,
  });

  CatagoryModel copyWith({
    String? name,
    String? id,
    List<dynamic>? subcatagories,
    String? image,
  }) {
    return CatagoryModel(
      name: name ?? this.name,
      id: id ?? this.id,
      subcatagories: subcatagories ?? this.subcatagories,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'subcatagories': subcatagories,
      'image': image,
    };
  }

  factory CatagoryModel.fromMap(Map<String, dynamic> map) {
    return CatagoryModel(
      name: map['name'] != null ? map['name'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      subcatagories: map['subcatagories'] != null
          ? List<dynamic>.from((map['subcatagories'] as List<dynamic>)
              .map((e) => SubCatagoriesModel.fromMap(e)))
          : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CatagoryModel.fromJson(String source) =>
      CatagoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CatagoryModel(name: $name, id: $id, subcatagories: $subcatagories, image: $image)';
  }

  @override
  bool operator ==(covariant CatagoryModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        listEquals(other.subcatagories, subcatagories) &&
        other.image == image;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        subcatagories.hashCode ^
        image.hashCode;
  }
}

class SubCatagoriesModel {
  String? name;
  String? id;
  String? image;
  String? maincatagory;
  String? maincatagoryId;
  SubCatagoriesModel({
    required this.name,
    required this.id,
    required this.image,
    required this.maincatagory,
    required this.maincatagoryId,
  });

  SubCatagoriesModel copyWith({
    String? name,
    String? id,
    String? image,
    String? maincatagory,
    String? maincatagoryId,
  }) {
    return SubCatagoriesModel(
      name: name ?? this.name,
      id: id ?? this.id,
      image: image ?? this.image,
      maincatagory: maincatagory ?? this.maincatagory,
      maincatagoryId: maincatagoryId ?? this.maincatagoryId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'image': image,
      'maincatagory': maincatagory,
      'maincatagoryId': maincatagoryId,
    };
  }

  factory SubCatagoriesModel.fromMap(Map<String, dynamic> map) {
    return SubCatagoriesModel(
      name: map['name'] != null ? map['name'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      maincatagory:
          map['maincatagory'] != null ? map['maincatagory'] as String : null,
      maincatagoryId: map['maincatagoryId'] != null
          ? map['maincatagoryId'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCatagoriesModel.fromJson(String source) =>
      SubCatagoriesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubCatagoriesModel(name: $name, id: $id, image: $image, maincatagory: $maincatagory, maincatagoryId: $maincatagoryId)';
  }

  @override
  bool operator ==(covariant SubCatagoriesModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.image == image &&
        other.maincatagory == maincatagory &&
        other.maincatagoryId == maincatagoryId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        image.hashCode ^
        maincatagory.hashCode ^
        maincatagoryId.hashCode;
  }
}
