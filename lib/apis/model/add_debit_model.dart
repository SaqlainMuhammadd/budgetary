class DebitCreditModel {
  String? status;
  List<DebitCreditData>? data;

  DebitCreditModel({this.status, this.data});

  DebitCreditModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DebitCreditData>[];
      json['data'].forEach((v) {
        data!.add(new DebitCreditData.fromJson(v));
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

class DebitCreditData {
  double? amount;
  String? note;
  String? date;
  String? payBackDate;
  double? paidAmount;
  int? type;
  String? id;
  String? person;
  String? files;
  String? category;
  List<DebitCreditTransactions>? transactions;

  DebitCreditData(
      {this.amount,
      this.note,
      this.date,
      this.payBackDate,
      this.paidAmount,
      this.type,
      this.id,
      this.person,
      this.files,
      this.category,
      this.transactions});

  DebitCreditData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    note = json['note'];
    date = json['date'];
    payBackDate = json['payBackDate'];
    paidAmount = json['paidAmount'];
    type = json['type'];
    id = json['id'];
    person = json['person'];
    files = json['files'];
    category = json['category'];
    if (json['transactions'] != null) {
      transactions = <DebitCreditTransactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new DebitCreditTransactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['date'] = this.date;
    data['payBackDate'] = this.payBackDate;
    data['paidAmount'] = this.paidAmount;
    data['type'] = this.type;
    data['id'] = this.id;
    data['person'] = this.person;
    data['files'] = this.files;
    data['category'] = this.category;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DebitCreditTransactions {
  String? date;
  double? amount;
  String? note;

  DebitCreditTransactions({this.date, this.amount, this.note});

  DebitCreditTransactions.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['note'] = this.note;
    return data;
  }
}
