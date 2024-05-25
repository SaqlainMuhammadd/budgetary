class GetTransActionTypeModel {
  String? status;
  List<GetTransActionTypeData>? data;

  GetTransActionTypeModel({this.status, this.data});

  GetTransActionTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <GetTransActionTypeData>[];
      json['data'].forEach((v) {
        data!.add(new GetTransActionTypeData.fromJson(v));
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

class GetTransActionTypeData {
  String? name;
  double? amount;
  String? note;
  String? dateTime;
  String? files;
  String? category;

  GetTransActionTypeData(
      {this.name,
      this.amount,
      this.note,
      this.dateTime,
      this.files,
      this.category});

  GetTransActionTypeData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    note = json['note'];
    dateTime = json['dateTime'];
    files = json['files'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['dateTime'] = this.dateTime;
    data['files'] = this.files;
    data['category'] = this.category;
    return data;
  }
}
