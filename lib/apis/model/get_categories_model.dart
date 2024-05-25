class GetCategoriesModel {
  String? status;
  List<Data>? data;

  GetCategoriesModel({this.status, this.data});

  GetCategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? categoryId;
  String? imageUrl;
  String? type;
  List<Child>? child;

  Data({this.name, this.categoryId, this.imageUrl, this.type, this.child});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    categoryId = json['categoryId'];
    imageUrl = json['imageUrl'];
    type = json['type'];
    if (json['child'] != null) {
      child = <Child>[];
      json['child'].forEach((v) {
        child!.add(new Child.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['categoryId'] = this.categoryId;
    data['imageUrl'] = this.imageUrl;
    data['type'] = this.type;
    if (this.child != null) {
      data['child'] = this.child!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Child {
  String? name;
  String? categoryId;
  String? imageUrl;
  String? type;

  Child({this.name, this.categoryId, this.imageUrl, this.type});

  Child.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    categoryId = json['categoryId'];
    imageUrl = json['imageUrl'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['categoryId'] = this.categoryId;
    data['imageUrl'] = this.imageUrl;
    data['type'] = this.type;
    return data;
  }
}
