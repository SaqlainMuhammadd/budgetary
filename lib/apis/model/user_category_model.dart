// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserCategoryModel {
  String? name;
  String? type;
  String? parentId;
  String? imageUrl;
  UserCategoryModel({
    this.name,
    this.type,
    this.parentId,
    this.imageUrl,
  });

  UserCategoryModel copyWith({
    String? name,
    String? type,
    String? parentId,
    String? imageUrl,
  }) {
    return UserCategoryModel(
      name: name ?? this.name,
      type: type ?? this.type,
      parentId: parentId ?? this.parentId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'parentId': parentId,
      'imageUrl': imageUrl,
    };
  }

  factory UserCategoryModel.fromMap(Map<String, dynamic> map) {
    return UserCategoryModel(
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCategoryModel.fromJson(String source) =>
      UserCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserCategoryModel(name: $name, type: $type, parentId: $parentId, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant UserCategoryModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.type == type &&
        other.parentId == parentId &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        type.hashCode ^
        parentId.hashCode ^
        imageUrl.hashCode;
  }
}
