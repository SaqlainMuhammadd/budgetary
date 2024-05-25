import 'package:cloud_firestore/cloud_firestore.dart';

class CurrencyData {
  static CurrencyData? _instance;
  String? _currency;

  factory CurrencyData() {
    _instance ??= CurrencyData._internal();
    return _instance!;
  }

  CurrencyData._internal();

  Future<String?> fetchCurrency(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('UserTransactions')
            .doc(userId).collection("data").doc("userData").get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data()!;
      _currency = data['currency'];
    }
    return _currency;
  }

  String? get currency {
    return _currency;
  }
}
