import 'package:flutter/foundation.dart';

import '../models/selectedItemdata.dart';

class SelectedItemProvider extends ChangeNotifier {
  SelectedItemData? _selectedItem;

  SelectedItemData? get selectedItem => _selectedItem;

  void setSelectedItem(SelectedItemData? item) {
    _selectedItem = item;
    notifyListeners();
  }
}
