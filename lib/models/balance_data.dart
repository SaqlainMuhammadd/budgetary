class BalanceData {
  final String balanceType;
  final double balance;
  final DateTime currentDate;
  final DateTime dueDate;
  final String person;

  BalanceData(
      {required this.balanceType,
      required this.balance,
      required this.currentDate,
      required this.dueDate,
      required this.person});
}
