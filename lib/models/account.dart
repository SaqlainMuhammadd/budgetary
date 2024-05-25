class Account {
  final String id;
  final String name;
  double amount;
  final String currency;
  final String note;
  final bool transferred;

  Account({
    required this.id,
    required this.name,
    required this.amount,
    required this.currency,
    required this.note,
    required this.transferred,
  });

  factory Account.fromJson(Map<String, dynamic> json, String id) {
    return Account(
        name: json['name'],
        amount: json['amount'].toDouble(),
        currency: json['currency'],
        note: json['notes'],
        transferred: json['transferred'],
        id: json['name'] == "Budgetary" ? "69" : id);
  }
}
