class BudgetResponse {
  String? status;
  List<BudgetData>? data;

  BudgetResponse({this.status, this.data});

  BudgetResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <BudgetData>[];
      json['data'].forEach((v) {
        data!.add(BudgetData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BudgetData {
  String? budgetId;
  double? amount;
  double? paidAmount;
  String? duration;
  String? category;
  String? image;
  List<BudgetTransactions>? transactions;

  BudgetData(
      {this.budgetId,
      this.amount,
      this.paidAmount,
      this.duration,
      this.category,
      this.image,
      this.transactions});

  BudgetData.fromJson(Map<String, dynamic> json) {
    budgetId = json['budgetId'];
    amount = json['amount'];
    paidAmount = json['paidAmount'];
    duration = json['duration'];
    category = json['category'];
    image = json['image'];
    if (json['transactions'] != null) {
      transactions = <BudgetTransactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(BudgetTransactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['budgetId'] = budgetId;
    data['amount'] = amount;
    data['paidAmount'] = paidAmount;
    data['duration'] = duration;
    data['category'] = category;
    data['image'] = image;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BudgetTransactions {
  String? transactionId;
  double? amount;
  String? note;
  String? date;
  String? from;

  BudgetTransactions(
      {this.transactionId, this.amount, this.note, this.date, this.from});

  BudgetTransactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    amount = json['amount'];
    note = json['note'];
    date = json['date'];
    from = json['from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transactionId'] = transactionId;
    data['amount'] = amount;
    data['note'] = note;
    data['date'] = date;
    data['from'] = from;
    return data;
  }
}
