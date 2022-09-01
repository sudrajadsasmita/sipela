import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/toko_model.dart';

class TokoDetailProvider with ChangeNotifier {
  int? _tokoId;

  int get tokoId => _tokoId!;

  set tokoId(int newTokoId) {
    _tokoId = newTokoId;
    notifyListeners();
  }
}
