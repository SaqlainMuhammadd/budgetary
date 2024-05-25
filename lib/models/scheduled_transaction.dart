class ScheduleTransactionModel {
  String? status;
  List<ScheduleTransactionData>? data;

  ScheduleTransactionModel({this.status, this.data});

  ScheduleTransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ScheduleTransactionData>[];
      json['data'].forEach((v) {
        data!.add(new ScheduleTransactionData.fromJson(v));
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

class ScheduleTransactionData {
  String? name;
  double? amount;
  String? note;
  String? dateTime;
  int? type;
  String? imageUrl;
  String? file;
  String? category;
  Schedule? schedule;

  ScheduleTransactionData(
      {this.name,
      this.amount,
      this.note,
      this.dateTime,
      this.type,
      this.imageUrl,
      this.file,
      this.category,
      this.schedule});

  ScheduleTransactionData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    note = json['note'];
    dateTime = json['dateTime'];
    type = json['type'];
    imageUrl = json['imageUrl'];
    file = json['file'];
    category = json['category'];
    schedule = json['schedule'] != null
        ? new Schedule.fromJson(json['schedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['dateTime'] = this.dateTime;
    data['type'] = this.type;
    data['imageUrl'] = this.imageUrl;
    data['file'] = this.file;
    data['category'] = this.category;
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.toJson();
    }
    return data;
  }
}

class Schedule {
  String? from;
  int? days;
  int? repeats;
  int? not;
  String? secondDateTime;

  Schedule({this.from, this.days, this.repeats, this.not, this.secondDateTime});

  Schedule.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    days = json['days'];
    repeats = json['repeats'];
    not = json['not'];
    secondDateTime = json['secondDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['days'] = this.days;
    data['repeats'] = this.repeats;
    data['not'] = this.not;
    data['secondDateTime'] = this.secondDateTime;
    return data;
  }
}
